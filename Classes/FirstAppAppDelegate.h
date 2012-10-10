//
//  FirstAppAppDelegate.h
//  FirstApp
//
//  Created by nishith agarwal on 4/8/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBConnect.h"
#import "AppDelegateProtocol.h"
#import "Kumulos.h"

//@class ExampleAppDataObject;

@interface FirstAppAppDelegate : UIResponder <UIApplicationDelegate,FBSessionDelegate, UITabBarDelegate, kumulosProxyDelegate, KumulosDelegate, FBRequestDelegate>{
    UIWindow *window;  
    Facebook *facebook1;
    //ExampleAppDataObject* theAppDataObject;
    UINavigationController *navigationController;
}

@property (nonatomic, retain) UINavigationController *navigationController;
@property (strong, nonatomic) UIWindow *window;
@property (strong, retain) Facebook *fb;
@property (strong, retain) Facebook *facebook1;
//@property (nonatomic, retain) ExampleAppDataObject* theAppDataObject;

@end

