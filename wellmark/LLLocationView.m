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

#define PROVIDER_HEIGHT 84
#define PRICE_HEIGHT 48
#define SCHEDULE_HEIGHT 48

#define MARGIN 5
#define VMARGIN 10
#define DISTANCE_HEIGHT 32
#define DOCTOR_HEIGHT 42
#define IMAGE_HEIGHT 240
#define PRICE_LABEL_FONT_SIZE 32.0f
@interface LLLocationView()

@property (nonatomic, strong) UILabel *providerAltNameLabel;
@property (nonatomic, strong) UILabel *providerDistanceLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UILabel *scheduleAppointmentLabel;
@property (nonatomic, strong) UILabel *providerDoctorNameLabel;
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
        _providerAltNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(VMARGIN, MARGIN, self.frame.size.width - VMARGIN * 2, PROVIDER_HEIGHT)];
        [_providerAltNameLabel setTextAlignment:NSTextAlignmentCenter];
        [_providerAltNameLabel setFont:[UIFont systemFontOfSize:24]];
        [_providerAltNameLabel setNumberOfLines:2];
        [_providerAltNameLabel setBackgroundColor:[UIColor clearColor]];
        [[_providerAltNameLabel layer] setCornerRadius:5];
        
        _providerDoctorNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(VMARGIN, MARGIN + PROVIDER_HEIGHT, self.frame.size.width - VMARGIN * 2, DOCTOR_HEIGHT)];
        [_providerDoctorNameLabel setTextAlignment:NSTextAlignmentCenter];
        [_providerDoctorNameLabel setBackgroundColor:[UIColor clearColor]];
        [[_providerDoctorNameLabel layer] setCornerRadius:5];

        _providerDistanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(VMARGIN, PROVIDER_HEIGHT + DOCTOR_HEIGHT + MARGIN * 2, self.frame.size.width - VMARGIN * 2, DISTANCE_HEIGHT)];
        [_providerDistanceLabel setTextAlignment:NSTextAlignmentCenter];
        [_providerDistanceLabel setBackgroundColor:[UIColor clearColor]];
        [[_providerDistanceLabel layer] setCornerRadius:5];

        _priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(VMARGIN, PROVIDER_HEIGHT + DISTANCE_HEIGHT + DOCTOR_HEIGHT + IMAGE_HEIGHT + MARGIN * 4, self.frame.size.width - VMARGIN * 2, PRICE_HEIGHT)];
        [_priceLabel setTextAlignment:NSTextAlignmentCenter];
        [_priceLabel setBackgroundColor:[UIColor clearColor]];
        [[_priceLabel layer] setCornerRadius:5];

        
        _scheduleAppointmentLabel = [[UILabel alloc] initWithFrame:CGRectMake(VMARGIN, PROVIDER_HEIGHT + DOCTOR_HEIGHT + DISTANCE_HEIGHT + IMAGE_HEIGHT + MARGIN * 6 + PRICE_HEIGHT, self.frame.size.width - VMARGIN * 2, SCHEDULE_HEIGHT)];
        [_scheduleAppointmentLabel setText:@"Schedule Appointment"];
        [_scheduleAppointmentLabel setBackgroundColor:[UIColor colorWithRed:28.0f/255 green:188.0f/255 blue:156.0f/255 alpha:0.5]];
        [_scheduleAppointmentLabel setTextAlignment:NSTextAlignmentCenter];
        [_scheduleAppointmentLabel setTextColor:[UIColor whiteColor]];
        [[_scheduleAppointmentLabel layer] setCornerRadius:5.0];
        
        [self addSubview:_providerAltNameLabel];
        [self addSubview:_providerDistanceLabel];
        [self addSubview:_priceLabel];
        [self addSubview:_scheduleAppointmentLabel];
        [self addSubview:_providerDoctorNameLabel];
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

-(void)setDoctorName:(NSString *)name isMultiple:(BOOL)multiple
{
    [_providerDoctorNameLabel setText:name];
    
    if (multiple) {
        _doctorImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"doctors.png"]];
    } else {
        _doctorImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"doctor.png"]];
    }
    [_doctorImageView setCenter:CGPointMake(LOCATION_CARD_WIDTH / 2, IMAGE_HEIGHT / 2 + PROVIDER_HEIGHT + DISTANCE_HEIGHT + DOCTOR_HEIGHT + MARGIN * 3)];
    [self addSubview:_doctorImageView];
}

-(void)setPrice:(float)price
{
    if (price < 0.1) {
        [_priceLabel setText:@"Free"];
        [_priceLabel setFont:[UIFont boldSystemFontOfSize:PRICE_LABEL_FONT_SIZE]];
        [_priceLabel setTextColor:[UIColor whiteColor]];
        [_priceLabel setBackgroundColor:TORQUOISE];
    } else {
        [_priceLabel setText:[NSString stringWithFormat:@"$%2.2f",price]];
        [_priceLabel setFont:[UIFont systemFontOfSize:PRICE_LABEL_FONT_SIZE]];
        [_priceLabel setTextColor:[UIColor colorWithRed:236/255 green:240/255 blue:241/255 alpha:0.5]];
        [_priceLabel setBackgroundColor:[UIColor colorWithRed:28.0f/255 green:188.0f/255 blue:156.0f/255 alpha:0.5]];
    }
    
}

@end
