//
//  LLLocationView.h
//  wellmark
//
//  Created by Robert Guo on 8/27/13.
//  Copyright (c) 2013 Stroll. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

#define LOCATION_CARD_WIDTH 300.0f
#define LOCATION_CARD_HEIGHT 500.0f

@interface LLLocationView : UIView

@property (nonatomic, assign) int index;

- (void)setProviderAltName:(NSString *)name;
- (void)setProviderDistance:(NSString *)dist;
-(void)setPrice:(float)price;
@end
