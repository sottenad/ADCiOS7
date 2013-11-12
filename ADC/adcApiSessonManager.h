//
//  adcApiSessonManager.h
//  ADC
//
//  Created by Steve Ottenad on 11/10/13.
//  Copyright (c) 2013 ADC. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@interface adcApiSessonManager : AFHTTPSessionManager{
    AFHTTPSessionManager *sessionManager;
    NSDictionary *requestOptions;
}

@property AFHTTPSessionManager *sessionManager;

+ (id)sharedManager;


@end
