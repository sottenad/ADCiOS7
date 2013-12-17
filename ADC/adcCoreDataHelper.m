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

-(void)clearCart{

    NSManagedObjectContext *context = [self managedObjectContext];
    
    NSFetchRequest * allProducts = [[NSFetchRequest alloc] init];
    [allProducts setEntity:[NSEntityDescription entityForName:@"ProductInCart" inManagedObjectContext:context]];
    [allProducts setIncludesPropertyValues:NO]; //only fetch the managedObjectID
    
    NSError * error = nil;
    NSArray * products = [context executeFetchRequest:allProducts error:&error];
    //error handling goes here
    for (NSManagedObject * product in products) {
        [context deleteObject:product];
    }
    NSError *saveError = nil;
    [context save:&saveError];
}

@end
