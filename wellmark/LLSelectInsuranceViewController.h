//
//  LLSelectInsuranceViewController.h
//  wellmark
//
//  Created by Robert Guo on 9/1/13.
//  Copyright (c) 2013 Stroll. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LLSelectInsuranceViewControllerDelegate <NSObject>

-(void)selectedInsurance:(NSString *)insurance;

@end

@interface LLSelectInsuranceViewController : UITableViewController

@property (nonatomic, retain) id<LLSelectInsuranceViewControllerDelegate> delegate;
@property (nonatomic, strong) NSArray *insurances;

@end