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
    [params setObject:[NSString stringWithFormat: @"<!DOCTYPE HTML PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional //EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\"><html><head><title></title><meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\"><meta name=\"viewport\" content=\"width=320, target-densitydpi=device-dpi\"><!--[if gte mso 9]><style _tmplitem=\"1018\" >.article-content ol, .article-content ul {smargin: 0 0 0 24px;spadding: 0;slist-style-position: inside;}</style><![endif]--></head><body><table width=\"100%%\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\" id=\"background-table\">	<tbody><tr>s<td align=\"center\" bgcolor=\"#ececec\">s<table class=\"w640\" style=\"margin:0 10px;\" width=\"640\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\">s<tbody><tr><td class=\"w640\" width=\"640\" height=\"20\"></td></tr>ss<tr>s<td class=\"w640\" width=\"640\">s<table id=\"top-bar\" class=\"w640\" width=\"640\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\" bgcolor=\"#3498DB\">s<tbody><tr>s<td class=\"w15\" width=\"15\"></td>s<td class=\"w325\" width=\"350\" valign=\"middle\" align=\"left\">s<table class=\"w325\" width=\"350\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\">s<tbody><tr><td class=\"w325\" width=\"350\" height=\"8\"></td></tr>s</tbody></table>s<div class=\"header-content\"><webversion>Web Version</webversion><span class=\"hide\">&nbsp;&nbsp;|&nbsp; <preferences lang=\"en\">Update preferences</preferences>&nbsp;&nbsp;|&nbsp; <unsubscribe>Unsubscribe</unsubscribe></span></div>s<table class=\"w325\" width=\"350\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\">s<tbody><tr><td class=\"w325\" width=\"350\" height=\"8\"></td></tr>s</tbody></table>s</td>s<td class=\"w30\" width=\"30\"></td>s<td class=\"w255\" width=\"255\" valign=\"middle\" align=\"right\">s<table class=\"w255\" width=\"255\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\">s<tbody><tr><td class=\"w255\" width=\"255\" height=\"8\"></td></tr>s</tbody></table>s<table cellpadding=\"0\" cellspacing=\"0\" border=\"0\">s<tbody><tr>ss<td valign=\"middle\"><fblike><img src=\"https://img.createsend1.com/img/templatebuilder/like-glyph.png\" border=\"0\" width=\"8\" height=\"14\" alt=\"Facebook icon\"=\"\"></fblike></td>s<td width=\"3\"></td>s<td valign=\"middle\"><div class=\"header-content\"><fblike>Like</fblike></div></td>sss<td class=\"w10\" width=\"10\"></td>s<td valign=\"middle\"><tweet><img src=\"https://img.createsend1.com/img/templatebuilder/tweet-glyph.png\" border=\"0\" width=\"17\" height=\"13\" alt=\"Twitter icon\"=\"\"></tweet></td>s<td width=\"3\"></td>s<td valign=\"middle\"><div class=\"header-content\"><tweet>Tweet</tweet></div></td>sss</tr></tbody></table>s<table class=\"w255\" width=\"255\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\">s<tbody><tr><td class=\"w255\" width=\"255\" height=\"8\"></td></tr>s</tbody></table>s</td>s<td class=\"w15\" width=\"15\"></td>s</tr></tbody></table>ss</td>s</tr>s<tr>s<td id=\"header\" class=\"w640\" width=\"640\" align=\"center\" bgcolor=\"#3498DB\">ss<div align=\"center\" style=\"text-align: center\">s<a href=\"https://www.facebook.com/strollhealth\">s<img id=\"customHeaderImage\" label=\"Header Image\" editable=\"true\" width=\"640\" src=\"\" class=\"w640\" border=\"0\" align=\"top\" style=\"display: inline\">s</a>s</div>ss</td>s</tr>ss<tr><td class=\"w640\" width=\"640\" height=\"30\" bgcolor=\"#ffffff\"></td></tr>s<tr id=\"simple-content-row\"><td class=\"w640\" width=\"640\" bgcolor=\"#ffffff\">s<table class=\"w640\" width=\"640\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\">s<tbody><tr>s<td class=\"w30\" width=\"30\"></td>s<td class=\"w580\" width=\"580\">s<repeater>ss<layout label=\"Text only\">s<table class=\"w580\" width=\"580\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\">s<tbody><tr>s<td class=\"w580\" width=\"580\">s<p align=\"left\" class=\"article-title\"><singleline label=\"Title\">Dear Mary,</singleline></p>s<div align=\"left\" class=\"article-content\">s<multiline label=\"Description\">You're almost finished booking your appointment.<br><br>Please call <b>(number)</b> to schedule a (procedure) with (doctor) at (location).<br><br>Your out of pocket cost will be <b>(price)</b> based on your current deductible status with (Wellmark Blue Cross Blue Shield).<br><br>Below is some follow-up information we've gathered just for you. Thanks for booking your appointment with Stroll!<br><br>Have a healthful day.<br><br></multiline>s</div>s</td>s</tr>s<tr><td class=\"w580\" width=\"580\" height=\"10\"></td></tr>s</tbody></table>s</layout>ss<layout label=\"Text with right-aligned image\">s<table class=\"w580\" width=\"580\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\">s<tbody><tr>s<td class=\"w580\" width=\"580\">s<h4 style=\"color: #3498db\" align=\"left\">More Information</h4>s<div align=\"left\" class=\"article-content\">s<multiline label=\"Description\">Everything you need to know about (Magnetic Resonance Imaging (MRI)).<br><br><h3>Description</h3><br>MRI is magnetic resonance imaging, a special imaging test that does not use x-rays. A MRI uses magnetic fields to create detailed pictures inside the body and/or head. It can detect subtle changes in the tissues. A MRI is better than a CT scan (CAT scan) at identifying disease of the soft tissues such as nerves, ligaments, tendons and muscles.<br><br><h3>Possible Complications</h3>s<br>None if the contrast gadolinium is not used. Gadolinium has been associated with a serious skin and connective tissue disease called nephrogenic systemic fibrosis (NSF). Patients with chronic kidney disease are at increased risk of developing NSF after gadolinium. <a href=\"http://www.fda.gov/Drugs/DrugSafety/DrugSafetyNewsletter/ucm142889.htm\">More info...</a><br></multiline>s</div>s<table cellpadding=\"0\" cellspacing=\"0\" border=\"0\" align=\"right\">s<tbody><tr>s<td class=\"w30\" width=\"15\"></td>s<td><img src=\"\" alt=\"iTriage\" editable=\"true\" label=\"Image\" class=\"w300\" width=\"100\" border=\"0\"></td>s</tr>s<tr><td class=\"w30\" width=\"15\" height=\"5\"></td><td></td></tr>s</tbody></table>s<div align=\"left\" class=\"article-content\"><p><br><em>Reviewed by Harvard Medical School via <a href=\"https://itriage.com\">iTriage</a></em></p>s</div>ss</td>s</tr>s<tr><td class=\"w580\" width=\"580\" height=\"10\"></td></tr>s</tbody></table>s</layout>ss</repeater>s</td>s<td class=\"w30\" width=\"30\"></td>s</tr>s</tbody></table></td></tr>s<tr><td class=\"w640\" width=\"640\" height=\"15\" bgcolor=\"#ffffff\"></td></tr>ss<tr>s<td class=\"w640\" width=\"640\">s<table id=\"footer\" class=\"w640\" width=\"640\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\" bgcolor=\"#3498db\">s<tbody><tr><td class=\"w30\" width=\"30\"></td><td class=\"w580 h0\" width=\"360\" height=\"30\"></td><td class=\"w0\" width=\"60\"></td><td class=\"w0\" width=\"160\"></td><td class=\"w30\" width=\"30\"></td></tr>s<tr>s<td class=\"w30\" width=\"30\"></td>s<td class=\"w580\" width=\"360\" valign=\"top\">s<span class=\"hide\"><p id=\"permission-reminder\" align=\"left\" class=\"footer-content-left\"><span>You're receiving this because you booked an appointment using Stroll Health in your doctor's office.</span></p></span>s<p align=\"left\" class=\"footer-content-left\"><preferences lang=\"en\">Edit your subscription</preferences> | <unsubscribe>Unsubscribe</unsubscribe></p>s</td>s<td class=\"hide w0\" width=\"60\"></td>s<td class=\"hide w0\" width=\"160\" valign=\"top\">s<p id=\"street-address\" align=\"right\" class=\"footer-content-right\"></p>s</td>s<td class=\"w30\" width=\"30\"></td>s</tr>s<tr><td class=\"w30\" width=\"30\"></td><td class=\"w580 h0\" width=\"360\" height=\"15\"></td><td class=\"w0\" width=\"60\"></td><td class=\"w0\" width=\"160\"></td><td class=\"w30\" width=\"30\"></td></tr>s</tbody></table></td>s</tr>s<tr><td class=\"w640\" width=\"640\" height=\"60\"></td></tr>s</tbody></table>s</td>	</tr></tbody></table></body></html>"] forKey:@"html"];
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
    [[self navigationController] popToRootViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
