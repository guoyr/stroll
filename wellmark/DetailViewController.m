//
//  LLDetailViewController.m
//  wellmark
//
//  Created by SunDu on 10/18/13.
//  Copyright (c) 2013 Stroll. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController
@synthesize methodName;
@synthesize methodLabel;
@synthesize webView;
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
    //methodLabel.text = methodName;
    NSURL *url;
    if ([methodName  isEqual: @"CT Scan"]) {
        url = [NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:@"about.html" ofType:nil]];
    }
    if ([methodName  isEqual: @"MRI Scan"]) {
        url = [NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:@"about1.html" ofType:nil]];
    }
    //else {
    //    url = [NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:@"about.html" ofType:nil]];
   // }
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
