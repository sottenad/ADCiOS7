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

+(NSString *)getSelectedVehicleId{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSObject *objModelId = [defaults objectForKey:@"model_id"];
    if(objModelId != nil){
        return [defaults objectForKey:@"model_id"];
    }else{
        return nil;
    }
}

+(BOOL) isUserLoggedIn{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSObject *objUsername = [defaults objectForKey:@"auth_token"];
    if(objUsername != nil){
        return YES;
    }else{
        return NO;
    }
}

+(NSString *) getUserId{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *objUsername = [defaults objectForKey:@"user_id"];
    if(objUsername != nil){
        return objUsername;
    }else{
        return @"0" ;
    }
}

@end
