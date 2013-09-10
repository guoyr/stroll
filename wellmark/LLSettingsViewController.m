//
//  LLSettingsViewController.m
//  wellmark
//
//  Created by Robert Guo on 9/10/13.
//  Copyright (c) 2013 Stroll. All rights reserved.
//

#import "LLSettingsViewController.h"

@interface LLSettingsViewController ()

@property (nonatomic, assign) int curY;

@end

@implementation LLSettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _curY = 10;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [_doctorScrollView setScrollEnabled:YES];
    [_doctorScrollView setContentSize:_doctorScrollView.frame.size];
	// Do any additional setup after loading the view.
    NSMutableArray *doctors = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] arrayForKey:@"Doctors"]];
    [doctors addObject:@""];
    for (NSString *doctor in doctors) {
        UITextField *label = [[UITextField alloc] initWithFrame:CGRectMake(0, _curY, 320, 48)];
        [label setBackgroundColor:[UIColor lightTextColor]];
        [label setAlpha:0.8];
        [[label layer] setCornerRadius:5.0];
        [label setFont:[UIFont systemFontOfSize:18]];
        [label setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
        _curY += 58;
        [label setText:doctor];
        [_doctorScrollView addSubview:label];
    }
    
}

-(void)newDoctor
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
