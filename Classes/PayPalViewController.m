//
//  PayPalViewController.m
//  FirstApp
//
//  Created by nishith agarwal on 4/11/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "PayPalViewController.h"
#import "PayPal.h"
#import "PayPalAdvancedPayment.h"

@implementation PayPalViewController


- (void) viewDidLoad{
 
	//PayPal *paypal = [PayPal initializeWithAppID:@"APP-80W284485P519543T" forEnvironment:ENV_SANDBOX];
 
	self.view = [[[UIView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame] autorelease];
	
	UIButton *button = [[PayPal getPayPalInst]getPayButtonWithTarget:self 
														 andAction:@selector(payWithPayPal)
													  andButtonType:BUTTON_294x43];
	[self.view addSubview:button];

	[super viewDidLoad];
 
 }
 
 - (void) payWithPayPal{
	 
	 PayPal *ppm = [PayPal getPayPalInst];
	 PayPalAdvancedPayment *payment = [[[PayPalAdvancedPayment alloc] init] autorelease];
	 
	 payment.paymentCurrency=@"USD";

	 [ppm advancedCheckoutWithPayment:payment];

 }


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
