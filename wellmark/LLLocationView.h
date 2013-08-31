//
//  LLLocationView.h
//  wellmark
//
//  Created by Robert Guo on 8/27/13.
//  Copyright (c) 2013 Stroll. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface LLLocationView : UIView

@property (nonatomic, assign) int index;

- (void)setProviderAltName:(NSString *)name;
- (void)setProviderDistance:(NSString *)dist;

@end
