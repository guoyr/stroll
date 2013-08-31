//
//  LLTreatmentViewController.m
//  wellmark
//
//  Created by Robert Guo on 8/27/13.
//  Copyright (c) 2013 Stroll. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "LLTreatmentViewController.h"
#import "LLLocationsViewController.h"
#import "LLTreatmentManager.h"

@interface LLTreatmentViewController ()

@property (nonatomic, strong) NSArray *treatments;
@property (nonatomic, strong) NSString *selectedTreatment;

@end

@implementation LLTreatmentViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self setTitle:[NSString stringWithFormat:@"Select Treatment for %@", _patientName]];
    [self setTreatments:[NSArray arrayWithObjects:@"CT Scan", @"MRI Scan", @"Ultrasound", nil]];
    [[self nextButtonItem] setEnabled:NO];
    [[_treatmentLabel layer] setCornerRadius:5];
    
    UIImageView *bg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background.png"]];
    [[self view] addSubview:bg];
    [[self view] sendSubviewToBack:bg];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"TreatmentCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    [[cell textLabel] setText:[[self treatments] objectAtIndex:[indexPath row]]];
    [[cell textLabel] setBackgroundColor:[UIColor clearColor]];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_treatments count];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _selectedTreatment = [_treatments objectAtIndex:[indexPath row]];
    [[self nextButtonItem] setEnabled:YES];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showLocations"]) {
        LLLocationsViewController *vc = [segue destinationViewController];
        [vc setPatientName:_patientName];
        [vc setTreatment:_selectedTreatment];
    }
}

@end
