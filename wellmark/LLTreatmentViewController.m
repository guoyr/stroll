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
#import "DetailViewController.h"
#define CELL_HEIGHT 44

@interface LLTreatmentViewController ()

@property (nonatomic, strong) NSArray *treatments;
@property (nonatomic, strong) NSString *selectedTreatment;
@property (strong, nonatomic) UITableView *treatmentTableView;

@end

@implementation LLTreatmentViewController{
    NSArray *treatments;
    NSArray *detail;
    NSArray *thumbnails;
}
@synthesize treatments;
@synthesize tableView2;
- (void)viewDidLoad
{
    [super viewDidLoad];
	 //Do any additional setup after loading the view.
 //   [self setTitle:[NSString stringWithFormat:@"Select Treatment for %@",[[LLTreatmentManager sharedInstance] patientName]]];
  //  [self setTreatments:[NSArray arrayWithObjects:@"CT Scan", @"MRI Scan", @"PET Scan", @"EKG", @"X-Ray", nil]];
  //  [[_treatmentLabel layer] setCornerRadius:5];
  //  _treatmentTableView = [[UITableView alloc] initWithFrame:CGRectMake(352,200,320,44*[treatments count]) style:UITableViewStylePlain];
   // [_treatmentTableView setDataSource:self];
   // [_treatmentTableView setDelegate:self];
   // [[self view] addSubview:_treatmentTableView];
   // [[_treatmentTableView layer] setCornerRadius:5];
  //  [_treatmentTableView setBackgroundColor:[UIColor colorWithWhite:0.9 alpha:0.4]];
    treatments = [NSArray arrayWithObjects:@"CT Scan", @"MRI Scan", @"PET Scan", @"EKG", @"X-Ray", nil];    detail = [NSArray arrayWithObjects:@"", @"", @"", @"", @"", nil];
    thumbnails = [NSArray arrayWithObjects:@"Tim.png",@"Jordan.png",@"matt.png",@"Andrew.png",@"Sameer.png",nil];
}

#warning testing code
-(void)viewDidAppear:(BOOL)animated
{
   //[self performSegueWithIdentifier:@"showLocation" sender:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView.tag == 2000) {
        static NSString *CellIdentifier = @"TreatmentCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        [[cell textLabel] setText:[detail objectAtIndex:[indexPath row]]];
        
        cell.imageView.image = [UIImage imageNamed:@"what.png"];
        return cell;
    }else {
        static NSString *cellIdetify2 = @"DetailCell";
        UITableViewCell *cell2 = [tableView dequeueReusableCellWithIdentifier:cellIdetify2];
        if (!cell2) {
            cell2 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdetify2];
        }
        [[cell2 textLabel] setText:[treatments objectAtIndex:[indexPath row]]];
        cell2.imageView.image = [UIImage imageNamed:[thumbnails objectAtIndex:indexPath.row]];
        return cell2;
        
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{   if(tableView.tag == 2000){
    return [detail count];
}else{
    return [treatments count];
}
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{   if(tableView.tag == 2000){
    //UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    //_selectedTreatment = [[cell textLabel] text];
    //[[LLTreatmentManager sharedInstance] setSelectedTreatment:_selectedTreatment];
    [self performSegueWithIdentifier:@"showDetail" sender:self];
}else{
    //UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    //_selectedTreatment = [[cell textLabel] text];
   // [[LLTreatmentManager sharedInstance] setSelectedTreatment:_selectedTreatment];
    [self performSegueWithIdentifier:@"showLocation" sender:self];
}

}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView2 indexPathForSelectedRow];
        DetailViewController *destViewController = segue.destinationViewController;
        destViewController.methodName = [treatments objectAtIndex:indexPath.row];
    }
}
@end
