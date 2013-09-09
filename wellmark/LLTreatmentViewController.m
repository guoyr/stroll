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

#define CELL_HEIGHT 44

@interface LLTreatmentViewController ()

@property (nonatomic, strong) NSArray *treatments;
@property (nonatomic, strong) NSString *selectedTreatment;

@end

@implementation LLTreatmentViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self setTitle:[NSString stringWithFormat:@"Select Treatment for %@",[[LLTreatmentManager sharedInstance] patientName]]];
    [self setTreatments:[NSArray arrayWithObjects:@"CT Scan", @"MRI Scan", @"PET Scan", @"EKG", @"X-Ray", nil]];
    [[_treatmentLabel layer] setCornerRadius:5];
    int height = [[self treatments] count] * CELL_HEIGHT > 320 ? 320 : [[self treatments] count] * CELL_HEIGHT;
    [[self treatmentTableView] setFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, height)];
    [[_treatmentTableView layer] setCornerRadius:5];
}

#warning testing code
-(void)viewDidAppear:(BOOL)animated
{
//    [self performSegueWithIdentifier:@"showDeductable" sender:self];
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
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    _selectedTreatment = [[cell textLabel] text];
    [[LLTreatmentManager sharedInstance] setSelectedTreatment:_selectedTreatment];
    [self performSegueWithIdentifier:@"showDeductable" sender:self];
}

@end
