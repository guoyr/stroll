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
@property (nonatomic, strong)   MSTable *table;
@property (nonatomic)           NSInteger busyCount;

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
        
        // Initialize the Mobile Service client with your URL and key
        MSClient *newClient = [MSClient clientWithApplicationURLString:@"https://strollmobile.azure-mobile.net/"
                                                    withApplicationKey:@"VWHKZcntaIYDRsbZWEowEyvKiLfTWi91"];
        
        // Add a Mobile Service filter to enable the busy indicator
        self.client = [newClient clientwithFilter:self];
        
        // Create an MSTable instance to allow us to work with the TodoItem table
        self.table = [_client getTable:@"Users"];
        
        self.items = [[NSMutableArray alloc] init];
        self.busyCount = 0;
        
        MSTable *DeductableStatusTable = [_client getTable:@"patientsdata"];
        
        _memberID = @"1721497";
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"memberID == %@",_memberID];
        [DeductableStatusTable readWhere:predicate completion:^(NSArray *items, NSInteger totalCount, NSError *error) {
            NSDictionary *dict = [items lastObject];
            int deductbalevalue = [[dict objectForKey:@"Deductable"] intValue];
            int coveragevalue = [[dict objectForKey:@"Coverage"] intValue];
            NSLog(@"%d,%d,%d",deductbalevalue, coveragevalue, 5*deductbalevalue);

        }];
    }
    return self;
}

-(NSString *) getEmail
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

- (void) refreshDataOnSuccess:(CompletionBlock)completion
{
    // Create a predicate that finds items where complete is false
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"complete == NO"];
    
    // Query the TodoItem table and update the items property with the results from the service
    [self.table readWhere:predicate completion:^(NSArray *results, NSInteger totalCount, NSError *error) {
        
        [self logErrorIfNotNil:error];
        
        _items = [results mutableCopy];
        
        // Let the caller know that we finished
        completion();
    }];
    
}

-(void) addItem:(NSDictionary *)item completion:(CompletionWithIndexBlock)completion
{
    // Insert the item into the TodoItem table and add to the items array on completion
    [self.table insert:item completion:^(NSDictionary *result, NSError *error) {
        
        [self logErrorIfNotNil:error];
        
        NSUInteger index = [_items count];
        [(NSMutableArray *)_items insertObject:result atIndex:index];
        
        // Let the caller know that we finished
        completion(index);

    }];
}

-(void) completeItem:(NSDictionary *)item completion:(CompletionWithIndexBlock)completion
{
    // Cast the public items property to the mutable type (it was created as mutable)
    NSMutableArray *mutableItems = (NSMutableArray *) _items;
    
    // Set the item to be complete (we need a mutable copy)
    NSMutableDictionary *mutable = [item mutableCopy];
    [mutable setObject:@(YES) forKey:@"complete"];
    
    // Replace the original in the items array
    NSUInteger index = [_items indexOfObjectIdenticalTo:item];
    [mutableItems replaceObjectAtIndex:index withObject:mutable];
    
    // Update the item in the TodoItem table and remove from the items array on completion
    [self.table update:mutable completion:^(NSDictionary *item, NSError *error) {
        
        [self logErrorIfNotNil:error];
        
        NSUInteger index = [_items indexOfObjectIdenticalTo:mutable];
        [mutableItems removeObjectAtIndex:index];
        
        // Let the caller know that we have finished
        completion(index);
    }];
}

- (void) busy:(BOOL) busy
{
    // assumes always executes on UI thread
    if (busy) {
        if (self.busyCount == 0 && self.busyUpdate != nil) {
            self.busyUpdate(YES);
        }
        self.busyCount ++;
    }
    else
    {
        if (self.busyCount == 1 && self.busyUpdate != nil) {
            self.busyUpdate(FALSE);
        }
        self.busyCount--;
    }
}

- (void) logErrorIfNotNil:(NSError *) error
{
    if (error) {
        NSLog(@"ERROR %@", error);
    }
}


#pragma mark * MSFilter methods


- (void) handleRequest:(NSURLRequest *)request
                onNext:(MSFilterNextBlock)onNext
            onResponse:(MSFilterResponseBlock)onResponse
{
    // A wrapped response block that decrements the busy counter
    MSFilterResponseBlock wrappedResponse = ^(NSHTTPURLResponse *response, NSData *data, NSError *error) {
        [self busy:NO];
        if (response.statusCode == 401) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"UnauthorizedResponse" object:nil];
        }
        onResponse(response, data, error);
    };
    
    // Increment the busy counter before sending the request
    [self busy:YES];
    onNext(request, wrappedResponse);
}



@end
