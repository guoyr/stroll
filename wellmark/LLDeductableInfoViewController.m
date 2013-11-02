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

@property (nonatomic, strong) UILabel *deductableLabel;
@property (nonatomic, strong) UILabel *coinsuranceLabel;
@property (nonatomic, strong) UILabel *spentLabel;


@end

@implementation LLDeductableInfoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitle:[NSString stringWithFormat:@"Deductable Status for %@", [[LLTreatmentManager sharedInstance] patientName]]];
    
    _background = [[UIView alloc] initWithFrame:CGRectMake(412, 500, 200, 0)];
    [_background setBackgroundColor:[UIColor darkGrayColor]];
    [[_background layer] setCornerRadius:5];
    
    _deductable = [[UIView alloc] initWithFrame:CGRectMake(412, 500, 200, 0)];
    [_deductable setBackgroundColor:[UIColor whiteColor]];
    [[_deductable layer] setCornerRadius:5];
    
    _coinsurance = [[UIView alloc] initWithFrame:CGRectMake(412, 500, 200, 0)];
    [_coinsurance setBackgroundColor:[UIColor grayColor]];
    [[_coinsurance layer] setCornerRadius:5];
    
    _spent = [[UIView alloc] initWithFrame:CGRectMake(412, 500, 200, 0)];
    [_spent setBackgroundColor:[UIColor lightGrayColor]];
    [[_spent layer] setCornerRadius:5];
    
    _deductableLabel = [[UILabel alloc] initWithFrame:CGRectMake(312, 500, 100, 50)];
    [_deductableLabel setText:@"Deductable, $1000"];
    
    [[self view] addSubview:_background];
    [[self view] addSubview:_coinsurance];
    [[self view] addSubview:_spent];
    [[self view] addSubview:_deductable];


	// Do any additional setup after loading the view.
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewDidAppear:(BOOL)animated
{
    [UIView animateWithDuration:0.5 animations:^{
        [_background setFrame:CGRectMake(412, 500 - BG_HEIGHT, 200, 400)];
        [_deductable setFrame:CGRectMake(412, 500 - D_HEIGHT, 200, 60)];
        [_coinsurance setFrame:CGRectMake(412, 500 - CO_HEIGHT, 200, 350)];
        [_spent setFrame:CGRectMake(412, 500 - SPENT_HEIGHT, 200, 300)];
        
    } completion:^(BOOL finished){
        /*_deductableLabel = [[UILabel alloc] initWithFrame:CGRectMake(632, 500 - D_HEIGHT - 20, 150, 50)];
        [_deductableLabel setText:@"Deductable\n $1000"];
        [_deductableLabel setNumberOfLines:2];
        [_deductableLabel setAlpha:0];
        [[self view] addSubview:_deductableLabel];
        
        _coinsuranceLabel = [[UILabel alloc] initWithFrame:CGRectMake(632, 500 - CO_HEIGHT - 20, 150, 50)];
        [_coinsuranceLabel setText:@"Fully Covered\n $8000"];
        [_coinsuranceLabel setNumberOfLines:2];
        [_coinsuranceLabel setAlpha:0];
        [[self view] addSubview:_coinsuranceLabel];
        
        _spentLabel = [[UILabel alloc] initWithFrame:CGRectMake(412 - 100, 500 - SPENT_HEIGHT - 20, 100, 50)];
        [_spentLabel setText:@"You Spent\n $5000"];
        [_spentLabel setNumberOfLines:2];
        [_spentLabel setAlpha:0];
        [[self view] addSubview:_spentLabel];*/
        /*[UIView animateWithDuration:0.5 animations:^{
            [_deductableLabel setAlpha:1];
            [_coinsuranceLabel setAlpha:1];
            [_spentLabel setAlpha:1];
            
            
        }];*/
        [UIView animateWithDuration:0.5 animations:^{
            [_background setFrame:CGRectMake(412, 500 - 300, 200, 300)];
            [_deductable setFrame:CGRectMake(412, 500 - 40, 200, 40)];
            [_coinsurance setFrame:CGRectMake(412, 500 - 250, 200, 250)];
            [_spent setFrame:CGRectMake(412, 500 - 200, 200, 200)];
         
         
        }completion:^(BOOL finished){
            _deductableLabel = [[UILabel alloc] initWithFrame:CGRectMake(632, 500 - D_HEIGHT - 20, 150, 50)];
             [_deductableLabel setText:@"Deductable\n $1000"];
             [_deductableLabel setNumberOfLines:2];
             [_deductableLabel setAlpha:0];
             [[self view] addSubview:_deductableLabel];
             
             _coinsuranceLabel = [[UILabel alloc] initWithFrame:CGRectMake(632, 500 - CO_HEIGHT - 20, 150, 50)];
             [_coinsuranceLabel setText:@"Fully Covered\n $8000"];
             [_coinsuranceLabel setNumberOfLines:2];
             [_coinsuranceLabel setAlpha:0];
             [[self view] addSubview:_coinsuranceLabel];
             
             _spentLabel = [[UILabel alloc] initWithFrame:CGRectMake(412 - 100, 500 - SPENT_HEIGHT - 20, 100, 50)];
             [_spentLabel setText:@"You Spent\n $5000"];
             [_spentLabel setNumberOfLines:2];
             [_spentLabel setAlpha:0];
             [[self view] addSubview:_spentLabel];
             [UIView animateWithDuration:0.5 animations:^{
             [_deductableLabel setAlpha:1];
             [_coinsuranceLabel setAlpha:1];
             [_spentLabel setAlpha:1];
             
             
             }];
            [UIView animateWithDuration:0.5 animations:^{
                [_background setFrame:CGRectMake(412, 500 - 400, 200, 400)];
                [_deductable setFrame:CGRectMake(412, 500 - 60, 200, 60)];
                [_coinsurance setFrame:CGRectMake(412, 500 - 350, 200, 350)];
                [_spent setFrame:CGRectMake(412, 500 - 300, 200, 300)];
                
                
            }];
        }];
    }];
}
@end
