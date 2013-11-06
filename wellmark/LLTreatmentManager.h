//
//  LLTreatmentManager.h
//  wellmark
//
//  Created by Robert Guo on 8/30/13.
//  Copyright (c) 2013 Stroll. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WindowsAzureMobileServices/WindowsAzureMobileServices.h>

#define WELLMARK @"Wellmark"

typedef void (^CompletionBlock) ();
typedef void (^CompletionWithIndexBlock) (NSUInteger index);
typedef void (^BusyUpdateBlock) (BOOL busy);

@interface LLTreatmentManager : NSObject<MSFilter>

@property (nonatomic, strong) NSString *selectedTreatment;
@property (nonatomic, strong) NSString *patientName;
@property (nonatomic, strong) NSDictionary *providerInformation;
@property (nonatomic, strong) NSString *insuranceCompany;
@property (nonatomic, strong) NSString *memberID;

@property (nonatomic, strong)   NSArray *items;
@property (nonatomic, strong)   MSClient *client;
@property (nonatomic, copy) BusyUpdateBlock busyUpdate;



+ (LLTreatmentManager*)sharedInstance;
- (NSString *)getEmail;
- (NSString *)getProviderName;
- (NSString *)getProviderPhone;

- (void) refreshDataOnSuccess:(CompletionBlock) completion;

- (void) addItem:(NSDictionary *) item
      completion:(CompletionWithIndexBlock) completion;

- (void) completeItem: (NSDictionary *) item
           completion:(CompletionWithIndexBlock) completion;


- (void) handleRequest:(NSURLRequest *)request
                onNext:(MSFilterNextBlock)onNext
            onResponse:(MSFilterResponseBlock)onResponse;

@end
