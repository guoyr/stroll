//
//  LLDoctorViewController.h
//  wellmark
//
//  Created by Robert Guo on 8/27/13.
//  Copyright (c) 2013 Stroll. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LLSelectDoctorViewController.h"
#import "LLSelectInsuranceViewController.h"
#import "LLSettingsViewController.h"
#import "LLViewController.h"

@interface LLDoctorViewController : LLViewController <UITextFieldDelegate, LLSelectDoctorViewControllerDelegate, LLSelectInsuranceViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *insuranceTextField1;
@property (weak, nonatomic) IBOutlet UITextField *insuranceTextField2;
@property (weak, nonatomic) IBOutlet UITextField *patientTextField;
@property (weak, nonatomic) IBOutlet UIButton *selectDoctorButton;
@property (weak, nonatomic) IBOutlet UIButton *selectInsuranceButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *nextButtonItem;

@property (strong, nonatomic) LLSettingsViewController *settingViewController;

-(IBAction)nextButtonClicked:(id)sender;
-(IBAction)selectDoctorButtonClicked:(id)sender;
-(IBAction)selectInsuranceButtonClicked:(id)sender;

@end
