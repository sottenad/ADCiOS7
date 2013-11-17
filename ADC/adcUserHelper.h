//
//  adcUserHelper.h
//  ADC
//
//  Created by Steve Ottenad on 11/10/13.
//  Copyright (c) 2013 ADC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface adcUserHelper : NSObject

+(NSString*)getUserToken;

+(NSString *)getSelectedVehicleId;

+(BOOL)isUserLoggedIn;

@end
