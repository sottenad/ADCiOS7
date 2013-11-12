//
//  adcModelController.h
//  ADC
//
//  Created by Steve Ottenad on 11/11/13.
//  Copyright (c) 2013 ADC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface adcModelController : UITableViewController{
    NSMutableArray *myModels;
    NSDictionary *mySelectedModel;
}


@property NSDictionary *yearObj;
@property NSDictionary *makeObj;


@end
