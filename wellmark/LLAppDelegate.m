//
//  LLAppDelegate.m
//  wellmark
//
//  Created by Robert Guo on 8/27/13.
//  Copyright (c) 2013 Stroll. All rights reserved.
//

#import "LLAppDelegate.h"
#import <Parse/Parse.h>
#import <WindowsAzureMobileServices/WindowsAzureMobileServices.h>

@implementation LLAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    [Parse setApplicationId:@"A2dxJpqSX4cCaSkWWbLw4FXk1Wi328L6TnsbGBU3"
                  clientKey:@"7yIszpNNJ9SKrhJbpCxEtIBOsHtKbUTLLvrgDhiF"];
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"Doctors"]) {
        [[NSUserDefaults standardUserDefaults] setObject:[NSArray arrayWithObjects:@"Dr. Tim Peterson", @"Dr. Sameer Sonalkar", @"Dr. Jordan Epstein", @"Dr. Matthew Mauer", @"Dr. Andrew Moxon", nil] forKey:@"Doctors"];
     MSClient *client = [MSClient clientWithApplicationURLString:@"https://strollmobile.azure-mobile.net/"
                     withApplicationKey:@"VWHKZcntaIYDRsbZWEowEyvKiLfTWi91"];
    }
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
