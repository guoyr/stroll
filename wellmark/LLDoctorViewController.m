//
//  LLDoctorViewController.m
//  wellmark
//
//  Created by Robert Guo on 8/27/13.
//  Copyright (c) 2013 Stroll. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "LLDoctorViewController.h"
#import "LLTreatmentViewController.h"
#import "LLTreatmentManager.h"
#import "MSClient+CustomId.h"
#import "LLColors.h"
#import "LLTreatmentViewController.h"
#import "LLSettingsViewController.h"

#define CELL_HEIGHT 44

@interface LLDoctorViewController ()

@property (nonatomic, strong) NSArray *names;
@property (nonatomic, assign) int selectedRow;
@property (strong, nonatomic) UIPopoverController *doctorPopoverController;
@property (strong, nonatomic) UIPopoverController *insurancePopoverController;
@property (strong, nonatomic) LLSelectDoctorViewController *selectDoctorViewController;
@property (strong, nonatomic) LLSelectInsuranceViewController *selectInsuranceViewController;
@property (strong, nonatomic) LLSettingsViewController *settingsVC;

@property (strong, nonatomic) UITextField *insuranceTextField2;
@property (strong, nonatomic) UITextField *patientTextField;
@property (strong, nonatomic) UIButton *selectDoctorButton;
@property (strong, nonatomic) UIButton *selectInsuranceButton;
@property (strong, nonatomic) UIBarButtonItem *nextButtonItem;
@property (strong, nonatomic) UIButton *registerButton;
@property (strong, nonatomic) UIButton *settingsButton;

-(void)nextButtonClicked:(id)sender;
-(void)selectDoctorButtonClicked:(id)sender;
-(void)selectInsuranceButtonClicked:(id)sender;
-(void)registerButtonClicked:(id)sender;

@end

@implementation LLDoctorViewController

