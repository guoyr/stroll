//
//  LLConfirmViewController.h
//  wellmark
//
//  Created by Robert Guo on 8/27/13.
//  Copyright (c) 2013 Stroll. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface LLConfirmViewController : UIViewController

@property (nonatomic, strong) MFMailComposeViewController *mailController;

@end
