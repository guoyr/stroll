//
//  LLDeductableInfoViewController.m
//  wellmark
//
//  Created by Robert Guo on 9/8/13.
//  Copyright (c) 2013 Stroll. All rights reserved.
//

#import "LLDeductableInfoViewController.h"
#import "LLTreatmentManager.h"

#define HEIGHT 20
#define WIDTH 80
#define D_HEIGHT 60
#define CO_HEIGHT 350
#define SPENT_HEIGHT 300
#define START 550
#define LENGTH 450
#define MARGIN 5
#define VMARGIN 10

@interface LLDeductableInfoViewController ()

@property (nonatomic, strong) UIView *background;
@property (nonatomic, strong) UIView *deductable;
@property (nonatomic, strong) UIView *currentAmount;
@property (nonatomic, strong) UIView *maxOutOfPocket;

@property (nonatomic, strong) UILabel *deductableLabel;
@property (nonatomic, strong) UILabel *CurrenAmountLabel;
@property (nonatomic, strong) UILabel *maxOutOfPocketLabel;

@property (nonatomic, strong)   MSTable *table;

@property (nonatomic) int deductiblevalue;
@property (nonatomic) int currentamountvalue;

@end

@implementation LLDeductableInfoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _background = [[UIView alloc] initWithFrame:CGRectMake(VMARGIN, VMARGIN, WIDTH, HEIGHT)];
    [_background setBackgroundColor:[UIColor darkGrayColor]];
    [[_background layer] setCornerRadius:5];

    _deductable = [[UIView alloc] initWithFrame:CGRectMake(START,VMARGIN,LENGTH*0.16, HEIGHT)];
    [_deductable setBackgroundColor:[UIColor whiteColor]];
    
    float percentage = 0.0;
    if(self.deductiblevalue!=0) percentage=self.currentamountvalue/(self.deductiblevalue*5);
    else percentage = 0;
    _currentAmount = [[UIView alloc] initWithFrame:CGRectMake(START+LENGTH*0.8*percentage, VMARGIN, 10, HEIGHT)];
    [_currentAmount setBackgroundColor:[UIColor redColor]];


    _maxOutOfPocket = [[UIView alloc] initWithFrame:CGRectMake(START+LENGTH*0.16, VMARGIN, LENGTH*0.8, HEIGHT)];
    [_maxOutOfPocket setBackgroundColor:[UIColor lightGrayColor]];

    
    _deductableLabel = [[UILabel alloc] initWithFrame:CGRectMake(START, VMARGIN*2+HEIGHT, LENGTH*0.16,HEIGHT )];
    [_deductableLabel setText:@"Deductable, $1000"];
    
    [self.view addSubview:_background];
    [self.view addSubview:_deductable];
    [self.view addSubview:_currentAmount];
    [self.view addSubview:_maxOutOfPocket];
    [self.view addSubview:_deductableLabel];
	// Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    MSClient *newClient = [MSClient clientWithApplicationURLString:@"https://strollmobile.azure-mobile.net/"
                                                withApplicationKey:@"VWHKZcntaIYDRsbZWEowEyvKiLfTWi91"];
    MSTable *deductibleStatusTable = [newClient getTable:@"patientsdata"];
    //_memberID = @"1035369";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"memberID == %@",[NSString stringWithFormat:@"%@:%@",_memberID, _memberID]];
    [deductibleStatusTable readWhere:predicate completion:^(NSArray *items, NSInteger totalCount, NSError *error) {
        NSDictionary *dict = [items lastObject];
        _deductiblevalue = [[dict objectForKey:@"Deductable"] intValue];
        _currentamountvalue = [[dict objectForKey:@"Coverage"] intValue];
        NSLog(@"%d,%d,%d",_deductiblevalue, _currentamountvalue, 5*_deductiblevalue);
        
    }];
    
}

//-(void)viewDidAppear:(BOOL)animated
//{
//    [UIView animateWithDuration:0.5 animations:^{
//        [_background setFrame:CGRectMake(412, 500 - BG_HEIGHT, 200, 400)];
//        [_deductable setFrame:CGRectMake(412, 500 - D_HEIGHT, 200, 60)];
//        [_coinsurance setFrame:CGRectMake(412, 500 - CO_HEIGHT, 200, 350)];
//        [_spent setFrame:CGRectMake(412, 500 - SPENT_HEIGHT, 200, 300)];
//        
//    } completion:^(BOOL finished){
//        [UIView animateWithDuration:0.5 animations:^{
//            [_background setFrame:CGRectMake(412, 500 - 300, 200, 300)];
//            [_deductable setFrame:CGRectMake(412, 500 - 40, 200, 40)];
//            [_coinsurance setFrame:CGRectMake(412, 500 - 250, 200, 250)];
//            [_spent setFrame:CGRectMake(412, 500 - 200, 200, 200)];
//            
//            
//        }completion:^(BOOL finished){
//            _deductableLabel = [[UILabel alloc] initWithFrame:CGRectMake(632, 500 - D_HEIGHT - 20, 150, 50)];
//            [_deductableLabel setText:[NSString stringWithFormat:@"Deductable: %d", self.deductiblevalue]];
//            [_deductableLabel setNumberOfLines:2];
//            [_deductableLabel setAlpha:0];
//            [[self view] addSubview:_deductableLabel];
//            
//            
//            
//            _coinsuranceLabel = [[UILabel alloc] initWithFrame:CGRectMake(632, 500 - CO_HEIGHT - 20, 150, 50)];
//            // [_coinsuranceLabel setText:@"Fully Covered\n $8000"];
//            [_coinsuranceLabel setText:[NSString stringWithFormat:@"Current Amount: %d", self.currentamount]];
//            [_coinsuranceLabel setNumberOfLines:2];
//            [_coinsuranceLabel setAlpha:0];
//            [[self view] addSubview:_coinsuranceLabel];
//            
//            _spentLabel = [[UILabel alloc] initWithFrame:CGRectMake(412 - 100, 500 - SPENT_HEIGHT - 20, 100, 50)];
//            [_spentLabel setText:[NSString stringWithFormat:@"Max out of pocket: %d", 5*self.deductiblevalue]];
//            [_spentLabel setNumberOfLines:2];
//            [_spentLabel setAlpha:0];
//            [[self view] addSubview:_spentLabel];
//            [UIView animateWithDuration:0.5 animations:^{
//                [_deductableLabel setAlpha:1];
//                [_coinsuranceLabel setAlpha:1];
//                [_spentLabel setAlpha:1];
//                
//                
//            }];
//            [UIView animateWithDuration:0.5 animations:^{
//                [_background setFrame:CGRectMake(412, 500 - 400, 200, 400)];
//                [_deductable setFrame:CGRectMake(412, 500 - 60, 200, 60)];
//                [_coinsurance setFrame:CGRectMake(412, 500 - 350, 200, 350)];
//                [_spent setFrame:CGRectMake(412, 500 - 300, 200, 300)];
//                
//                
//            }];
//        }];
//    }];
//}
//- (void)didReceiveMemoryWarning
//{
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}

@end
