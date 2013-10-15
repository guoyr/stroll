//
//  LLSettingsViewController.h
//  wellmark
//
//  Created by Robert Guo on 9/10/13.
//  Copyright (c) 2013 Stroll. All rights reserved.
//

#import "LLViewController.h"

@interface LLSettingsViewController : LLViewController<UITableViewDelegate, UITableViewDataSource>


@property (nonatomic, weak) IBOutlet UILabel *einLabel;
@property (nonatomic, weak) IBOutlet UILabel *idLabel;
@property (nonatomic, weak) IBOutlet UITextField *einField;
@property (nonatomic, weak) IBOutlet UITextField *idField;
@property (nonatomic, weak) IBOutlet UIScrollView *doctorScrollView;
@property (nonatomic, weak) IBOutlet UILabel *doctorLabel;

@property (weak, nonatomic) IBOutlet UITextField *textfield;
- (IBAction)buttonok:(id)sender;
@property (nonatomic, strong) NSMutableArray *doctorSB;
@end
