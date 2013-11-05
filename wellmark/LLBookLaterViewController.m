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
    [[_sendEmailButton layer] setCornerRadius:5.0];
    _emailAddress = [[LLTreatmentManager sharedInstance] getEmail];
    if (!_emailAddress) {
        [_enterEmailLabel setText:@"To schedule, please enter your email address"];
        [_sendEmailButton setHidden:YES];
        [_sendEmailButton setEnabled:NO];
    } else {
        [_enterEmailLabel setText:@"Please confirm your email address"];
        [_emailField setText:_emailAddress];
    }
#warning testing code
    _emailAddress = @"gyrccc@gmail.com";
    [_sendEmailButton setHidden:NO];
    [_sendEmailButton setEnabled:YES];
    
    
    
    [[_enterEmailLabel layer] setCornerRadius:5];
    [[_emailField layer] setCornerRadius:5];
    [[_sendEmailButton layer] setCornerRadius:5];


    UITapGestureRecognizer *gr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedView:)];
    [[self view] addGestureRecognizer:gr];

}

-(void)tappedView:(id)sender
{
    if ([_emailField isFirstResponder]) {
        [_emailField resignFirstResponder];
    }
}

-(void)sendEmail:(id)sender
{
    __block NSString *patientName = [[LLTreatmentManager sharedInstance] patientName];
    __block NSString *providerName = [[LLTreatmentManager sharedInstance] getProviderName];
    __block NSString *selectedTreatment = [[LLTreatmentManager sharedInstance] selectedTreatment];
    __block NSString *providerPhone = [[LLTreatmentManager sharedInstance] getProviderPhone];
    NSRange range;
    range.location = 3;
    range.length = 3;
    providerPhone = [NSString stringWithFormat:@"(%@)%@-%@", [providerPhone substringToIndex:3], [providerPhone substringWithRange:range], [providerPhone substringFromIndex:6] ];

    NSMutableDictionary *params = [NSMutableDictionary  dictionaryWithObject:_emailAddress forKey:@"to"];
    [params setObject: patientName forKey:@"toname"];
    [params setObject:@"Stroll Inc." forKey:@"fromname"];
//    NSError *error;
//    NSString *emailContent = [[NSString alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"email" ofType:@"html"] encoding:NSASCIIStringEncoding error:&error];
//    NSLog(@"%@", emailContent);
    //    [params setObject:@"" forKey:@"html"];

    [params setObject:[NSString stringWithFormat:@"<style type=\"text/css\">p{font-family: \"Arial\";}tr{font-family: \"Arial\";}</style><p>Dear %@, Please call %@ to schedule a %@ with %@.</p><p>Thank you for using Stroll. You saved $800.</p><table border=1><tr><td>Actual Price</td><td>$700</td></tr><tr><td>Default Price</td><td>$1500</td></tr></table><img src=\"cid:ii_139db99fdb5c3704\">", patientName, providerPhone, selectedTreatment, providerName] forKey:@"html"];

    [params setObject:[NSDictionary dictionaryWithObject:@"cid:ii_139db99fdb5c3704" forKey:@"img1"] forKey:@"content"];
    [PFCloud callFunctionInBackground:@"emailTest" withParameters:params block:^(id object, NSError *error){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Email Sent"
                                                        message:[NSString stringWithFormat:@"Please check your inbox for instructions on how to schedule an appointment at %@.", providerName]
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        [_sendEmailButton setTitle:@"Email Sent!" forState:UIControlStateNormal];
        [_sendEmailButton setEnabled:NO];

        NSLog(@"done");
        NSLog(@"%@",object);
        NSLog(@"%@", error);
    } ];

}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [textField setText:@""];
    return YES;
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    if ([textField text]) {
        _emailAddress = [textField text];
        [_sendEmailButton setHidden:NO];
        [_sendEmailButton setEnabled:YES];
    }
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)finish:(id)sender
{
//    [self performSegueWithIdentifier:@"backToBeginning" sender:self];
    [[LLTreatmentManager sharedInstance].client logout];
    [[self navigationController] popToRootViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
