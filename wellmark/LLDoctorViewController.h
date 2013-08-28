//
//  LLDoctorViewController.h
//  wellmark
//
//  Created by Robert Guo on 8/27/13.
//  Copyright (c) 2013 Stroll. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LLDoctorViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITableView *doctorTableView;
@property (weak, nonatomic) IBOutlet UITextField *insuranceTextField1;
@property (weak, nonatomic) IBOutlet UITextField *insuranceTextField2;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *nextButtonItem;

-(IBAction)nextButtonClicked:(id)sender;

@end
