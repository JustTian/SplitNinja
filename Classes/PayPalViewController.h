//
//  PayPalViewController.h
//  FirstApp
//
//  Created by nishith agarwal on 4/11/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PayPal.h"

@interface PayPalViewController : UIViewController 
/*<PayPalPaymentDelegate>*/ {
}
- (void) payWithPayPal;

@end
