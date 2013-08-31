//
//  LLConfirmedViewController.m
//  wellmark
//
//  Created by Robert Guo on 8/27/13.
//  Copyright (c) 2013 Stroll. All rights reserved.
//

#import "LLConfirmedViewController.h"
#import "LLTreatmentManager.h"

@interface LLConfirmedViewController ()

@end

@implementation LLConfirmedViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [[LLTreatmentManager sharedInstance] addBackground:[self view]];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
