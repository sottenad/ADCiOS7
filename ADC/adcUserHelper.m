//
//  adcUserHelper.m
//  ADC
//
//  Created by Steve Ottenad on 11/10/13.
//  Copyright (c) 2013 ADC. All rights reserved.
//

#import "adcUserHelper.h"

@implementation adcUserHelper

+(NSString *)getUserToken{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSObject *objUsername = [defaults objectForKey:@"auth_token"];
    if(objUsername != nil){
        return [defaults objectForKey:@"auth_token"];
    }else{
        return nil;
    }
}
@end
