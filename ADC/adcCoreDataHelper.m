//
//  adcCoreDataHelper.m
//  ADC
//
//  Created by Steve Ottenad on 12/16/13.
//  Copyright (c) 2013 ADC. All rights reserved.
//

#import "adcCoreDataHelper.h"

@interface adcCoreDataHelper ()

@end

@implementation adcCoreDataHelper



-(NSManagedObjectContext *)managedObjectContext{
    NSManagedObjectContext *context = nil;
    id mydelegate = [[UIApplication sharedApplication] delegate];
    if([mydelegate performSelector:@selector(managedObjectContext)]){
        context = [mydelegate managedObjectContext];
    }
    return context;
}

@end
