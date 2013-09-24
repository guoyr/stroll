//
//  LLSelectInsuranceViewController.m
//  wellmark
//
//  Created by Robert Guo on 9/1/13.
//  Copyright (c) 2013 Stroll. All rights reserved.
//

#import "LLSelectInsuranceViewController.h"

@interface LLSelectInsuranceViewController ()

@property (nonatomic, strong) NSIndexPath *selectedIndexPath;

@end

@implementation LLSelectInsuranceViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        [self setInsurances:[NSArray arrayWithObjects:@"Wellmark Blue Cross Blue Shield", @"Medicare", @"No Insurance", nil]];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *label =  [_insurances objectAtIndex:indexPath.row];
    CGSize stringSize = [label sizeWithFont:[UIFont systemFontOfSize:18]
                          constrainedToSize:CGSizeMake(160, 9999)
                              lineBreakMode:NSLineBreakByWordWrapping];
    return stringSize.height + 25;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_insurances count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"InsuranceCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    [[cell textLabel] setNumberOfLines:2];
    [[cell textLabel] setLineBreakMode:NSLineBreakByWordWrapping];
    [[cell textLabel] setText:[[self insurances] objectAtIndex:[indexPath row]]];
    // Configure the cell...
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[self delegate] selectedInsurance:[_insurances objectAtIndex:[indexPath row]]];
    
    UITableViewCell *oldCell = [tableView cellForRowAtIndexPath:_selectedIndexPath];
    [oldCell setAccessoryType:UITableViewCellAccessoryNone];
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
    
    _selectedIndexPath = indexPath;
}

@end
