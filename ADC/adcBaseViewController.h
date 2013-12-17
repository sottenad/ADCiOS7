//
//  adcBaseViewController.h
//  ADC
//
//  Created by Steve Ottenad on 12/17/13.
//  Copyright (c) 2013 ADC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSBadgeView.h"

@interface adcBaseViewController : UIViewController{
    
    UIButton *button;
    JSBadgeView *badgeView;
    NSManagedObjectContext *context;
    NSFetchRequest *fetchRequest;
}

-(void)calculateNumberInCart;
@end
