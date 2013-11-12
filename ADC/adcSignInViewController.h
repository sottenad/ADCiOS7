//
//  adcSignInViewController.h
//  ADC
//
//  Created by Steve Ottenad on 11/10/13.
//  Copyright (c) 2013 ADC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface adcSignInViewController : UIViewController

@property IBOutlet UITextField *inputUsername;
@property IBOutlet UITextField *inputPassword;
@property IBOutlet UIButton *btnSubmit;

-(IBAction)sendLogin:(id)sender;

@end
