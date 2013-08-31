//
//  LLLocationView.m
//  wellmark
//
//  Created by Robert Guo on 8/27/13.
//  Copyright (c) 2013 Stroll. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "LLLocationView.h"

#define PROVIDER_HEIGHT 96
#define MARGIN 10

@interface LLLocationView()

@property (nonatomic, strong) UILabel *providerAltNameLabel;
@property (nonatomic, strong) UILabel *providerDistanceLabel;
@property (nonatomic, strong) UILabel *priceLabel;

@end

@implementation LLLocationView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor colorWithWhite:1 alpha:0.4]];
        [[self layer] setCornerRadius:5];
        // Initialization code
        _providerAltNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(MARGIN, MARGIN, self.frame.size.width - 20, PROVIDER_HEIGHT)];
        [_providerAltNameLabel setTextAlignment:NSTextAlignmentCenter];
        [_providerAltNameLabel setFont:[UIFont systemFontOfSize:24]];
        [_providerAltNameLabel setNumberOfLines:2];
        
        _providerDistanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, PROVIDER_HEIGHT + MARGIN * 2, self.frame.size.width - 20, 32)];
        [_providerDistanceLabel setTextAlignment:NSTextAlignmentCenter];
        
        _priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 240, self.frame.size.width - 20, 48)];
        [_priceLabel setTextColor:[UIColor colorWithRed:28 green:188 blue:156 alpha:100]];
        [_priceLabel setTextAlignment:NSTextAlignmentCenter];
        
        [_priceLabel setText:@"$30"];
        
        [self addSubview:_providerAltNameLabel];
        [self addSubview:_providerDistanceLabel];
        [self addSubview:_priceLabel];
        

    }
    return self;
}

- (void)setProviderAltName:(NSString *)name
{
    [_providerAltNameLabel setText:name];
}

- (void)setProviderDistance:(NSString *)dist
{
    
    [_providerDistanceLabel setText:dist];

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
