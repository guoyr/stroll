//
//  LLSchedulingViewController.m
//  wellmark
//
//  Created by Robert Guo on 8/27/13.
//  Copyright (c) 2013 Stroll. All rights reserved.
//

#import "LLSchedulingViewController.h"
#import "LLBookingViewController.h"
#import "LLTreatmentManager.h"

@interface LLSchedulingViewController ()

@end

@implementation LLSchedulingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self setTitle:[NSString stringWithFormat:@"Select Scheduling Options for %@", [[LLTreatmentManager sharedInstance] patientName]]];
    [[_bookNow layer] setCornerRadius:5];
    [[_bookLater layer] setCornerRadius:5];
    [[_bookUpFront layer] setCornerRadius:5];
    [[_schedulingOptionsLabel layer] setCornerRadius:5];



}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)bookNowClicked:(id)sender
{
    [self performSegueWithIdentifier:@"showBookingInformation" sender:self];
}

- (IBAction)bookLaterClicked:(id)sender
{
    [self performSegueWithIdentifier:@"showBookLater" sender:self];
}

@end
