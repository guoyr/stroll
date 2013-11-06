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

@interface LLLocationsViewController : LLViewController <CLLocationManagerDelegate>

@property (nonatomic, strong) NSString *treatment;




@end
