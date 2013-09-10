//
//  LLLocationsViewController.m
//  wellmark
//
//  Created by Robert Guo on 8/27/13.
//  Copyright (c) 2013 Stroll. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <CoreLocation/CoreLocation.h>
#import "MBJSONRequest.h"

#import "LLLocationsViewController.h"
#import "LLSchedulingViewController.h"
#import "LLTreatmentManager.h"

#define LOCATION_CARD_H_MARGIN 10
#define LOCATION_CARD_V_MARGIN 10

#define CITY_HALL_LOCATION [[CLLocation alloc] initWithLatitude:41.588935 longitude:-93.616862]
#define WEST_LOCATION [[CLLocation alloc] initWithLatitude:41.577058 longitude:-93.710289]
#define WELLMARK_HQ_LOCATION [[CLLocation alloc] initWithLatitude:41.592337 longitude:-93.632698]

#define CURRENT_LOCATION_INDEX 0
#define CITY_HALL_INDEX 1
#define WEST_INDEX 2
#define WELLMARK_HQ_INDEX 3

#define USE_DUMMY_DATA 1
#define USE_REAL_DATA 0

#define PROVIDER_NAME_KEY @"AltName"

@interface LLLocationsViewController ()

@property (nonatomic, strong) NSArray *providers;
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) MBJSONRequest *jsonRequest;
@property (nonatomic, strong) UIImageView *logoView;
@property (nonatomic, assign) int curLocation;

@end

@implementation LLLocationsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self setTitle:[NSString stringWithFormat:@"Select Location for %@", [[LLTreatmentManager sharedInstance] patientName]]];
    [[_treatmentLabel layer] setCornerRadius:5];
    [[_priceRangeLabel layer] setCornerRadius:5];
    [_treatmentLabel setText:[[LLTreatmentManager sharedInstance] selectedTreatment]];
    
//    _logoView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"wellmark_logo.png"]];
//    [_logoView setCenter:CGPointMake(900, 45)];
//    [[self view] addSubview:_logoView];
    
    int locationIndex = [[NSUserDefaults standardUserDefaults] integerForKey:@"location_preference"];
    _curLocation = locationIndex;
    switch (locationIndex) {
        case CURRENT_LOCATION_INDEX:
            [self startStandardUpdates];
            break;
        case CITY_HALL_INDEX:
            [self getProviderDataForLocation:CITY_HALL_LOCATION];
            break;
        case WEST_INDEX:
            [self getProviderDataForLocation:WEST_LOCATION];
            break;
        case WELLMARK_HQ_INDEX:
            [self getProviderDataForLocation:WELLMARK_HQ_LOCATION];
            break;
        default:
            NSLog(@"we shouldn't be here");
            break;
    }
    
    
    
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
    
    BOOL dataPreference = [[NSUserDefaults standardUserDefaults] boolForKey:@"data_preference"];
    if (dataPreference == USE_DUMMY_DATA) {
        NSError *jsonError = nil;
        NSString *path = [[NSBundle mainBundle] pathForResource:@"wellmark_hq_data" ofType:@"json"];

        switch (_curLocation) {
            case WELLMARK_HQ_INDEX:
                _providers = [[NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:path] options:0 error:&jsonError] objectForKey:@"Providers"];
                break;
                
            default:
                break;
        }
        [self parseProviders];
        [self showProviders];
    } else if (dataPreference == USE_REAL_DATA) {
        CLLocationCoordinate2D coord = [location coordinate];
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://carefinder-dev.cloudapp.net/carefinder.svc/providersnearlocation?p=1&lat=%f&lng=%f&if=1&r=25&sv=dist&o=asc&ps=25&key=81BA5", coord.latitude, coord.longitude]];
        NSLog(@"%@",url);
        
        _jsonRequest = [[MBJSONRequest alloc] init];
        [_jsonRequest performJSONRequest:[NSURLRequest requestWithURL:url] completionHandler:^(id responseJSON, NSError *error) {
            if (error != nil) {
                NSLog(@"Error requesting top-rated videos: %@", error);
            } else {
                _providers = [responseJSON objectForKey:@"Providers"];
                [self parseProviders];
                [self showProviders];
            }
        }];
    }
    

}

-(void)addDoctorToProvider:(NSMutableDictionary *)provider firstName:(NSString *)f middleInitial:(NSString *)m lastName:(NSString *)l
{
    if (![provider objectForKey:@"Name"]) {
        [provider setObject:[NSMutableArray array] forKey:@"Name"];
    }
    if (m) {
        [[provider objectForKey:@"Name"] addObject:[NSString stringWithFormat:@"%@ %@. %@", f, m, l]];
    } else {
        [[provider objectForKey:@"Name"] addObject:[NSString stringWithFormat:@"%@ %@", f, l]];
    }
}

-(void)parseProviders
{
    NSMutableDictionary *providers = [[NSMutableDictionary alloc] initWithCapacity:[_providers count]];
    for (int i = 0; i < [_providers count]; i++) {
        NSMutableDictionary *provider = [NSMutableDictionary dictionaryWithDictionary:[_providers objectAtIndex:i]];
        NSString *providerName = [provider objectForKey:PROVIDER_NAME_KEY];
        if ([providers objectForKey:providerName]) {
            [self addDoctorToProvider:[providers objectForKey:providerName] firstName:[provider objectForKey:@"FirstName"] middleInitial:[provider objectForKey:@"MiddleName"] lastName:[provider objectForKey:@"LastName"]];
        } else {
            [self addDoctorToProvider:provider firstName:[provider objectForKey:@"FirstName"] middleInitial:[provider objectForKey:@"MiddleName"] lastName:[provider objectForKey:@"LastName"]];
            [providers setObject:provider forKey:providerName];
        }
    }
    _providers = [providers allValues];
    
    
}

-(void)showProviders
{
    [[_scrollView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    int curX = LOCATION_CARD_H_MARGIN, curY = LOCATION_CARD_V_MARGIN;
    float dummyPrice = 0.0;
    for (int i = 0; i < [_providers count]; i++) {
        NSDictionary *provider = [_providers objectAtIndex:i];
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
        LLLocationView *curLocationView = [[LLLocationView alloc] initWithFrame:CGRectMake(curX, curY, LOCATION_CARD_WIDTH, 550)];
        [curLocationView addGestureRecognizer:tapGestureRecognizer];
        [curLocationView setProviderAltName:[provider objectForKey:@"AltName"]];
        [curLocationView setProviderDistance:[provider objectForKey:@"Distance"]];
        [curLocationView setPrice:dummyPrice];
        
        NSArray *doctors = [provider objectForKey:@"Name"];
        if ([doctors count] > 1) {
            [curLocationView setDoctorName:@"Multiple Doctors Available" isMultiple:YES];
        } else {
            [curLocationView setDoctorName:[NSString stringWithFormat:@"%@ %@", [doctors lastObject], [provider objectForKey:@"ObtainedDegrees"]] isMultiple:NO];
        }
        dummyPrice += rand() % 100;
        [curLocationView setIndex:i];
        [[self scrollView] addSubview:curLocationView];
        curX += LOCATION_CARD_H_MARGIN + LOCATION_CARD_WIDTH;
    }
    [[self scrollView] setContentSize:CGSizeMake(curX, LOCATION_CARD_HEIGHT + LOCATION_CARD_V_MARGIN * 2)];
    [_priceRangeLabel setText:[NSString stringWithFormat:@"Price Range: $%2.2f to $%2.2f", 0.0f, dummyPrice]];
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
