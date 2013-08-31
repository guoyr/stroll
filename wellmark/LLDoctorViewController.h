//
//  LLDoctorViewController.h
//  wellmark
//
//  Created by Robert Guo on 8/27/13.
//  Copyright (c) 2013 Stroll. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LLDoctorViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *insuranceTextField1;
@property (weak, nonatomic) IBOutlet UITextField *insuranceTextField2;
@property (weak, nonatomic) IBOutlet UITextField *patientTextField;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *nextButtonItem;
@property (weak, nonatomic) IBOutlet UITableView *doctorTableView;
@property (weak, nonatomic) IBOutlet UITableView *insuranceTableView;
@property (weak, nonatomic) IBOutlet UILabel *selectDoctorLabel;
@property (weak, nonatomic) IBOutlet UILabel *selectInsuranceLabel;
@property (weak, nonatomic) IBOutlet UILabel *patientLabel;
@property (weak, nonatomic) IBOutlet UILabel *insuranceLabel1;
@property (weak, nonatomic) IBOutlet UILabel *insuranceLabel2;

-(IBAction)nextButtonClicked:(id)sender;

@end
