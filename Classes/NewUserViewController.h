//
//  NewUserViewController.h
//  FirstApp
//
//  Created by nishith agarwal on 4/9/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Kumulos.h"

@interface NewUserViewController : UIViewController <UITextFieldDelegate,KumulosDelegate> {
    UITextField *firstname;
    UITextField *lastname;
    UITextField *emailaddress;
	UITextField *password;
    IBOutlet UINavigationBar *home;
}
@property(retain, nonatomic) IBOutlet UITextField *firstname;
@property(retain, nonatomic) IBOutlet UITextField *lastname;
@property(retain, nonatomic) IBOutlet UITextField *emailaddress;
@property(retain, nonatomic) IBOutlet UITextField *password;
@property (retain, nonatomic) IBOutlet UINavigationBar *home;

-(IBAction) goawaykeyboard: (id) sender;
-(IBAction) taponbackground: (id) sender;
-(IBAction) doRegister:(id)sender;
-(IBAction) cancelButton:(id)sender;
@end
