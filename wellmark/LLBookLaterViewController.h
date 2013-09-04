//
//  LLBookLaterViewController.h
//  wellmark
//
//  Created by Robert Guo on 8/28/13.
//  Copyright (c) 2013 Stroll. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LLViewController.h"

@interface LLBookLaterViewController : LLViewController <UITextFieldDelegate>

@property (nonatomic, weak) IBOutlet UILabel *enterEmailLabel;
@property (nonatomic, weak) IBOutlet UITextField *emailField;
@property (nonatomic, weak) IBOutlet UIButton *sendEmailButton;
@property (nonatomic, weak) IBOutlet UIBarButtonItem *finishButtonItem;

-(IBAction)sendEmail:(id)sender;
-(IBAction)finish:(id)sender;
@end
