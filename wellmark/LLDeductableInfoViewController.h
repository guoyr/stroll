//
//  LLDeductableInfoViewController.h
//  wellmark
//
//  Created by Robert Guo on 9/8/13.
//  Copyright (c) 2013 Stroll. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LLViewController.h"
#import <WindowsAzureMobileServices/WindowsAzureMobileServices.h>

@interface LLDeductableInfoViewController : LLViewController

@property (nonatomic, strong) NSString *memberID;

@property (nonatomic, strong)   NSArray *items;
@property (nonatomic, strong)   MSClient *client;

@end
