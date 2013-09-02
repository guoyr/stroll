//
//  LLLocationView.m
//  wellmark
//
//  Created by Robert Guo on 8/27/13.
//  Copyright (c) 2013 Stroll. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "LLLocationView.h"
#import "LLColors.h"

#define PROVIDER_HEIGHT 96
#define MARGIN 10
#define DISTANCE_HEIGHT 32
#define IMAGE_HEIGHT 200

@interface LLLocationView()

@property (nonatomic, strong) UILabel *providerAltNameLabel;
@property (nonatomic, strong) UILabel *providerDistanceLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UIImageView *doctorImageView;

@end

@implementation LLLocationView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor colorWithWhite:1 alpha:0.4]];
        [[self layer] setCornerRadius:5];
        // Initialization code
        _providerAltNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(MARGIN, MARGIN, self.frame.size.width - MARGIN * 2, PROVIDER_HEIGHT)];
        [_providerAltNameLabel setTextAlignment:NSTextAlignmentCenter];
        [_providerAltNameLabel setFont:[UIFont systemFontOfSize:24]];
        [_providerAltNameLabel setNumberOfLines:2];
        [_providerAltNameLabel setBackgroundColor:[UIColor clearColor]];
        
        _providerDistanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, PROVIDER_HEIGHT + MARGIN, self.frame.size.width - MARGIN * 2, DISTANCE_HEIGHT)];
        [_providerDistanceLabel setTextAlignment:NSTextAlignmentCenter];
        [_providerDistanceLabel setBackgroundColor:[UIColor clearColor]];

        _priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, PROVIDER_HEIGHT + DISTANCE_HEIGHT + IMAGE_HEIGHT + MARGIN * 4, self.frame.size.width - MARGIN * 2, 48)];
        [_priceLabel setFont:[UIFont systemFontOfSize:32.0]];
        [_priceLabel setTextAlignment:NSTextAlignmentCenter];
        [_priceLabel setBackgroundColor:[UIColor clearColor]];

        _doctorImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"doctor.jpg"]];
        [_doctorImageView setCenter:CGPointMake(LOCATION_CARD_WIDTH / 2, IMAGE_HEIGHT / 2 + PROVIDER_HEIGHT + DISTANCE_HEIGHT + MARGIN * 2)];
        
        [self addSubview:_providerAltNameLabel];
        [self addSubview:_providerDistanceLabel];
        [self addSubview:_priceLabel];
        [self addSubview:_doctorImageView];
    }
    return self;
}

- (void)setProviderAltName:(NSString *)name
{
    [_providerAltNameLabel setText:name];
}

- (void)setProviderDistance:(NSString *)dist
{
    
    [_providerDistanceLabel setText:[NSString stringWithFormat:@"%@ miles", dist]];

}

-(void)setPrice:(float)price
{
    if (price < 0.1) {
        [_priceLabel setText:@"Free"];
        [_priceLabel setTextColor:TORQUOISE];
    } else {
        [_priceLabel setText:[NSString stringWithFormat:@"$%2.1f",price]];
        [_priceLabel setTextColor:RED];
    }
    
}

@end
