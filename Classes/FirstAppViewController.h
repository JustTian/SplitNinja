//
//  FirstAppViewController.h
//  FirstApp
//
//  Created by nishith agarwal on 4/8/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Kumulos.h"
#import "FBConnect.h"

@interface FirstAppViewController : UIViewController <UITextFieldDelegate,KumulosDelegate,FBSessionDelegate,FBRequestDelegate> 
{
    UILabel *fbname;
	UITextField *emailaddress;
	UITextField *password;
    Facebook *facebook;
    NSString *userName;
    UINavigationBar *home;
	
}
@property (retain, nonatomic) IBOutlet UINavigationBar *home;

@property(retain, nonatomic) IBOutlet NSString *userName;
@property(retain, nonatomic) IBOutlet UILabel *fbname;
@property(retain, nonatomic) IBOutlet UITextField *emailaddress;
@property(retain, nonatomic) IBOutlet UITextField *password;
@property (nonatomic, retain) Facebook *facebook;

-(IBAction) goawaykeyboard: (id) sender;
-(IBAction) taponbackground: (id) sender;
-(IBAction) login:(id)sender;
-(IBAction) facebooklogin:(id)sender;
-(IBAction) newuser:(id)sender;
//-(IBAction) paypal:(id)sender;
- (void) sendFBRequest;

@end

