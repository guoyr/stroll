//
//  LLDoctorViewController.m
//  wellmark
//
//  Created by Robert Guo on 8/27/13.
//  Copyright (c) 2013 Stroll. All rights reserved.
//

#import "LLDoctorViewController.h"
#import "LLTreatmentViewController.h"

@interface LLDoctorViewController ()

@property (nonatomic, strong) NSArray *doctors;
@property (nonatomic, strong) NSArray *names;
@property (nonatomic, assign) int selectedRow;

@end

@implementation LLDoctorViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setDoctors:[NSArray arrayWithObjects:@"Dr. Tim Peterson", @"Dr. Sameer Sonalkar", @"Dr. Jordan Epstein", @"Dr. Matthew Mauer", @"Dr. Andrew Moxon", nil]];
    [self setNames:[NSArray arrayWithObjects:@"Gertie Troup", @"Brigitte Denner", @"Ethelyn Desanto", @"Leeanna Halm", @"Jama Sing", nil]];
    [[self nextButtonItem] setEnabled:NO];
    [[self insuranceTextField1] setEnabled:NO];
    [[self insuranceTextField2] setEnabled:NO];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"DoctorCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    [[cell textLabel] setText:[[self doctors] objectAtIndex:[indexPath row]]];
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
    return [[self doctors] count];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showTreatment"]) {
        LLTreatmentViewController *vc = [segue destinationViewController];
        [vc setPatientName:[_names objectAtIndex:_selectedRow]];
    }
}

@end
