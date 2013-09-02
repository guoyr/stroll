//
//  LLTreatmentManager.m
//  wellmark
//
//  Created by Robert Guo on 8/30/13.
//  Copyright (c) 2013 Stroll. All rights reserved.
//

#import "LLTreatmentManager.h"

@interface LLTreatmentManager()

@end

@implementation LLTreatmentManager


+ (LLTreatmentManager*)sharedInstance
{
    static dispatch_once_t pred = 0;
    __strong static LLTreatmentManager* _sharedObject = nil;
    dispatch_once(&pred, ^{
        _sharedObject = [[self alloc] init];
    });
    return _sharedObject;
}

-(id)init
{
    self = [super init];

    if (self) {
        [self setPatientName:@"Test User"];
        [self setSelectedTreatment:@"Test Treatment"];
    }
    
    return self;
}

- (void)addBackground:(UIView *)view
{
    UIImageView *bg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background.png"]];
    [view addSubview:bg];
    [view sendSubviewToBack:bg];
}

@end
