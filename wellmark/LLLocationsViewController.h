//
//  LLLocationsViewController.h
//  wellmark
//
//  Created by Robert Guo on 8/27/13.
//  Copyright (c) 2013 Stroll. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "LLLocationView.h"
#import "LLViewController.h"
#import "LLDeductableInfoViewController.h"
#import <WindowsAzureMobileServices/WindowsAzureMobileServices.h>

@interface LLLocationsViewController : LLViewController <CLLocationManagerDelegate>

@property (nonatomic, strong) NSString *treatment;
@property (nonatomic, strong) NSString *memberID;
@property (nonatomic, strong)   NSArray *items;
@property (nonatomic, strong)   MSClient *client;


@end
