//
//  LLViewController.m
//  wellmark
//
//  Created by Robert Guo on 9/3/13.
//  Copyright (c) 2013 Stroll. All rights reserved.
//

#import "LLViewController.h"
#import "LLTreatmentManager.h"

@interface LLViewController ()

@property (nonatomic, strong) UIImageView *backgroundView;

@end

@implementation LLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addBackground:NO];

	// Do any additional setup after loading the view.
}

-(void)addBackground:(BOOL)animated
{
    if ([_backgroundView superview]) {
        [_backgroundView removeFromSuperview];
    }

    if ([[LLTreatmentManager sharedInstance] insuranceCompany]) {
        _backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"wellmark_logo_background.png"]];

    } else {
        _backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background.png"]];

    }
    
    if (animated) {
        [_backgroundView setAlpha:0.0];
        [[self view] addSubview:_backgroundView];
        [[self view] sendSubviewToBack:_backgroundView];
        
        [UIView animateWithDuration:1.0 animations:^{
            [_backgroundView setAlpha:1.0];
        }];
    } else {
        [[self view] addSubview:_backgroundView];
        [[self view] sendSubviewToBack:_backgroundView];
        
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
