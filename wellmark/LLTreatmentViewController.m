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
#import "LLColors.h"
#define CELL_HEIGHT 44
#import "LLMriViewController.h"

@interface LLTreatmentViewController ()

@property (strong, nonatomic) UILabel *treatmentLabel;

@property (nonatomic, strong) NSArray *treatments;
@property (nonatomic, strong) NSString *selectedTreatment;
@property (strong, nonatomic) UITableView *treatmentTableView;

@end

@implementation LLTreatmentViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _treatmentLabel = [[UILabel alloc] initWithFrame:CGRectMake(352, 92, 320, 48)];
    [_treatmentLabel setBackgroundColor:BLUE];
    [_treatmentLabel setText:@"Select Treatment Type"];
    [_treatmentLabel setTextColor:[UIColor whiteColor]];
    [_treatmentLabel setTextAlignment:NSTextAlignmentCenter];
    
    [self.view addSubview:_treatmentLabel];
    
	// Do any additional setup after loading the view.
    [self setTitle:[NSString stringWithFormat:@"Select Treatment for %@",[[LLTreatmentManager sharedInstance] patientName]]];
    [self setTreatments:[NSArray arrayWithObjects:@"CT Scan", @"MRI Scan", @"PET Scan", @"X-Ray", nil]];
    [[_treatmentLabel layer] setCornerRadius:5];
    _treatmentTableView = [[UITableView alloc] initWithFrame:CGRectMake(352,200,320,44*[_treatments count]) style:UITableViewStylePlain];
    [_treatmentTableView setDataSource:self];
    [_treatmentTableView setDelegate:self];
    [[self view] addSubview:_treatmentTableView];
    [[_treatmentTableView layer] setCornerRadius:5];
    [_treatmentTableView setBackgroundColor:[UIColor colorWithWhite:0.9 alpha:0.4]];
}

#warning testing code
-(void)viewDidAppear:(BOOL)animated
{
//    [self performSegueWithIdentifier:@"showLocation" sender:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"TreatmentCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
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
    LLMriViewController *vc = [[LLMriViewController alloc] init];
    [[self navigationController] pushViewController:vc animated:YES];
}

@end
