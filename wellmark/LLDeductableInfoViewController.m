//
//  LLDeductableInfoViewController.m
//  wellmark
//
//  Created by Robert Guo on 9/8/13.
//  Copyright (c) 2013 Stroll. All rights reserved.
//

#import "LLDeductableInfoViewController.h"
#import "LLTreatmentManager.h"

#define BG_HEIGHT 400
#define D_HEIGHT 60
#define CO_HEIGHT 350
#define SPENT_HEIGHT 300

@interface LLDeductableInfoViewController ()

@property (nonatomic, strong) UIView *background;
@property (nonatomic, strong) UIView *deductable;
@property (nonatomic, strong) UIView *coinsurance;
@property (nonatomic, strong) UIView *spent;


@end

@implementation LLDeductableInfoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitle:[NSString stringWithFormat:@"Deductable Status for %@", [[LLTreatmentManager sharedInstance] patientName]]];
    
    _background = [[UIView alloc] initWithFrame:CGRectMake(412, 500, 200, 0)];
    [_background setBackgroundColor:[UIColor purpleColor]];
    [[_background layer] setCornerRadius:5];
    
    _deductable = [[UIView alloc] initWithFrame:CGRectMake(412, 500, 200, 0)];
    [_deductable setBackgroundColor:[UIColor blackColor]];
    [[_deductable layer] setCornerRadius:5];
    
    _coinsurance = [[UIView alloc] initWithFrame:CGRectMake(412, 500, 200, 0)];
    [_coinsurance setBackgroundColor:[UIColor greenColor]];
    [[_coinsurance layer] setCornerRadius:5];
    
    _spent = [[UIView alloc] initWithFrame:CGRectMake(412, 500, 200, 0)];
    [_spent setBackgroundColor:[UIColor blueColor]];
    [[_spent layer] setCornerRadius:5];
    
    [[self view] addSubview:_background];
    [[self view] addSubview:_coinsurance];
    [[self view] addSubview:_spent];
    [[self view] addSubview:_deductable];


	// Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated
{
    [UIView animateWithDuration:0.5 animations:^{
        [_background setFrame:CGRectMake(412, 500 - BG_HEIGHT, 200, BG_HEIGHT)];
        [_deductable setFrame:CGRectMake(412, 500 - D_HEIGHT, 200, D_HEIGHT)];
        [_coinsurance setFrame:CGRectMake(412, 500 - CO_HEIGHT, 200, CO_HEIGHT)];
        [_spent setFrame:CGRectMake(412, 500 - SPENT_HEIGHT, 200, SPENT_HEIGHT)];

    } completion:^(BOOL finished){
        [UIView animateWithDuration:0.5 animations:^{
            
        }];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
