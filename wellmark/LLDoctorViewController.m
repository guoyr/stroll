//
//  LLDoctorViewController.m
//  wellmark
//
//  Created by Robert Guo on 8/27/13.
//  Copyright (c) 2013 Stroll. All rights reserved.
//

#import "LLDoctorViewController.h"
#import "LLTreatmentViewController.h"
#import "LLTreatmentManager.h"
#import <QuartzCore/QuartzCore.h>
#import <Parse/Parse.h>

@interface LLDoctorViewController ()

@property (nonatomic, strong) NSArray *doctors;
@property (nonatomic, strong) NSArray *names;
@property (nonatomic, strong) NSArray *insurances;
@property (nonatomic, assign) int selectedRow;

@end

@implementation LLDoctorViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setDoctors:[NSArray arrayWithObjects:@"Dr. Tim Peterson", @"Dr. Sameer Sonalkar", @"Dr. Jordan Epstein", @"Dr. Matthew Mauer", @"Dr. Andrew Moxon", nil]];
    [self setNames:[NSArray arrayWithObjects:@"Gertie Troup", @"Brigitte Denner", @"Ethelyn Desanto", @"Leeanna Halm", @"Jama Sing", nil]];
    [self setInsurances:[NSArray arrayWithObjects:@"Wellmark Blue Cross Blue Shield", @"Medicare", @"No Insurance", nil]];
//    [[self nextButtonItem] setEnabled:NO];
    [[_selectDoctorLabel layer] setCornerRadius:5];
    [[_selectInsuranceLabel layer] setCornerRadius:5];
    [[_patientLabel layer] setCornerRadius:5];
    [[_insuranceLabel1 layer] setCornerRadius:5];
    [[_insuranceLabel2 layer] setCornerRadius:5];
    [[_insuranceTextField1 layer] setCornerRadius:5];
    [[_insuranceTextField2 layer] setCornerRadius:5];
    [[_patientTextField layer] setCornerRadius:5];
    
    [[LLTreatmentManager sharedInstance] addBackground:[self view]];
    
//    NSDictionary *params = [NSDictionary  dictionaryWithObject:@"test" forKey:@"text"];
//    [PFCloud callFunctionInBackground:@"emailTest" withParameters:params block:^(id object, NSError *error){
//        NSLog(@"done");
//        NSLog(@"%@",object);
//        NSLog(@"%@", error);
//    } ];

    
    

//    [[self insuranceTextField1] setEnabled:NO];
//    [[self insuranceTextField2] setEnabled:NO];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    if (tableView == _doctorTableView ) {
        static NSString *CellIdentifier = @"DoctorCell";
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        [[cell textLabel] setText:[[self doctors] objectAtIndex:[indexPath row]]];
    } else {
        static NSString *CellIdentifier = @"InsuranceCell";
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        [[cell textLabel] setText:[[self insurances] objectAtIndex:[indexPath row]]];
    }
    
    [[cell textLabel] setBackgroundColor:[UIColor clearColor]];
    
    return cell;

}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [[self insuranceTextField1] resignFirstResponder];
    [[self insuranceTextField2] resignFirstResponder];

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _selectedRow = [indexPath row];
    [[self insuranceTextField1] setEnabled:YES];
    [[self insuranceTextField2] setEnabled:YES];
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
    if ([[_insuranceTextField1 text] length] && [[_insuranceTextField2 text] length]) {
        [_nextButtonItem setEnabled:YES];
    } else {
        [_nextButtonItem setEnabled:NO];
    }
    return YES;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _doctorTableView) {
        return [[self doctors] count];
    } else {
        return [[self insurances] count];
    }
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showTreatment"]) {
        [[LLTreatmentManager sharedInstance] setPatientName:[_names objectAtIndex:_selectedRow]];
    }
}

@end
