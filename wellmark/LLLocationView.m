//
//  LLLocationView.m
//  wellmark
//
//  Created by Robert Guo on 8/27/13.
//  Copyright (c) 2013 Stroll. All rights reserved.
//

#import "LLLocationView.h"

@interface LLLocationView()

@property (nonatomic, strong) UILabel *providerAltNameLabel;
@property (nonatomic, strong) UILabel *providerDistanceLabel;

@end

@implementation LLLocationView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor whiteColor]];
        // Initialization code
        _providerAltNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, self.frame.size.width - 20, 30)];
        _providerDistanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 60, self.frame.size.width - 20, 30)];

        [self addSubview:_providerAltNameLabel];
        [self addSubview:_providerDistanceLabel];

    }
    return self;
}

- (void)setProviderAltName:(NSString *)name
{
    [_providerAltNameLabel setText:name];
}

- (void)setProviderDistance:(NSString *)dist
{
    
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
