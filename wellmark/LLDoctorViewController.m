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
    [self setNames:[NSArray arrayWithObjects:@"Gertie Troup", @"Brigitte Denner", @"Ethelyn Desanto", @"Leeanna Halm", @"Jama Sing", nil]];
    [[_selectDoctorButton layer] setCornerRadius:5];
    [[_selectInsuranceButton layer] setCornerRadius:5];
    [[_insuranceTextField1 layer] setCornerRadius:5];
    [[_insuranceTextField2 layer] setCornerRadius:5];
    [[_patientTextField layer] setCornerRadius:5];


    [[LLTreatmentManager sharedInstance] addBackground:[self view]];
    
    _selectDoctorViewController = [[LLSelectDoctorViewController alloc] initWithStyle:UITableViewStylePlain];
    _selectInsuranceViewController = [[LLSelectInsuranceViewController alloc] initWithStyle:UITableViewStylePlain];
    [_selectDoctorViewController setDelegate:self];
    [_selectInsuranceViewController setDelegate:self];
    
    _doctorPopoverController = [[UIPopoverController alloc] initWithContentViewController:_selectDoctorViewController];
    _insurancePopoverController = [[UIPopoverController alloc] initWithContentViewController:_selectInsuranceViewController];

//    NSDictionary *params = [NSDictionary  dictionaryWithObject:@"test" forKey:@"text"];
//    [PFCloud callFunctionInBackground:@"emailTest" withParameters:params block:^(id object, NSError *error){
//        NSLog(@"done");
//        NSLog(@"%@",object);
//        NSLog(@"%@", error);
//    } ];

    [[self nextButtonItem] setEnabled:NO];
    [[self insuranceTextField1] setHidden:YES];
    [[self insuranceTextField2] setHidden:YES];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)selectDoctorButtonClicked:(id)sender
{
    [_doctorPopoverController presentPopoverFromRect:CGRectMake(128, -72, 320, 320) inView:[self view] permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
    [_doctorPopoverController setPopoverContentSize:CGSizeMake(320, 320) animated:NO];
}

-(void)selectInsuranceButtonClicked:(id)sender
{
    [_insurancePopoverController presentPopoverFromRect:CGRectMake(576, -72, 320, 320) inView:[self view] permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
    [_doctorPopoverController setPopoverContentSize:CGSizeMake(320, 320) animated:NO];
}

-(void)nextButtonClicked:(id)sender
{
    [[self view] resignFirstResponder];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([[_insuranceTextField1 text] length] && [[_insuranceTextField2 text] length] && [[_insuranceTextField2 text] length]) {
        [_nextButtonItem setEnabled:YES];
    } else {
        [_nextButtonItem setEnabled:NO];
    }
    return YES;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showTreatment"]) {
        [[LLTreatmentManager sharedInstance] setPatientName:[_names objectAtIndex:_selectedRow]];
    }
}


#pragma mark LLSelectInsuranceViewControllerDelegate

-(void)selectedInsurance:(NSString *)insurance
{
    [_insurancePopoverController dismissPopoverAnimated:YES];
    [_selectInsuranceButton setTitle:insurance forState:UIControlStateNormal];
    if ([insurance rangeOfString:@"Wellmark"].location != NSNotFound) {
        [_insuranceTextField1 setHidden:NO];
        [_insuranceTextField2 setHidden:NO];
    }

}


#pragma mark LLSelectDoctorViewControllerDelegate

-(void)selectedDoctor:(NSString *)doctor
{
    [_doctorPopoverController dismissPopoverAnimated:YES];
    [_selectDoctorButton setTitle:doctor forState:UIControlStateNormal];
}

@end
