//
//  adcProductDetailController.h
//  ADC
//
//  Created by Steve Ottenad on 11/13/13.
//  Copyright (c) 2013 ADC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface adcProductDetailController : UIViewController{
    
}

@property NSDictionary *categoryObj;
@property NSDictionary *mfgObj;
@property NSDictionary *productObj;

@property IBOutlet UILabel *lblTitle;
@property IBOutlet UILabel *lblPrice;
@property IBOutlet UIButton *btnAddToCart;
@property IBOutlet UITextView *txtProductText;
@property IBOutlet UIImageView *imgMainImage;

-(IBAction)addToCart:(id)sender;

@end
