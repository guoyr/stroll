//
//  LLBookLaterViewController.m
//  wellmark
//
//  Created by Robert Guo on 8/28/13.
//  Copyright (c) 2013 Stroll. All rights reserved.
//
#import <Parse/Parse.h>
#import <QuartzCore/QuartzCore.h>
#import "LLBookLaterViewController.h"
#import "LLTreatmentManager.h"

@interface LLBookLaterViewController ()

@property (nonatomic, strong) NSString *emailAddress;

@end

@implementation LLBookLaterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [[LLTreatmentManager sharedInstance] addBackground:[self view]];
    [[_sendEmailButton layer] setCornerRadius:5.0];
    [_sendEmailButton setHidden:YES];
    [_sendEmailButton setEnabled:NO];

}

-(void)sendEmail:(id)sender
{
    NSMutableDictionary *params = [NSMutableDictionary  dictionaryWithObject:_emailAddress forKey:@"to"];
    [params setObject:[[LLTreatmentManager sharedInstance] patientName] forKey:@"toname"];
    [params setObject:@"Stroll Inc." forKey:@"fromname"];
    [PFCloud callFunctionInBackground:@"emailTest" withParameters:params block:^(id object, NSError *error){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Email Sent"
                                                        message:@"Check your inbox!"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];

        NSLog(@"done");
        NSLog(@"%@",object);
        NSLog(@"%@", error);
    } ];

}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    _emailAddress = [textField text];
    [_sendEmailButton setHidden:NO];
    [_sendEmailButton setEnabled:YES];
    [textField resignFirstResponder];
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
