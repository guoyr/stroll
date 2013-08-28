//
//  LLSchedulingViewController.m
//  wellmark
//
//  Created by Robert Guo on 8/27/13.
//  Copyright (c) 2013 Stroll. All rights reserved.
//

#import "LLSchedulingViewController.h"
#import "LLBookingViewController.h"

@interface LLSchedulingViewController ()

@end

@implementation LLSchedulingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self setTitle:[NSString stringWithFormat:@"Select Scheduling Options for %@", _patientName]];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showBookingInformation"]) {
        LLBookingViewController *vc = [segue destinationViewController];
        [vc setProviderInformation:_providerInformation];
        [vc setTreatment:_treatment];
    }
}

- (IBAction)bookNowClicked:(id)sender
{
    [self performSegueWithIdentifier:@"showBookingInformation" sender:self];
}

@end
