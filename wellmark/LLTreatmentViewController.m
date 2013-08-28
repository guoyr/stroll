//
//  LLTreatmentViewController.m
//  wellmark
//
//  Created by Robert Guo on 8/27/13.
//  Copyright (c) 2013 Stroll. All rights reserved.
//

#import "LLTreatmentViewController.h"

@interface LLTreatmentViewController ()

@property (nonatomic, strong) NSArray *treatments;

@end

@implementation LLTreatmentViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self setTitle:[NSString stringWithFormat:@"Select Treatment for %@", _patientName]];
    [self setTreatments:[NSArray arrayWithObjects:@"CT Scan", @"MRI Scan", @"Ultrasound", nil]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
}

@end
