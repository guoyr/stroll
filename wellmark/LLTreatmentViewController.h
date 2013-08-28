//
//  LLTreatmentViewController.h
//  wellmark
//
//  Created by Robert Guo on 8/27/13.
//  Copyright (c) 2013 Stroll. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LLTreatmentViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>


@property (weak, nonatomic) IBOutlet UITableView *treatmentTableView;
@property (nonatomic, assign) NSString *patientName;

@end
