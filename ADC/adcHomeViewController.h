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

@property IBOutlet UILabel *lblSelectedVehicle;
@property IBOutlet UIButton *btnSelectVehicle;
@property IBOutlet UIButton *btnClearSelectedVehicle;

@property IBOutlet UIButton *btnViewCatalog;

@property IBOutlet UILabel *lblUserGreeting;
@property IBOutlet UIButton *btnSignIn;
@property IBOutlet UIButton *btnLogOut;

-(IBAction)signOut:(id)sender;
-(IBAction)clearSelectedVehicle:(id)sender;

@end
