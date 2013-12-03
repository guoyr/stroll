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
@property (nonatomic, strong) NSString *insuranceName;

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
    
    NSString *insuranceName = [[LLTreatmentManager sharedInstance] insuranceCompany];
    if ([insuranceName isEqualToString:WELLMARK]) {
        UIImageView *bg1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"wellmark_bg.png"]];
        UIImageView *bg2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"wellmark_logo.png"]];
        [bg2 setCenter:CGPointMake(bg1.frame.size.width - bg2.frame.size.width/2, bg2.frame.size.height/2)];
        backgroundView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        [backgroundView addSubview:bg1];
        [backgroundView addSubview:bg2];
        _insuranceName = WELLMARK;
    } else if ([insuranceName isEqualToString:MEDICARE]) {
        backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"medicare_bg.png"]];
        _insuranceName = MEDICARE;
    }
    else {
        backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background.png"]];
        _insuranceName = NO_INSURANCE;
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
