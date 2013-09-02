//
//  LLSchedulingViewController.h
//  wellmark
//
//  Created by Robert Guo on 8/27/13.
//  Copyright (c) 2013 Stroll. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LLSchedulingViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *bookNow;
@property (weak, nonatomic) IBOutlet UIButton *bookUpFront;
@property (weak, nonatomic) IBOutlet UIButton *bookLater;

- (IBAction)bookNowClicked:(id)sender;
- (IBAction)bookLaterClicked:(id)sender;

@end
