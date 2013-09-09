//
//  LLTreatmentManager.m
//  wellmark
//
//  Created by Robert Guo on 8/30/13.
//  Copyright (c) 2013 Stroll. All rights reserved.
//

#import "LLTreatmentManager.h"

@interface LLTreatmentManager()

@property (nonatomic, strong) NSDictionary *patientInfo;

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

-(void)setPatientName:(NSString *)patientName
{
    _patientName = patientName;
    NSString *path = [[NSBundle mainBundle] pathForResource:@"dummyUserInfo" ofType:@"plist"];
    NSDictionary *userInfoDict = [NSDictionary dictionaryWithContentsOfFile:path];
    if ([userInfoDict objectForKey:patientName]) {
        _patientInfo = [userInfoDict objectForKey:patientName];
    }
  
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

-(NSString *)getEmail
{
    return [_patientInfo objectForKey:@"email"];
}

- (NSString *)getProviderName
{
    return [_providerInformation objectForKey:@"AltName"];
}

- (NSString *)getProviderPhone
{
    return [_providerInformation objectForKey:@"Phone"];
}



@end
