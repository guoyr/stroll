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
#import "LLBookLaterViewController.h"
#import "LLWebViewController.h"
#import "LLColors.h"

@interface LLSchedulingViewController ()

//@property (strong, nonatomic)  UIButton *bookNow;
@property (strong, nonatomic)  UIButton *bookUpFront;
@property (strong, nonatomic)  UIButton *bookLater;
@property (strong, nonatomic)  UILabel *schedulingOptionsLabel;

//- (void)bookNowClicked:(id)sender;
- (void)bookLaterClicked:(id)sender;

@end

@implementation LLSchedulingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _schedulingOptionsLabel = [[UILabel alloc] initWithFrame:CGRectMake(368, 204, 289, 48)];
    [self.view addSubview:_schedulingOptionsLabel];
    [_schedulingOptionsLabel setText:@"Scheduling Options"];
    [_schedulingOptionsLabel setBackgroundColor:[UIColor blueColor]];
    _schedulingOptionsLabel.textAlignment = NSTextAlignmentCenter;
    
  //  _bookNow = [[UIButton alloc] initWithFrame:CGRectMake(261, 267, 160, 100)];
  //  [self.view addSubview:_bookNow];
  //  [_bookNow setTitle:@"Book now" forState:UIControlStateNormal];
  //  [_bookNow setBackgroundColor:TORQUOISE];
    
 //   [_bookNow addTarget:self action:@selector(bookNowClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    _bookUpFront = [[UIButton alloc] initWithFrame:CGRectMake(300, 267, 200, 100)];
    [self.view addSubview:_bookUpFront];
    [_bookUpFront setTitle:@"Book in office" forState:UIControlStateNormal];
    [_bookUpFront setBackgroundColor:TORQUOISE];
    
    _bookLater = [[UIButton alloc] initWithFrame:CGRectMake(520, 267, 200, 100)];
    [self.view addSubview:_bookLater];
    [_bookLater setTitle:@"Book on my own" forState:UIControlStateNormal];
    [_bookLater setBackgroundColor:TORQUOISE];
    
    [_bookLater addTarget:self action:@selector(bookLaterClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
	// Do any additional setup after loading the view.
    [self setTitle:[NSString stringWithFormat:@"Select Scheduling Options for %@", [[LLTreatmentManager sharedInstance] patientName]]];
//    [[_bookNow layer] setCornerRadius:5];
    [[_bookLater layer] setCornerRadius:5];
    [[_bookUpFront layer] setCornerRadius:5];
    [[_schedulingOptionsLabel layer] setCornerRadius:5];



}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (void)bookNowClicked:(id)sender
//{
//    LLWebViewController *vc = [[LLWebViewController alloc] init];
//    [self.navigationController pushViewController:vc animated:YES];
//}

- (void)bookLaterClicked:(id)sender
{
    LLBookLaterViewController *vc = [[LLBookLaterViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
