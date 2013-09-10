//
//  LLSelectDoctorViewController.m
//  wellmark
//
//  Created by Robert Guo on 9/1/13.
//  Copyright (c) 2013 Stroll. All rights reserved.
//

#import "LLSelectDoctorViewController.h"

@interface LLSelectDoctorViewController ()

@property (nonatomic, strong) NSIndexPath *selectedIndexPath;

@end

@implementation LLSelectDoctorViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(defaultsChanged:) name:NSUserDefaultsDidChangeNotification object:nil];

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setDoctors:[[NSUserDefaults standardUserDefaults] arrayForKey:@"Doctors"] ];
}

-(void)defaultsChanged:(id)sender
{
    [self setDoctors:[[NSUserDefaults standardUserDefaults] arrayForKey:@"Doctors"] ];
    [[self tableView] reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_doctors count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"DoctorCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    [[cell textLabel] setNumberOfLines:1];
    [[cell textLabel] setLineBreakMode:NSLineBreakByWordWrapping];
    [[cell textLabel] setText:[[self doctors] objectAtIndex:[indexPath row]]];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[self delegate] selectedDoctor:[_doctors objectAtIndex:[indexPath row]]];
    
    UITableViewCell *oldCell = [tableView cellForRowAtIndexPath:_selectedIndexPath];
    [oldCell setAccessoryType:UITableViewCellAccessoryNone];
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
    
    _selectedIndexPath = indexPath;
}

@end
