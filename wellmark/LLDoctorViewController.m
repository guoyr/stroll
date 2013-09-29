//
//  LLDoctorViewController.m
//  wellmark
//
//  Created by Robert Guo on 8/27/13.
//  Copyright (c) 2013 Stroll. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <Parse/Parse.h>

#import "LLDoctorViewController.h"
#import "LLTreatmentViewController.h"
#import "LLTreatmentManager.h"

#define CELL_HEIGHT 44

@interface LLDoctorViewController ()

@property (nonatomic, strong) NSArray *names;
@property (nonatomic, assign) int selectedRow;
@property (strong, nonatomic) UIPopoverController *doctorPopoverController;
@property (strong, nonatomic) UIPopoverController *insurancePopoverController;
@property (strong, nonatomic) LLSelectDoctorViewController *selectDoctorViewController;
@property (strong, nonatomic) LLSelectInsuranceViewController *selectInsuranceViewController;

@end

@implementation LLDoctorViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[_selectDoctorButton layer] setCornerRadius:5];
    [[_selectInsuranceButton layer] setCornerRadius:5];
    [[_insuranceTextField1 layer] setCornerRadius:5];
    [[_insuranceTextField2 layer] setCornerRadius:5];
    [[_patientTextField layer] setCornerRadius:5];
    
    _selectDoctorViewController = [[LLSelectDoctorViewController alloc] initWithStyle:UITableViewStylePlain];
    _selectInsuranceViewController = [[LLSelectInsuranceViewController alloc] initWithStyle:UITableViewStylePlain];
    [_selectDoctorViewController setDelegate:self];
    [_selectInsuranceViewController setDelegate:self];
    
    _doctorPopoverController = [[UIPopoverController alloc] initWithContentViewController:_selectDoctorViewController];
    _insurancePopoverController = [[UIPopoverController alloc] initWithContentViewController:_selectInsuranceViewController];

    [[self insuranceTextField1] setAlpha:0];
    [[self insuranceTextField2] setAlpha:0];
    [[self insuranceTextField1] setEnabled:NO];
    [[self insuranceTextField2] setEnabled:NO];
	// Do any additional setup after loading the view.
    
    UITapGestureRecognizer *gr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedView:)];
    [[self view] addGestureRecognizer:gr];
}

-(void)tappedView:(id)sender
{
    if ([_insuranceTextField1 isFirstResponder]) {
        [_insuranceTextField1 resignFirstResponder];
    } else if([_insuranceTextField2 isFirstResponder]) {
        [_insuranceTextField2 resignFirstResponder];
    } else if ([_patientTextField isFirstResponder]) {
        [_patientTextField resignFirstResponder];
    }
}

#warning testing code
-(void)viewDidAppear:(BOOL)animated
{
    
//    [self performSegueWithIdentifier:@"showTreatment" sender:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    [_insurancePopoverController setPopoverContentSize:CGSizeMake(320, height) animated:NO];
}

-(void)nextButtonClicked:(id)sender
{
    [self tappedView:sender];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    if (textField == _patientTextField) {
        [[LLTreatmentManager sharedInstance] setPatientName:[textField text]];
    }
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == _patientTextField) {
        [_selectInsuranceButton sendActionsForControlEvents:UIControlEventTouchUpInside];
    } else if (textField == _insuranceTextField1) {
        [_insuranceTextField2 becomeFirstResponder];
    } else if ([[_patientTextField text] length] && [[_insuranceTextField2 text] length] && [[_insuranceTextField2 text] length]) {
        [self performSegueWithIdentifier:@"showTreatment" sender:self];
    }
}

#pragma mark LLSelectInsuranceViewControllerDelegate

-(void)selectedInsurance:(NSString *)insurance
{
    [_insurancePopoverController dismissPopoverAnimated:YES];
    [_selectInsuranceButton setTitle:insurance forState:UIControlStateNormal];
    if ([insurance rangeOfString:WELLMARK].location != NSNotFound) {
        [[LLTreatmentManager sharedInstance] setInsuranceCompany:WELLMARK];
        [self addBackground:YES];
        [UIView animateWithDuration:0.25 animations:^{
//            [_insuranceTextField1 setAlpha:1];
            [_insuranceTextField2 setAlpha:1];
        } completion:^(BOOL finished){
            [_insuranceTextField2 setEnabled:YES];
//            [_insuranceTextField1 setEnabled:YES];
//            [_insuranceTextField1 becomeFirstResponder];
            [_insuranceTextField2 becomeFirstResponder];
        }];
        
//    } else if ([_insuranceTextField1 isEnabled] || [_insuranceTextField2 isEnabled]) {
    } else if ([_insuranceTextField2 isEnabled]) {
        [[LLTreatmentManager sharedInstance] setInsuranceCompany:nil];
        [self addBackground:YES];
        [UIView animateWithDuration:0.25 animations:^{
//            [_insuranceTextField1 setAlpha:0];
            [_insuranceTextField2 setAlpha:0];
        } completion:^(BOOL finished){
            [_insuranceTextField2 setEnabled:NO];
//            [_insuranceTextField1 setEnabled:NO];
//            [_insuranceTextField1 becomeFirstResponder];
            [_insuranceTextField2 becomeFirstResponder];

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
    [_insuranceTextField1 setText:@""];
    [_patientTextField setText:@""];
    [[_selectDoctorViewController tableView]  deselectRowAtIndexPath:[[_selectDoctorViewController tableView] indexPathForSelectedRow] animated:NO];
    [[_selectInsuranceViewController tableView]  deselectRowAtIndexPath:[[_selectInsuranceViewController tableView] indexPathForSelectedRow] animated:NO];
    [_selectDoctorButton setTitle:@"Select Doctor" forState:UIControlStateNormal];
    [_selectInsuranceButton setTitle:@"Select Insurance Type" forState:UIControlStateNormal];
    [[self navigationItem] setHidesBackButton:YES animated:NO];
}



@end
