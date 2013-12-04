//
//  LLBookLaterViewController.m
//  wellmark
//
//  Created by Robert Guo on 8/28/13.
//  Copyright (c) 2013 Stroll. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import "LLBookLaterViewController.h"
#import "LLTreatmentManager.h"
#import "LLColors.h"
#import "LLViewController.h"

@interface LLBookLaterViewController ()

@property (nonatomic, strong) NSString *emailAddress;

@property (nonatomic, strong) UILabel *enterEmailLabel;
@property (nonatomic, strong) UITextField *emailField;
@property (nonatomic, strong) UIButton *sendEmailButton;
@property (nonatomic, strong) UIBarButtonItem *finishButtonItem;


-(void)sendEmail:(id)sender;
-(void)finish:(id)sender;

@end

@implementation LLBookLaterViewController
@synthesize email=_email;
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    _enterEmailLabel = [[UILabel alloc] initWithFrame:CGRectMake(312, 100, 400, 48)];
    [_enterEmailLabel setBackgroundColor:BLUE];
    [_enterEmailLabel setFont:[UIFont systemFontOfSize:18]];
    [[self view] addSubview:_enterEmailLabel];
    
    _finishButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Finish" style:UIBarButtonItemStylePlain target:self action:@selector(finish:)];
    [self.navigationItem setRightBarButtonItem:_finishButtonItem];
    
    _emailField = [[UITextField alloc] initWithFrame:CGRectMake(312, 173, 320, 48)];
    [_emailField setBackgroundColor:[UIColor lightTextColor]];
    [[self view] addSubview:_emailField];
    [_emailField setDelegate:self];
    [_emailField setAutocorrectionType:UITextAutocorrectionTypeNo];
    [_emailField setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    

    _sendEmailButton = [[UIButton alloc] initWithFrame:CGRectMake(640, 173, 72, 48)];
    [_sendEmailButton setBackgroundColor:TORQUOISE];
    [_sendEmailButton setTitle:@"Send" forState:UIControlStateNormal];
    [[self view] addSubview:_sendEmailButton];
    
    [_sendEmailButton addTarget:self action:@selector(sendEmail:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [[_sendEmailButton layer] setCornerRadius:5.0];
    _emailAddress = [[LLTreatmentManager sharedInstance] getEmail];
    if (!_emailAddress) {
        [_enterEmailLabel setText:@"Please enter your email address to schedule"];
        [_enterEmailLabel setTextColor:[UIColor whiteColor]];
        [_enterEmailLabel setTextAlignment:NSTextAlignmentCenter];
        [_sendEmailButton setHidden:YES];
        [_sendEmailButton setEnabled:NO];
    } else {
        [_enterEmailLabel setText:@"Please confirm your email address"];
        [_emailField setText:_emailAddress];
    }
    
    [[_enterEmailLabel layer] setCornerRadius:5];
    [[_emailField layer] setCornerRadius:5];
    [[_sendEmailButton layer] setCornerRadius:5];


    UITapGestureRecognizer *gr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedView:)];
    [[self view] addGestureRecognizer:gr];
    
    _email = [[LLTreatmentManager sharedInstance] getEmailContent];
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(312, 250, 400, 400)];
    [_webView setBackgroundColor:[UIColor colorWithWhite:1 alpha:0.3]];

    [_webView setDelegate:self];
//    [_webView setUserInteractionEnabled:NO];
    [[self view] addSubview:_webView];
    
    [_webView loadHTMLString: _email baseURL: nil];
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
    

        
//    MSTable *table = [[LLTreatmentManager sharedInstance].client getTable:@"emailDummy"];
    NSMutableDictionary *item = [[NSMutableDictionary alloc] init];
    [item setObject:_email forKey:@"text"];
    [item setObject:_emailAddress forKey:@"patientEmail"];
    [item setObject:@"robert@strollhealth.com" forKey:@"from"];
    MSClient *newClient = [MSClient clientWithApplicationURLString:@"https://strollmobile.azure-mobile.net/"
                                                withApplicationKey:@"VWHKZcntaIYDRsbZWEowEyvKiLfTWi91"];
    MSTable *table = [newClient getTable:@"emailDummy"];
    [table insert:[NSDictionary dictionaryWithDictionary:item] completion:^(NSDictionary *item, NSError *error) {
        if (error) {
            NSLog(@"%@",error);
        }
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Email Sent!"
                                                        message:[NSString stringWithFormat:@"Please check your inbox for instructions on how to schedule an appointment at %@.", providerName]
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        [_sendEmailButton setTitle:@"Sent!" forState:UIControlStateNormal];
        [_sendEmailButton setEnabled:NO];
        
    }];
    
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
