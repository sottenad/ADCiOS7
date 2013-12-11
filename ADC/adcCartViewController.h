//
//  adcCartViewController.h
//  ADC
//
//  Created by Steve Ottenad on 12/10/13.
//  Copyright (c) 2013 ADC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface adcCartViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray *arrayOfItems;
}

@property IBOutlet UILabel *price;

@property IBOutlet UITableView *cartTable;

@end
