//
//  LLLocationsViewController.m
//  wellmark
//
//  Created by Robert Guo on 8/27/13.
//  Copyright (c) 2013 Stroll. All rights reserved.
//

#import "LLLocationsViewController.h"

@interface LLLocationsViewController ()

@property (nonatomic, strong) NSMutableArray *locationsList;
@property (nonatomic, strong) NSMutableArray *locationsViewList;

@end

@implementation LLLocationsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [[self scrollView] setBackgroundColor:[UIColor redColor]];
    int curX = 0, curY = 0;
    for (int i = 0; i < 5; i++) {
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
        LLLocationView *curLocationView = [[LLLocationView alloc] initWithFrame:CGRectMake(curX, curY, 300, 300)];
        [curLocationView addGestureRecognizer:tapGestureRecognizer];
        [[self scrollView] addSubview:curLocationView];
        curX += 400;
    }
    [[self scrollView] setContentSize:CGSizeMake(curX+300, 400)];
    
    //TODO: title name - treatment
    
}

- (void)viewTapped:(id)sender
{
    NSLog(@"here");
    [self performSegueWithIdentifier:@"ShowSchedulingOptions" sender:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
