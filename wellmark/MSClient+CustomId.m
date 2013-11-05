#import "MSClient+CustomId.h"

@implementation MSClient (CustomId)

- (void)registerUsername:(NSString *)username withPassword:(NSString *)password withCompletion:(MSItemBlock)completion
{
    MSTable *accounts = [self getTable:@"Users"];
    NSDictionary *account = @{
    @"username" : username,
    @"password" : password
    // you should include and collect any additional data here
    };
    [accounts insert:account completion:completion];
}

- (void)loginUsername:(NSString *)username withPassword:(NSString *)password completion:(MSClientLoginBlock)completion
{
    MSClient *loginClient = [self clientwithFilter:self];
    MSTable *accounts = [loginClient getTable:@"Users"];
    NSDictionary *credentials = @{
    @"username" : username,
    @"password" : password
    // you should include and collect any additional data here
    };
    [accounts insert:credentials completion:^(NSDictionary *item, NSError *error) {
        if (error) {
            completion(nil, error);
        }
        else {
            MSUser *user = [[MSUser alloc] initWithUserId:[item valueForKey:@"userId"]];
            user.mobileServiceAuthenticationToken = [item valueForKey:@"token"];
            self.currentUser = user;
            completion(user, error);
        }
    }];
}


// This filter simply augments the outgoing URL to add a parameter login=true
// This will be much easier in the next release of the iOS SDK which support
// specifying parameters on insert
- (void) handleRequest:(NSURLRequest *)request
                onNext:(MSFilterNextBlock)onNext
            onResponse:(MSFilterResponseBlock)onResponse
{
    // just add a parameter on the outbound request
    NSMutableURLRequest *req = [request mutableCopy];
    NSURL *newUrl;
    if ([req.URL.absoluteString rangeOfString:@"?"].location != NSNotFound) {
        newUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", req.URL.absoluteString, @"&login=true"]];
    }
    else {
        newUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", req.URL.absoluteString, @"?login=true"]];
    }
    req.URL = newUrl;
    onNext(req, onResponse);
}

@end