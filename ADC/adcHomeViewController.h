//
//  adcHomeViewController.h
//  ADC
//
//  Created by Steve Ottenad on 11/10/13.
//  Copyright (c) 2013 ADC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface adcHomeViewController : UIViewController{
    NSString *defaultMessage;
}


@property IBOutlet UILabel *lblUserGreeting;
@property IBOutlet UIButton *btnSignIn;
@property IBOutlet UIButton *btnLogOut;

-(IBAction)signOut:(id)sender;

@end
