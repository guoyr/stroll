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
#import "LLColors.h"

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

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    _enterEmailLabel = [[UILabel alloc] initWithFrame:CGRectMake(312, 150, 400, 48)];
    [_enterEmailLabel setBackgroundColor:[UIColor blueColor]];
    [[self view] addSubview:_enterEmailLabel];
    
    _finishButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Finish" style:UIBarButtonItemStylePlain target:self action:@selector(finish:)];
    [self.navigationItem setRightBarButtonItem:_finishButtonItem];
    
    _emailField = [[UITextField alloc] initWithFrame:CGRectMake(312, 223, 320, 48)];
    [_emailField setBackgroundColor:[UIColor lightTextColor]];
    [[self view] addSubview:_emailField];
    [_emailField setDelegate:self];
 
     _emailField.autocorrectionType = UITextAutocorrectionTypeNo;

    _sendEmailButton = [[UIButton alloc] initWithFrame:CGRectMake(640, 223, 160, 48)];
    [_sendEmailButton setBackgroundColor:TORQUOISE];
    [_sendEmailButton setTitle:@"Send Email" forState:UIControlStateNormal];
    [[self view] addSubview:_sendEmailButton];
    
    [_sendEmailButton addTarget:self action:@selector(sendEmail:) forControlEvents:UIControlEventTouchUpInside];
    
    
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

    NSString *email = @"<!DOCTYPE HTML PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional //EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\"><html><head><title></title><meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\"><meta name=\"viewport\" content=\"width=320, target-densitydpi=device-dpi\">\n<style type=\"text/css\">\n/* Mobile-specific Styles */\n@media only screen and (max-width: 660px) { \ntable[class=w0], td[class=w0] { width: 0 !important; }\ntable[class=w10], td[class=w10], img[class=w10] { width:10px !important; }\ntable[class=w15], td[class=w15], img[class=w15] { width:5px !important; }\ntable[class=w30], td[class=w30], img[class=w30] { width:10px !important; }\ntable[class=w60], td[class=w60], img[class=w60] { width:10px !important; }\ntable[class=w125], td[class=w125], img[class=w125] { width:80px !important; }\ntable[class=w130], td[class=w130], img[class=w130] { width:55px !important; }\ntable[class=w140], td[class=w140], img[class=w140] { width:90px !important; }\ntable[class=w160], td[class=w160], img[class=w160] { width:180px !important; }\ntable[class=w170], td[class=w170], img[class=w170] { width:100px !important; }\ntable[class=w180], td[class=w180], img[class=w180] { width:80px !important; }\ntable[class=w195], td[class=w195], img[class=w195] { width:80px !important; }\ntable[class=w220], td[class=w220], img[class=w220] { width:80px !important; }\ntable[class=w240], td[class=w240], img[class=w240] { width:180px !important; }\ntable[class=w255], td[class=w255], img[class=w255] { width:185px !important; }\ntable[class=w275], td[class=w275], img[class=w275] { width:135px !important; }\ntable[class=w280], td[class=w280], img[class=w280] { width:135px !important; }\ntable[class=w300], td[class=w300], img[class=w300] { width:140px !important; }\ntable[class=w325], td[class=w325], img[class=w325] { width:95px !important; }\ntable[class=w360], td[class=w360], img[class=w360] { width:140px !important; }\ntable[class=w410], td[class=w410], img[class=w410] { width:180px !important; }\ntable[class=w470], td[class=w470], img[class=w470] { width:200px !important; }\ntable[class=w580], td[class=w580], img[class=w580] { width:280px !important; }\ntable[class=w640], td[class=w640], img[class=w640] { width:300px !important; }\ntable[class*=hide], td[class*=hide], img[class*=hide], p[class*=hide], span[class*=hide] { display:none !important; }\ntable[class=h0], td[class=h0] { height: 0 !important; }\np[class=footer-content-left] { text-align: center !important; }\n#headline p { font-size: 30px !important; }\n.article-content, #left-sidebar{ -webkit-text-size-adjust: 90% !important; -ms-text-size-adjust: 90% !important; }\n.header-content, .footer-content-left {-webkit-text-size-adjust: 80% !important; -ms-text-size-adjust: 80% !important;}\nimg { height: auto; line-height: 100%;}\n } \n/* Client-specific Styles */\n#outlook a { padding: 0; } /* Force Outlook to provide a \"view in browser\" button. */\nbody { width: 100% !important; }\n.ReadMsgBody { width: 100%; }\n.ExternalClass { width: 100%; display:block !important; } /* Force Hotmail to display emails at full width */\n/* Reset Styles */\n/* Add 100px so mobile switch bar doesn't cover street address. */\nbody { background-color: #ececec; margin: 0; padding: 0; }\nimg { outline: none; text-decoration: none; display: block;}\nbr, strong br, b br, em br, i br { line-height:100%; }\nh1, h2, h3, h4, h5, h6 { line-height: 100% !important; -webkit-font-smoothing: antialiased; }\nh1 a, h2 a, h3 a, h4 a, h5 a, h6 a { color: blue !important; }\nh1 a:active, h2 a:active, h3 a:active, h4 a:active, h5 a:active, h6 a:active { color: red !important; }\n/* Preferably not the same color as the normal header link color. There is limited support for psuedo classes in email clients, this was added just for good measure. */\nh1 a:visited, h2 a:visited, h3 a:visited, h4 a:visited, h5 a:visited, h6 a:visited { color: purple !important; }\n/* Preferably not the same color as the normal header link color. There is limited support for psuedo classes in email clients, this was added just for good measure. */ \ntable td, table tr { border-collapse: collapse; }\n.yshortcuts, .yshortcuts a, .yshortcuts a:link,.yshortcuts a:visited, .yshortcuts a:hover, .yshortcuts a span {\ncolor: black; text-decoration: none !important; border-bottom: none !important; background: none !important;\n} /* Body text color for the New Yahoo. This example sets the font of Yahoo's Shortcuts to black. */\n/* This most probably won't work in all email clients. Don't include code blocks in email. */\ncode {\n white-space: normal;\n word-break: break-all;\n}\n#background-table { background-color: #ececec; }\n/* Webkit Elements */\n#top-bar { border-radius:6px 6px 0px 0px; -moz-border-radius: 6px 6px 0px 0px; -webkit-border-radius:6px 6px 0px 0px; -webkit-font-smoothing: antialiased; background-color: #2980b9; color: #E2E2E2; }\n#top-bar a { font-weight: bold; color: #bdc3c7; text-decoration: none;}\n#footer { border-radius:0px 0px 6px 6px; -moz-border-radius: 0px 0px 6px 6px; -webkit-border-radius:0px 0px 6px 6px; -webkit-font-smoothing: antialiased; }\n/* Fonts and Content */\nbody, td { font-family: 'Helvetica Neue', Arial, Helvetica, sans-serif; }\n.header-content, .footer-content-left, .footer-content-right { -webkit-text-size-adjust: none; -ms-text-size-adjust: none; }\n/* Prevent Webkit and Windows Mobile platforms from changing default font sizes on header and footer. */\n.header-content { font-size: 12px; color: #E2E2E2; }\n.header-content a { font-weight: bold; color: #bdc3c7; text-decoration: none; }\n#headline p { color: #ecf0f1; font-family: 'Helvetica Neue', Arial, Helvetica, Geneva, sans-serif; font-size: 36px; text-align: center; margin-top:0px; margin-bottom:30px; }\n#headline p a { color: #ecf0f1; text-decoration: none; }\n.article-title { font-size: 18px; line-height:24px; color: #3498db; font-weight:bold; margin-top:0px; margin-bottom:18px; font-family: 'Helvetica Neue', Arial, Helvetica, sans-serif; }\n.article-title a { color: #3498db; text-decoration: none; }\n.article-title.with-meta {margin-bottom: 0;}\n.article-meta { font-size: 13px; line-height: 20px; color: #ccc; font-weight: bold; margin-top: 0;}\n.article-content { font-size: 13px; line-height: 18px; color: #444444; margin-top: 0px; margin-bottom: 18px; font-family: 'Helvetica Neue', Arial, Helvetica, sans-serif; }\n.article-content a { color: #2980b9; font-weight:bold; text-decoration:none; }\n.article-content img { max-width: 100% }\n.article-content ol, .article-content ul { margin-top:0px; margin-bottom:18px; margin-left:19px; padding:0; }\n.article-content li { font-size: 13px; line-height: 18px; color: #444444; }\n.article-content li a { color: #2980b9; text-decoration:underline; }\n.article-content p {margin-bottom: 15px;}\n.footer-content-left { font-size: 12px; line-height: 15px; color: #e2e2e2; margin-top: 0px; margin-bottom: 15px; }\n.footer-content-left a { color: #bdc3c7; font-weight: bold; text-decoration: none; }\n.footer-content-right { font-size: 11px; line-height: 16px; color: #e2e2e2; margin-top: 0px; margin-bottom: 15px; }\n.footer-content-right a { color: #bdc3c7; font-weight: bold; text-decoration: none; }\n#footer { background-color: #3498db; color: #e2e2e2; }\n#footer a { color: #bdc3c7; text-decoration: none; font-weight: bold; }\n#permission-reminder { white-space: normal; }\n#street-address { color: #ecf0f1; white-space: normal; }\n</style>\n<!--[if gte mso 9]>\n<style _tmplitem=\"1018\" >\n.article-content ol, .article-content ul {\n margin: 0 0 0 24px;\n padding: 0;\n list-style-position: inside;\n}\n</style>\n<![endif]--></head><body><table width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\" id=\"background-table\">\n <tbody><tr>\n <td align=\"center\" bgcolor=\"#ececec\">\n <table class=\"w640\" style=\"margin:0 10px;\" width=\"640\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\">\n <tbody><tr><td class=\"w640\" width=\"640\" height=\"20\"></td></tr>\n \n <tr>\n <td class=\"w640\" width=\"640\">\n <table id=\"top-bar\" class=\"w640\" width=\"640\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\" bgcolor=\"#3498DB\">\n <tbody><tr>\n <td class=\"w15\" width=\"15\"></td>\n <td class=\"w325\" width=\"350\" valign=\"middle\" align=\"left\">\n <table class=\"w325\" width=\"350\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\">\n <tbody><tr><td class=\"w325\" width=\"350\" height=\"8\"></td></tr>\n </tbody></table>\n <div class=\"header-content\"><webversion>Web Version</webversion><span class=\"hide\">&nbsp;&nbsp;|&nbsp; <preferences lang=\"en\">Update preferences</preferences>&nbsp;&nbsp;|&nbsp; <unsubscribe>Unsubscribe</unsubscribe></span></div>\n <table class=\"w325\" width=\"350\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\">\n <tbody><tr><td class=\"w325\" width=\"350\" height=\"8\"></td></tr>\n </tbody></table>\n </td>\n <td class=\"w30\" width=\"30\"></td>\n <td class=\"w255\" width=\"255\" valign=\"middle\" align=\"right\">\n <table class=\"w255\" width=\"255\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\">\n <tbody><tr><td class=\"w255\" width=\"255\" height=\"8\"></td></tr>\n </tbody></table>\n <table cellpadding=\"0\" cellspacing=\"0\" border=\"0\">\n <tbody><tr>\n \n <td valign=\"middle\"><fblike><img src=\"https://img.createsend1.com/img/templatebuilder/like-glyph.png\" border=\"0\" width=\"8\" height=\"14\" alt=\"Facebook icon\"=\"\"></fblike></td>\n <td width=\"3\"></td>\n <td valign=\"middle\"><div class=\"header-content\"><fblike>Like</fblike></div></td>\n \n \n <td class=\"w10\" width=\"10\"></td>\n <td valign=\"middle\"><tweet><img src=\"https://img.createsend1.com/img/templatebuilder/tweet-glyph.png\" border=\"0\" width=\"17\" height=\"13\" alt=\"Twitter icon\"=\"\"></tweet></td>\n <td width=\"3\"></td>\n <td valign=\"middle\"><div class=\"header-content\"><tweet>Tweet</tweet></div></td>\n \n \n </tr>\n</tbody></table>\n <table class=\"w255\" width=\"255\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\">\n <tbody><tr><td class=\"w255\" width=\"255\" height=\"8\"></td></tr>\n </tbody></table>\n </td>\n <td class=\"w15\" width=\"15\"></td>\n </tr>\n</tbody></table>\n \n </td>\n </tr>\n <tr>\n <td id=\"header\" class=\"w640\" width=\"640\" align=\"center\" bgcolor=\"#3498DB\">\n \n <div align=\"center\" style=\"text-align: center\">\n <a href=\"https://www.facebook.com/strollhealth\">\n <img id=\"customHeaderImage\" label=\"Header Image\" editable=\"true\" width=\"640\" src=\"/images/emailheader_640.183908.png\" class=\"w640\" border=\"0\" align=\"top\" style=\"display: inline\">\n </a>\n </div>\n \n \n</td>\n </tr>\n \n <tr><td class=\"w640\" width=\"640\" height=\"30\" bgcolor=\"#ffffff\"></td></tr>\n <tr id=\"simple-content-row\"><td class=\"w640\" width=\"640\" bgcolor=\"#ffffff\">\n <table class=\"w640\" width=\"640\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\">\n <tbody><tr>\n <td class=\"w30\" width=\"30\"></td>\n <td class=\"w580\" width=\"580\">\n <repeater>\n \n <layout label=\"Text only\">\n <table class=\"w580\" width=\"580\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\">\n <tbody><tr>\n <td class=\"w580\" width=\"580\">\n <p align=\"left\" class=\"article-title\"><singleline label=\"Title\">Add a title</singleline></p>\n <div align=\"left\" class=\"article-content\">\n <multiline label=\"Description\">Enter your description</multiline>\n </div>\n </td>\n </tr>\n <tr><td class=\"w580\" width=\"580\" height=\"10\"></td></tr>\n </tbody></table>\n </layout>\n \n \n <layout label=\"Text with full-width image\">\n <table class=\"w580\" width=\"580\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\">\n <tbody><tr>\n <td class=\"w580\" width=\"580\">\n <p align=\"left\" class=\"article-title\"><singleline label=\"Title\">Add a title</singleline></p>\n </td>\n </tr>\n <tr>\n <td class=\"w580\" width=\"580\"><img editable=\"true\" label=\"Image\" class=\"w580\" width=\"580\" border=\"0\"></td>\n </tr>\n <tr><td class=\"w580\" width=\"580\" height=\"15\"></td></tr>\n <tr>\n <td class=\"w580\" width=\"580\">\n <div align=\"left\" class=\"article-content\">\n <multiline label=\"Description\">Enter your description</multiline>\n </div>\n </td>\n </tr>\n <tr><td class=\"w580\" width=\"580\" height=\"10\"></td></tr>\n </tbody></table>\n </layout>\n \n \n <layout label=\"Text with right-aligned image\">\n <table class=\"w580\" width=\"580\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\">\n <tbody><tr>\n <td class=\"w580\" width=\"580\">\n <p align=\"left\" class=\"article-title\"><singleline label=\"Title\">Add a title</singleline></p>\n <table cellpadding=\"0\" cellspacing=\"0\" border=\"0\" align=\"right\">\n <tbody><tr>\n <td class=\"w30\" width=\"15\"></td>\n <td><img editable=\"true\" label=\"Image\" class=\"w300\" width=\"300\" border=\"0\"></td>\n </tr>\n <tr><td class=\"w30\" width=\"15\" height=\"5\"></td><td></td></tr>\n </tbody></table>\n <div align=\"left\" class=\"article-content\">\n <multiline label=\"Description\">Enter your description</multiline>\n </div>\n </td>\n </tr>\n <tr><td class=\"w580\" width=\"580\" height=\"10\"></td></tr>\n </tbody></table>\n </layout>\n \n \n <layout label=\"Text with left-aligned image\">\n <table class=\"w580\" width=\"580\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\">\n <tbody><tr>\n <td class=\"w580\" width=\"580\">\n <p align=\"left\" class=\"article-title\"><singleline label=\"Title\">Add a title</singleline></p>\n <table cellpadding=\"0\" cellspacing=\"0\" border=\"0\" align=\"left\">\n <tbody><tr>\n <td><img editable=\"true\" label=\"Image\" class=\"w300\" width=\"300\" border=\"0\"></td>\n <td class=\"w30\" width=\"15\"></td>\n </tr>\n <tr><td></td><td class=\"w30\" width=\"15\" height=\"5\"></td></tr>\n </tbody></table>\n <div align=\"left\" class=\"article-content\">\n <multiline label=\"Description\">Enter your description</multiline>\n </div>\n </td>\n </tr>\n <tr><td class=\"w580\" width=\"580\" height=\"10\"></td></tr>\n </tbody></table>\n </layout>\n \n \n <layout label=\"Two columns\">\n <table class=\"w580\" width=\"580\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\">\n <tbody><tr>\n <td class=\"w275\" width=\"275\" valign=\"top\">\n <table class=\"w275\" width=\"275\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\">\n <tbody><tr>\n <td class=\"w275\" width=\"275\">\n <p align=\"left\" class=\"article-title\"><singleline label=\"Title\">Add a title</singleline></p>\n <div align=\"left\" class=\"article-content\">\n <multiline label=\"Description\">Enter your description</multiline>\n </div>\n </td>\n </tr>\n <tr><td class=\"w275\" width=\"275\" height=\"10\"></td></tr>\n </tbody></table>\n </td>\n <td class=\"w30\" width=\"30\"></td>\n <td class=\"w275\" width=\"275\" valign=\"top\">\n <table class=\"w275\" width=\"275\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\">\n <tbody><tr>\n <td class=\"w275\" width=\"275\">\n <p align=\"left\" class=\"article-title\"><singleline label=\"Title\">Add a title</singleline></p>\n <div align=\"left\" class=\"article-content\">\n <multiline label=\"Description\">Enter your description</multiline>\n </div>\n </td>\n </tr>\n <tr><td class=\"w275\" width=\"275\" height=\"10\"></td></tr>\n </tbody></table>\n </td>\n </tr>\n </tbody></table>\n </layout>\n \n \n \n <layout label=\"Image gallery\">\n <table class=\"w580\" width=\"580\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\">\n <tbody><tr>\n <td class=\"w180\" width=\"180\" valign=\"top\">\n <table class=\"w180\" width=\"180\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\">\n <tbody><tr>\n <td class=\"w180\" width=\"180\"><img editable=\"true\" label=\"Image\" class=\"w180\" width=\"180\" border=\"0\"></td>\n </tr>\n <tr><td class=\"w180\" width=\"180\" height=\"10\"></td></tr>\n <tr>\n <td class=\"w180\" width=\"180\">\n <div align=\"left\" class=\"article-content\">\n <multiline label=\"Description\">Enter your description</multiline>\n </div>\n </td>\n </tr>\n <tr><td class=\"w180\" width=\"180\" height=\"10\"></td></tr>\n </tbody></table>\n </td>\n <td width=\"20\"></td>\n <td class=\"w180\" width=\"180\" valign=\"top\">\n <table class=\"w180\" width=\"180\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\">\n <tbody><tr>\n <td class=\"w180\" width=\"180\"><img editable=\"true\" label=\"Image\" class=\"w180\" width=\"180\" border=\"0\"></td>\n </tr>\n <tr><td class=\"w180\" width=\"180\" height=\"10\"></td></tr>\n <tr>\n <td class=\"w180\" width=\"180\">\n <div align=\"left\" class=\"article-content\">\n <multiline label=\"Description\">Enter your description</multiline>\n </div>\n </td>\n </tr>\n <tr><td class=\"w180\" width=\"180\" height=\"10\"></td></tr>\n </tbody></table>\n </td>\n <td width=\"20\"></td>\n <td class=\"w180\" width=\"180\" valign=\"top\">\n <table class=\"w180\" width=\"180\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\">\n <tbody><tr>\n <td class=\"w180\" width=\"180\"><img editable=\"true\" label=\"Image\" class=\"w180\" width=\"180\" border=\"0\"></td>\n </tr>\n <tr><td class=\"w180\" width=\"180\" height=\"10\"></td></tr>\n <tr>\n <td class=\"w180\" width=\"180\">\n <div align=\"left\" class=\"article-content\">\n <multiline label=\"Description\">Enter your description</multiline>\n </div>\n </td>\n </tr>\n <tr><td class=\"w180\" width=\"180\" height=\"10\"></td></tr>\n </tbody></table>\n </td>\n </tr>\n </tbody></table>\n </layout>\n </repeater>\n </td>\n <td class=\"w30\" width=\"30\"></td>\n </tr>\n </tbody></table>\n</td></tr>\n <tr><td class=\"w640\" width=\"640\" height=\"15\" bgcolor=\"#ffffff\"></td></tr>\n \n <tr>\n <td class=\"w640\" width=\"640\">\n <table id=\"footer\" class=\"w640\" width=\"640\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\" bgcolor=\"#3498db\">\n <tbody><tr><td class=\"w30\" width=\"30\"></td><td class=\"w580 h0\" width=\"360\" height=\"30\"></td><td class=\"w0\" width=\"60\"></td><td class=\"w0\" width=\"160\"></td><td class=\"w30\" width=\"30\"></td></tr>\n <tr>\n <td class=\"w30\" width=\"30\"></td>\n <td class=\"w580\" width=\"360\" valign=\"top\">\n <span class=\"hide\"><p id=\"permission-reminder\" align=\"left\" class=\"footer-content-left\"><span>You're receiving this because you booked an appointment using Stroll Health in your doctor's office.</span></p></span>\n <p align=\"left\" class=\"footer-content-left\"><preferences lang=\"en\">Edit your subscription</preferences> | <unsubscribe>Unsubscribe</unsubscribe></p>\n </td>\n <td class=\"hide w0\" width=\"60\"></td>\n <td class=\"hide w0\" width=\"160\" valign=\"top\">\n <p id=\"street-address\" align=\"right\" class=\"footer-content-right\"></p>\n </td>\n <td class=\"w30\" width=\"30\"></td>\n </tr>\n <tr><td class=\"w30\" width=\"30\"></td><td class=\"w580 h0\" width=\"360\" height=\"15\"></td><td class=\"w0\" width=\"60\"></td><td class=\"w0\" width=\"160\"></td><td class=\"w30\" width=\"30\"></td></tr>\n </tbody></table>\n</td>\n </tr>\n <tr><td class=\"w640\" width=\"640\" height=\"60\"></td></tr>\n </tbody></table>\n </td>\n </tr>\n</tbody></table></body></html>";
        
//    MSTable *table = [[LLTreatmentManager sharedInstance].client getTable:@"emailDummy"];
    NSMutableDictionary *item = [[NSMutableDictionary alloc] init];
    [item setObject:email forKey:@"text"];
    [item setObject:_emailAddress forKey:@"patientEmail"];
    [item setObject:@"robert@strollhealth.com" forKey:@"from"];
    MSClient *newClient = [MSClient clientWithApplicationURLString:@"https://strollmobile.azure-mobile.net/"
                                                withApplicationKey:@"VWHKZcntaIYDRsbZWEowEyvKiLfTWi91"];
    MSTable *table = [newClient getTable:@"emailDummy"];
    [table insert:[NSDictionary dictionaryWithDictionary:item] completion:^(NSDictionary *item, NSError *error) {
        if (error) {
            NSLog(@"%@",error);
        }
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Email Sent"
                                                        message:[NSString stringWithFormat:@"Please check your inbox for instructions on how to schedule an appointment at %@.", providerName]
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        [_sendEmailButton setTitle:@"Email Sent!" forState:UIControlStateNormal];
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
