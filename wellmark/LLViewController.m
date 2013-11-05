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
    
    UIImageView *backgroundView;

    if ([[[LLTreatmentManager sharedInstance] insuranceCompany] isEqualToString:WELLMARK]) {
        backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"wellmark_bg.png"]];
    } else if([[[LLTreatmentManager sharedInstance] insuranceCompany] isEqualToString:MEDICARE]){
        backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background.png"]];

    }else{
        backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background.png"]];
    }
    
    void (^completion)(BOOL) = ^(BOOL finished) {
        if ([_backgroundView superview]) {
            [_backgroundView removeFromSuperview];
        }
        _backgroundView = backgroundView;
    };
    if (animated) {
        [backgroundView setAlpha:0.0];
        [[self view] addSubview:backgroundView];
        [[self view] sendSubviewToBack:backgroundView];
        
        [UIView animateWithDuration:1.0 animations:^{
            [_backgroundView setAlpha:0.0];
            [backgroundView setAlpha:1.0];
            
        } completion:^(BOOL finished){
            completion(finished);
        }];
    } else {
        [[self view] addSubview:backgroundView];
        [[self view] sendSubviewToBack:backgroundView];
        completion(YES);
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
