//
//  LLTreatmentViewController.h
//  wellmark
//
//  Created by Robert Guo on 8/27/13.
//  Copyright (c) 2013 Stroll. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LLViewController.h"

@interface LLTreatmentViewController : LLViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *treatmentLabel;

@end
