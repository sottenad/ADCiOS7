//
//  adcApiSessonManager.m
//  ADC
//
//  Created by Steve Ottenad on 11/10/13.
//  Copyright (c) 2013 ADC. All rights reserved.
//

#import "adcApiSessonManager.h"
#import "adcUserHelper.h"

@implementation adcApiSessonManager

@synthesize sessionManager;

+ (id)sharedManager {
    static AFHTTPSessionManager *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURL *baseUrl = [[NSURL alloc] initWithString:@"http://adcapp.herokuapp.com/"];
        sharedMyManager = [[self alloc] initWithBaseURL:baseUrl];
    });
    return sharedMyManager;
}

- (id)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (self) {
        [self.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [self.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];        
    }
    
    return self;
}



-(NSURLSessionDataTask *)POST:(NSString *)URLString parameters:(NSDictionary *)parameters success:(void (^)(NSURLSessionDataTask *, id))success failure:(void (^)(NSURLSessionDataTask *, NSError *))failure{

    //Heres where we pass the auth token in to each call before we add the other params to it.
    NSString *user_token = [adcUserHelper getUserToken];
    NSMutableDictionary *newParams = [[NSMutableDictionary alloc] initWithDictionary:parameters];
    if(user_token!=nil){
        [newParams setValue:user_token forKey:@"auth_token"];
    }
    return [super POST:URLString parameters:newParams success:success failure:failure];
    
}


@end
