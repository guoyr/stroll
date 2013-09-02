//
//  LLLocationsViewController.m
//  wellmark
//
//  Created by Robert Guo on 8/27/13.
//  Copyright (c) 2013 Stroll. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "MBJSONRequest.h"

#import "LLLocationsViewController.h"
#import "LLSchedulingViewController.h"
#import "LLTreatmentManager.h"

#define LOCATION_CARD_H_MARGIN 10
#define LOCATION_CARD_V_MARGIN 10

#define CURRENT_LOCATION_INDEX 0
#define CITY_HALL_INDEX 1
#define WEST_INDEX 2

@interface LLLocationsViewController ()

@property (nonatomic, strong) NSMutableArray *providers;
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) MBJSONRequest *jsonRequest;
@property (nonatomic, strong) UIImageView *logoView;

@end

@implementation LLLocationsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self setTitle:[NSString stringWithFormat:@"Select Location for %@", [[LLTreatmentManager sharedInstance] patientName]]];
    [[_treatmentLabel layer] setCornerRadius:5];
    [_treatmentLabel setText:[[LLTreatmentManager sharedInstance] selectedTreatment]];
    //TODO: title name - treatment
    [[LLTreatmentManager sharedInstance] addBackground:[self view]];
    
    _logoView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"wellmark_logo.png"]];
    [_logoView setCenter:CGPointMake(900, 45)];
    [[self view] addSubview:_logoView];
    
    NSString *locations = [[NSUserDefaults standardUserDefaults] stringForKey:@"location_preference"];
    NSLog(@"%@",locations);
    
    
    [self startStandardUpdates];
    
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

-(void)viewWillDisappear:(BOOL)animated
{
    if (_jsonRequest && [_jsonRequest isRunning]) {
        [_jsonRequest cancel];
    }
}

- (void)getProviderDataForLocation:(CLLocation *)location
{
    if (_jsonRequest && ![_jsonRequest isCancelled]) {
        return;
    }
    
    CLLocationCoordinate2D coord = [location coordinate];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://carefinder-dev.cloudapp.net/carefinder.svc/providersnearlocation?p=1&lat=%f&lng=%f&r=25&sv=dist&o=asc&ps=5&key=81BA5", coord.latitude, coord.longitude]];
    NSLog(@"%@",url);
    
    _jsonRequest = [[MBJSONRequest alloc] init];
    [_jsonRequest performJSONRequest:[NSURLRequest requestWithURL:url] completionHandler:^(id responseJSON, NSError *error) {
        if (error != nil) {
            NSLog(@"Error requesting top-rated videos: %@", error);
        } else {
            _providers = [responseJSON objectForKey:@"Providers"];
            [self showProviders];
        }
    }];
}

-(void)showProviders
{
    [[_scrollView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    int curX = LOCATION_CARD_H_MARGIN, curY = LOCATION_CARD_V_MARGIN;
    float dummyPrice = 0.0;
    for (int i = 0; i < [_providers count]; i++) {
        NSDictionary *provider = [_providers objectAtIndex:i];
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
        LLLocationView *curLocationView = [[LLLocationView alloc] initWithFrame:CGRectMake(curX, curY, LOCATION_CARD_WIDTH, 500)];
        [curLocationView addGestureRecognizer:tapGestureRecognizer];
        [curLocationView setProviderAltName:[provider objectForKey:@"AltName"]];
        [curLocationView setProviderDistance:[provider objectForKey:@"Distance"]];
        [curLocationView setPrice:dummyPrice];
        dummyPrice += rand() % 100;
        [curLocationView setIndex:i];
        [[self scrollView] addSubview:curLocationView];
        curX += LOCATION_CARD_H_MARGIN + LOCATION_CARD_WIDTH;
    }
    [[self scrollView] setContentSize:CGSizeMake(curX, LOCATION_CARD_HEIGHT + LOCATION_CARD_V_MARGIN * 2)];
}

-(void)viewTapped:(id)sender
{
    NSDictionary *providerInfo = [_providers objectAtIndex:[(LLLocationView *)[sender view] index]];
    [[LLTreatmentManager sharedInstance] setProviderInformation:providerInfo];
    [self performSegueWithIdentifier:@"ShowSchedulingOptions" sender:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
