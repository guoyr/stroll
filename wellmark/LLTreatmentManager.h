//
//  LLTreatmentManager.h
//  wellmark
//
//  Created by Robert Guo on 8/30/13.
//  Copyright (c) 2013 Stroll. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LLTreatmentManager : NSObject

@property (nonatomic, strong) NSString *selectedTreatment;
@property (nonatomic, strong) NSString *patientName;

+ (LLTreatmentManager*)sharedInstance;
- (void)addBackground:(UIView *)view;

@end
