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


+ (id)sharedInstance
{
    static dispatch_once_t pred = 0;
    __strong static id _sharedObject = nil;
    dispatch_once(&pred, ^{
        _sharedObject = [[self alloc] init];
    });
    return _sharedObject;
}

@end
