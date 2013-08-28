//
//  LLLocationsViewController.m
//  wellmark
//
//  Created by Robert Guo on 8/27/13.
//  Copyright (c) 2013 Stroll. All rights reserved.
//

#import "LLLocationsViewController.h"
#import "MBJSONRequest.h"
#import "LLSchedulingViewController.h"

@interface LLLocationsViewController ()

@property (nonatomic, strong) NSMutableArray *providers;
@property (nonatomic, strong) NSDictionary *providerInformation;
@property (nonatomic, strong) CLLocationManager *locationManager;

@end

@implementation LLLocationsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [[self scrollView] setBackgroundColor:[UIColor redColor]];
    [self setTitle:[NSString stringWithFormat:@"Select Location for %@", _patientName]];
    [self startStandardUpdates];
    //TODO: title name - treatment
    
    
}

- (void)startStandardUpdates
{
    // Create the location manager if this object does not
    // already have one.
    if (nil == _locationManager)
        _locationManager = [[CLLocationManager alloc] init];
    
    _locationManager.delegate = self;
    _locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
    
    // Set a movement threshold for new events.
    _locationManager.distanceFilter = 500;
    
    [_locationManager startUpdatingLocation];
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *curLocation = [locations lastObject];
    [self getProviderDataForLocation:curLocation];

    
}

- (void)getProviderDataForLocation:(CLLocation *)location
{
    [[_scrollView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    CLLocationCoordinate2D coord = [location coordinate];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://carefinder-dev.cloudapp.net/carefinder.svc/providersnearlocation?p=1&lat=%f&lng=%f&r=10&if=1&n=P0HI0WY9J5&sv=dist&o=asc&ps=5&key=81BA5", coord.latitude, coord.longitude]];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    MBJSONRequest *jsonRequest = [[MBJSONRequest alloc] init];
    [jsonRequest performJSONRequest:urlRequest completionHandler:^(id responseJSON, NSError *error) {
        if (error != nil) {
            NSLog(@"Error requesting top-rated videos: %@", error);
        } else {
            _providers = [responseJSON objectForKey:@"Providers"];
            int curX = 50, curY = 10;
            for (int i = 0; i < [_providers count]; i++) {
                NSDictionary *provider = [_providers objectAtIndex:i];
                UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
                LLLocationView *curLocationView = [[LLLocationView alloc] initWithFrame:CGRectMake(curX, curY, 300, 500)];
                [curLocationView addGestureRecognizer:tapGestureRecognizer];
                [curLocationView setProviderAltName:[provider objectForKey:@"AltName"]];
                [curLocationView setIndex:i];
                [[self scrollView] addSubview:curLocationView];
                curX += 350;
            }
            [[self scrollView] setContentSize:CGSizeMake(curX, 520)];
        }
    }];
}

- (void)viewTapped:(id)sender
{
    _providerInformation = [_providers objectAtIndex:[(LLLocationView *)[sender view] index]];
    [self performSegueWithIdentifier:@"ShowSchedulingOptions" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"ShowSchedulingOptions"]) {
        LLSchedulingViewController *vc = [segue destinationViewController];
        [vc setProviderInformation:_providerInformation];
        [vc setPatientName:_patientName];
        [vc setTreatment:_treatment];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
