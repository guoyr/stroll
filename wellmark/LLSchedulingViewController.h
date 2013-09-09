//
//  LLSchedulingViewController.h
//  wellmark
//
//  Created by Robert Guo on 8/27/13.
//  Copyright (c) 2013 Stroll. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LLViewController.h"

@interface LLSchedulingViewController : LLViewController

@property (weak, nonatomic) IBOutlet UIButton *bookNow;
@property (weak, nonatomic) IBOutlet UIButton *bookUpFront;
@property (weak, nonatomic) IBOutlet UIButton *bookLater;
@property (weak, nonatomic) IBOutlet UILabel *schedulingOptionsLabel;

- (IBAction)bookNowClicked:(id)sender;
- (IBAction)bookLaterClicked:(id)sender;

@end
