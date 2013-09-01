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

@interface LLDoctorViewController : UIViewController <UITextFieldDelegate, LLSelectDoctorViewControllerDelegate, LLSelectInsuranceViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *insuranceTextField1;
@property (weak, nonatomic) IBOutlet UITextField *insuranceTextField2;
@property (weak, nonatomic) IBOutlet UITextField *patientTextField;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *nextButtonItem;
@property (weak, nonatomic) IBOutlet UIButton *selectDoctorButton;
@property (weak, nonatomic) IBOutlet UIButton *selectInsuranceButton;

-(IBAction)nextButtonClicked:(id)sender;
-(IBAction)selectDoctorButtonClicked:(id)sender;
-(IBAction)selectInsuranceButtonClicked:(id)sender;

@end
