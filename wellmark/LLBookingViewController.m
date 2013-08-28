//
//  LLBookingViewController.m
//  wellmark
//
//  Created by Robert Guo on 8/27/13.
//  Copyright (c) 2013 Stroll. All rights reserved.
//

#import "LLBookingViewController.h"

@interface LLBookingViewController ()

@end

@implementation LLBookingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [_doctorAddress setText:[_providerInformation objectForKey:@"Address"]];
    [_doctorNumber setText:[_providerInformation objectForKey:@"Phone"]];
    [_treatmentLabel setText:_treatment];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
