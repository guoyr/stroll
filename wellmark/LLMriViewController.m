//
//  LLMriViewController.m
//  wellmark
//
//  Created by SunDu on 11/25/13.
//  Copyright (c) 2013 Stroll. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "LLTreatmentViewController.h"
#import "LLLocationsViewController.h"
#import "LLTreatmentManager.h"
#import "LLColors.h"
#define CELL_HEIGHT 44
#import "LLMriViewController.h"

@interface LLMriViewController ()
@property (strong, nonatomic) UILabel *treatmentLabel;

@property (nonatomic, strong) NSArray *treatments;
@property (nonatomic, strong) NSString *selectedTreatment;
@property (strong, nonatomic) UITableView *treatmentTableView;
@end

@implementation LLMriViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    _treatmentLabel = [[UILabel alloc] initWithFrame:CGRectMake(352, 92, 320, 48)];
    [_treatmentLabel setBackgroundColor:TORQUOISE];
    [self.view addSubview:_treatmentLabel];
    
	// Do any additional setup after loading the view.
    [self setTitle:[NSString stringWithFormat:@"Select Treatment for %@",[[LLTreatmentManager sharedInstance] patientName]]];
    [self setTreatments:[NSArray arrayWithObjects:@"tooyoungtosimple", @"tooyoungtoonaive", @"Ptooyoungtooexcited", @"nooboftheyear", nil]];
    [[_treatmentLabel layer] setCornerRadius:5];
    _treatmentTableView = [[UITableView alloc] initWithFrame:CGRectMake(352,200,320,44*[_treatments count]) style:UITableViewStylePlain];
    [_treatmentTableView setDataSource:self];
    [_treatmentTableView setDelegate:self];
    [[self view] addSubview:_treatmentTableView];
    [[_treatmentTableView layer] setCornerRadius:5];
    [_treatmentTableView setBackgroundColor:[UIColor colorWithWhite:0.9 alpha:0.4]];
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
    LLLocationsViewController *vc = [[LLLocationsViewController alloc] init];
    [[self navigationController] pushViewController:vc animated:YES];
}

@end
