//
//  LLBookingViewController.h
//  wellmark
//
//  Created by Robert Guo on 8/27/13.
//  Copyright (c) 2013 Stroll. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LLBookingViewController : UIViewController

@property (nonatomic, weak) IBOutlet UIButton *success;
@property (nonatomic, weak) IBOutlet UIButton *retry;
@property (nonatomic, weak) IBOutlet UIButton *abort;
@property (nonatomic, weak) IBOutlet UILabel *treatmentLabel;
@property (nonatomic, weak) IBOutlet UILabel *doctorAddress;
@property (nonatomic, weak) IBOutlet UILabel *doctorNumber;

@property (nonatomic, strong) NSDictionary *providerInformation;
@property (nonatomic, strong) NSString *treatment;

@end