-(LLSettingsViewController *)settingsVC
{
    if (!_settingsVC) {
        _settingsVC = [[LLSettingsViewController alloc] init];
        
    }
    return _settingsVC;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _insuranceTextField2 = [[UITextField alloc] initWithFrame:CGRectMake(576, 190, 320, 48)];
    [[self view] addSubview:_insuranceTextField2];
    [_insuranceTextField2 setDelegate:self];
    [_insuranceTextField2 setBackgroundColor:[UIColor lightTextColor]];
    _insuranceTextField2.secureTextEntry = YES;
    
    _insuranceTextField2.autocorrectionType = UITextAutocorrectionTypeNo;
    
    _selectDoctorButton = [[UIButton alloc] initWithFrame:CGRectMake(128, 117, 320, 48)];
    [_selectDoctorButton setBackgroundColor:TORQUOISE];
    [[self view] addSubview:_selectDoctorButton];
    
    _selectInsuranceButton = [[UIButton alloc] initWithFrame:CGRectMake(576, 117, 320, 48)];
    [_selectInsuranceButton setBackgroundColor:TORQUOISE];
    [[self view] addSubview:_selectInsuranceButton];
    
    _patientTextField = [[UITextField alloc] initWithFrame:CGRectMake(128, 190, 320, 48)];
    [[self view] addSubview:_patientTextField];
    [_patientTextField setBackgroundColor:[UIColor lightTextColor]];
    [_patientTextField setDelegate:self];
    
     _patientTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    
    _registerButton = [[UIButton alloc] initWithFrame:CGRectMake(921, 190, 84, 48)];
    [_registerButton setTitle:@"Register" forState:UIControlStateNormal];
    [[self view] addSubview:_registerButton];
    [_registerButton setBackgroundColor:TORQUOISE];
    
    _settingsButton = [[UIButton alloc] initWithFrame:CGRectMake(128, 568, 48, 48)];
    [_settingsButton setImage:[UIImage imageNamed:@"settings.png"] forState:UIControlStateNormal];
    [self.view addSubview:_settingsButton];
    
    [_selectInsuranceButton addTarget:self action:@selector(selectInsuranceButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_settingsButton addTarget:self action:@selector(settingsButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_selectDoctorButton addTarget:self action:@selector(selectDoctorButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_registerButton addTarget:self action:@selector(registerButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    _nextButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStylePlain target:self action:@selector(nextButtonClicked:)];
    
    [self.navigationItem setRightBarButtonItem:_nextButtonItem];
    
    [[_selectDoctorButton layer] setCornerRadius:5];
    [[_selectInsuranceButton layer] setCornerRadius:5];
    [[_insuranceTextField2 layer] setCornerRadius:5];
    [[_patientTextField layer] setCornerRadius:5];
    [_insuranceTextField2 setBackgroundColor:[UIColor lightTextColor]];
    
    _selectDoctorViewController = [[LLSelectDoctorViewController alloc] initWithStyle:UITableViewStylePlain];
    _selectInsuranceViewController = [[LLSelectInsuranceViewController alloc] initWithStyle:UITableViewStylePlain];
    [_selectDoctorViewController setDelegate:self];
    [_selectInsuranceViewController setDelegate:self];
    
    _doctorPopoverController = [[UIPopoverController alloc] initWithContentViewController:_selectDoctorViewController];
    _insurancePopoverController = [[UIPopoverController alloc] initWithContentViewController:_selectInsuranceViewController];

    [[self insuranceTextField2] setAlpha:0];
    [[self registerButton] setAlpha:0];
    [[self registerButton] setEnabled:NO];

//    [[self insuranceTextField1] setEnabled:NO];
    [[self insuranceTextField2] setEnabled:NO];
    [_nextButtonItem setEnabled:NO];
	// Do any additional setup after loading the view.
    
    UITapGestureRecognizer *gr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedView:)];
    [[self view] addGestureRecognizer:gr];
}

-(void)tappedView:(id)sender
{
    if([_insuranceTextField2 isFirstResponder]) {
        [_insuranceTextField2 resignFirstResponder];
    } else if ([_patientTextField isFirstResponder]) {
        [_patientTextField resignFirstResponder];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)settingsButtonClicked:(id)sender
{
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:self.settingsVC];
    [nc.navigationBar setTranslucent:NO];
    [self.navigationController presentViewController:nc animated:YES completion:^{
        ;
    }];
    
}

-(void)selectDoctorButtonClicked:(id)sender
{
    [self tappedView:sender];
    int height = [[_selectDoctorViewController doctors] count] * CELL_HEIGHT > 320 ? 320 : [[_selectDoctorViewController doctors] count] * CELL_HEIGHT;
    [_doctorPopoverController presentPopoverFromRect:CGRectMake(128, -150, 320, 320) inView:[self view] permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
    [_doctorPopoverController setPopoverContentSize:CGSizeMake(320, height) animated:NO];
}

-(void)selectInsuranceButtonClicked:(id)sender
{
    [self tappedView:sender];
    int height = [[_selectInsuranceViewController  insurances] count] * CELL_HEIGHT > 320 ? 320 : [[_selectInsuranceViewController insurances] count] * CELL_HEIGHT;
    [_insurancePopoverController presentPopoverFromRect:CGRectMake(576, -150, 320, 320) inView:[self view] permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
    [_insurancePopoverController setPopoverContentSize:CGSizeMake(320, height + CELL_HEIGHT) animated:NO];
}

-(void)nextButtonClicked:(id)sender
{
    [self showLoadingScreen];
    [[LLTreatmentManager sharedInstance].client loginUsername:self.patientTextField.text
                              withPassword:self.insuranceTextField2.text
                                completion:^(MSUser *user, NSError *error) {
                                    [self hideLoadingScreen];
                                    if (error) {
                                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Login failed" message:error.localizedDescription delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                                        [alert show];
                                        return;
                                    } else {
                                        LLTreatmentViewController *vc = [[LLTreatmentViewController alloc] init];
                                        [self.navigationController pushViewController:vc animated:YES];
                                    }
                                        
                                }];
}

-(void)registerButtonClicked:(id)sender
{
    [[LLTreatmentManager sharedInstance].client registerUsername:self.patientTextField.text
                                 withPassword:self.insuranceTextField2.text
                               withCompletion:^(NSDictionary *item, NSError *error) {
                                   if (error) {
                                       UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Login failed"
                                                                                       message:error.localizedDescription
                                                                                      delegate:nil
                                                                             cancelButtonTitle:@"OK"
                                                                             otherButtonTitles:nil, nil];
                                       [alert show];
                                       return;
                                   } else {
                                       
                                   }
                               }];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [textField setBackgroundColor:[UIColor whiteColor]];
    return YES;
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    if (textField == _patientTextField) {
        [[LLTreatmentManager sharedInstance] setPatientName:[textField text]];
    }
    [textField setBackgroundColor:[UIColor lightTextColor]];
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == _patientTextField) {
        [_selectInsuranceButton sendActionsForControlEvents:UIControlEventTouchUpInside];
    } else if ([[_patientTextField text] length] && [[_insuranceTextField2 text] length]) {
        
    } else if (textField == _insuranceTextField2) {
        [[LLTreatmentManager sharedInstance] setMemberID:textField.text];
    } else if ([[_patientTextField text] length] && [[_insuranceTextField2 text] length] && [[_insuranceTextField2 text] length]) {
//        [self performSegueWithIdentifier:@"showTreatment"     sender:self];
    }
}

#pragma mark LLSelectInsuranceViewControllerDelegate

-(void)selectedInsurance:(NSString *)insurance
{
    [_insurancePopoverController dismissPopoverAnimated:YES];
    [_nextButtonItem setEnabled:YES];
    [_selectInsuranceButton setTitle:insurance forState:UIControlStateNormal];
    [[LLTreatmentManager sharedInstance] setInsuranceCompany:insurance];
    [self addBackgroundAnimated:YES];

    if ([insurance rangeOfString:WELLMARK].location != NSNotFound) {
        [UIView animateWithDuration:0.25 animations:^{
            [_insuranceTextField2 setAlpha:1];
            [_registerButton setAlpha:1];
        } completion:^(BOOL finished){
            [_insuranceTextField2 setEnabled:YES];
            [_registerButton setEnabled:YES];
        }];
    } else if ([_insuranceTextField2 isEnabled]) { // if we're switching from insurance to no insurance
        [UIView animateWithDuration:0.25 animations:^{
            [_insuranceTextField2 setAlpha:0];
            [_registerButton setAlpha:0];
        } completion:^(BOOL finished){
            [_insuranceTextField2 setEnabled:NO];
            [_registerButton setEnabled:NO];
        }];
    }
}

#pragma mark LLSelectDoctorViewControllerDelegate

-(void)selectedDoctor:(NSString *)doctor
{
    [_doctorPopoverController dismissPopoverAnimated:YES];
    [_selectDoctorButton setTitle:doctor forState:UIControlStateNormal];
    [_patientTextField becomeFirstResponder];
}

-(void)viewWillAppear:(BOOL)animated
{
    [_insuranceTextField2 setText:@""];
    [_patientTextField setText:@""];
    [[_selectDoctorViewController tableView]  deselectRowAtIndexPath:[[_selectDoctorViewController tableView] indexPathForSelectedRow] animated:NO];
    [[_selectInsuranceViewController tableView]  deselectRowAtIndexPath:[[_selectInsuranceViewController tableView] indexPathForSelectedRow] animated:NO];
    [_selectDoctorButton setTitle:@"Select Doctor" forState:UIControlStateNormal];
    [_selectInsuranceButton setTitle:@"Select Insurance Type" forState:UIControlStateNormal];
    [[self navigationItem] setHidesBackButton:YES animated:NO];
    [[LLTreatmentManager sharedInstance] setInsuranceCompany:NO_INSURANCE];
    [self addBackgroundAnimated:NO];
    if ([_insuranceTextField2 isEnabled]) {
        [_insuranceTextField2 setAlpha:0];
        [_registerButton setAlpha:0];
        [_insuranceTextField2 setEnabled:NO];
        [_registerButton setEnabled:NO];
    }
    [[LLTreatmentManager sharedInstance].client logout];
}

@end
