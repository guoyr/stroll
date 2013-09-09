//
//  LLTreatmentManager.h
//  wellmark
//
//  Created by Robert Guo on 8/30/13.
//  Copyright (c) 2013 Stroll. All rights reserved.
//

#import <Foundation/Foundation.h>

#define WELLMARK @"Wellmark"

@interface LLTreatmentManager : NSObject

@property (nonatomic, strong) NSString *selectedTreatment;
@property (nonatomic, strong) NSString *patientName;
@property (nonatomic, strong) NSDictionary *providerInformation;
@property (nonatomic, strong) NSString *insuranceCompany;

+ (LLTreatmentManager*)sharedInstance;
- (NSString *)getEmail;
- (NSString *)getProviderName;
- (NSString *)getProviderPhone;

@end
