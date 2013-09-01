//
//  LLSelectDoctorViewController.h
//  wellmark
//
//  Created by Robert Guo on 9/1/13.
//  Copyright (c) 2013 Stroll. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LLSelectDoctorViewControllerDelegate <NSObject>

-(void)selectedDoctor:(NSString *)doctor;

@end

@interface LLSelectDoctorViewController : UITableViewController

@property (nonatomic, retain) id<LLSelectDoctorViewControllerDelegate> delegate;

@end

