//
//  FirstAppAppDelegate.m
//  FirstApp
//
//  Created by nishith agarwal on 4/8/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "FirstAppAppDelegate.h"
//#import "PayPal.h"
//#import "PieChartViewController.h"
#import "FirstAppViewController.h"
#import "AppDelegateProtocol.h"
#import "ExampleAppDataObject.h"
#import "SharedStrings.h"

@implementation FirstAppAppDelegate

@synthesize fb;
@synthesize window = _window;
@synthesize facebook1;
//@synthesize theAppDataObject;
@synthesize navigationController;

NSString *fb_name, *fb_email;


- (void)applicationDidFinishLaunching:(UIApplication *)application {
    NSLog(@"-------------------------------------------");
    /*navigationController = [[UINavigationController alloc] init];
    [window addSubview:navigationController.view];
    [window makeKeyAndVisible];*/
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSLog(@"didFinishLaunchingWithOptionsDelegate");
    //[PayPal initializeWithAppID:@"APP-80W284485P519543T" forEnvironment:ENV_SANDBOX]
    
    facebook1 = [[Facebook alloc] initWithAppId:@"369820913059288" andDelegate:self];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:@"FBAccessTokenKey"] 
        && [defaults objectForKey:@"FBExpirationDateKey"]) {
        facebook1.accessToken = [defaults objectForKey:@"FBAccessTokenKey"];
        facebook1.expirationDate = [defaults objectForKey:@"FBExpirationDateKey"];
    }
    
    /*
     self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
     UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Storyboard1" bundle:nil];
    UIViewController *controller = [storyboard instantiateViewControllerWithIdentifier:@"newtab"];
    self.window.rootViewController = controller;
    [self.window makeKeyAndVisible];*/
    navigationController = [[UINavigationController alloc] init];
    [window addSubview:navigationController.view];
    [window makeKeyAndVisible];
    return YES;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    NSLog(@"openURLDelegate");
    return [facebook1 handleOpenURL:url];
}
//Receive facebook session response
- (void)fbDidLogin {
    NSLog(@"fbDidLoginDelegate");
    //[self showLoadingView];
    
    //Save authorization information
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[facebook1 accessToken] forKey:@"FBAccessTokenKey"];
    [defaults setObject:[facebook1 expirationDate] forKey:@"FBExpirationDateKey"];
    [defaults synchronize];
    
    if ([facebook1 isSessionValid]){
        NSLog(@"getFBInfo"); 
        [facebook1 requestWithGraphPath:@"me" andDelegate:self];
        NSLog(@"after requestsent");
    }

    
}
- (void)fbDidNotLogin:(BOOL)cancelled{
    NSLog(@"fbDidNotLogin");
}
- (void)fbDidLogout {
    NSLog(@"fbDidLogout");
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [facebook1 invalidateSession];
    [defaults removeObjectForKey:@"FBAccessTokenKey"];
    [defaults removeObjectForKey:@"FBExpirationDateKey"];
    [defaults synchronize];
}
-(void)fbDidExtendToken:(NSString *)accessToken expiresAt:(NSDate *)expiresAt {
    NSLog(@"token extended");
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:accessToken forKey:@"FBAccessTokenKey"];
    [defaults setObject:expiresAt forKey:@"FBExpirationDateKey"];
    [defaults synchronize];
}

//Get Facebook Response
- (void)request:(FBRequest *)request didFailWithError:(NSError *)error{
    NSLog(@"did fail: %@", [error localizedDescription]);
    NSLog(@"Err details: %@", [error description]);
}
- (void)request:(FBRequest *)request didLoad:(id)result {
    NSLog(@"request:didLoad1");
    NSDictionary *userInfo = (NSDictionary *)result;
    fb_name = [NSString stringWithFormat:@"%@",[userInfo objectForKey:@"first_name"]];
    fb_email = [NSString stringWithFormat:@"%@",[userInfo objectForKey:@"email"]];
    
    
    [[SharedStrings sharedString] setEmailAddress:fb_email];
    [[SharedStrings sharedString] setNickname:fb_name];

    Kumulos* k = [[Kumulos alloc]init];
    [k setDelegate:self];
    [k getUserWithUsername:fb_email];
    
    /*NSLog(@"before sending to tab");

    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Storyboard1" bundle:nil];
    UIViewController *controller = [storyboard instantiateViewControllerWithIdentifier:@"tab"];
    self.window.rootViewController = controller;
    [self.window makeKeyAndVisible];*/

}

- (void) kumulosAPI:(Kumulos *)kumulos apiOperation:(KSAPIOperation *)operation getUserDidCompleteWithResult:(NSArray *)theResults{
    NSLog(@"getUserDidCompleteWithResult1");
    if ([theResults count]) {
        NSLog(@"IF");
        NSString *nickname = [[theResults objectAtIndex:0] objectForKey:@"firstname"];
        NSString *userID = [[theResults objectAtIndex:0] objectForKey:@"userID"];
        NSString *email = [[theResults objectAtIndex:0] objectForKey:@"username"];
        NSString *password1 = [[theResults objectAtIndex:0] objectForKey:@"password"];
        NSString *flag = [[theResults objectAtIndex:0] objectForKey:@"flag"];
        
        if([flag boolValue] ==1)
        {NSLog(@"bool=1");
            
            //User already exists (flag=1). Tie his friends etc.
            [[SharedStrings sharedString] setEmailAddress:email];
            [[SharedStrings sharedString] setNickname:nickname];
            [[SharedStrings sharedString] setUserID:userID];
            [[SharedStrings sharedString] setPassword:password1];
            
            Kumulos* k = [[Kumulos alloc]init];
            [k setDelegate:self];
            [k getFriendsWithUserID1:[userID intValue]];
        }
        else {
            NSLog(@"bool=0");
            //User exists but has not registered yet (flag=0). Update his flag to 1.
            [[SharedStrings sharedString] setEmailAddress:fb_email];
            [[SharedStrings sharedString] setNickname:fb_name];
            [[SharedStrings sharedString] setUserID:userID];
            [[SharedStrings sharedString] setPassword:@""];
            
            NSLog(@"FB email: %@", fb_email);
            NSLog(@"FB name: %@", fb_name);
            Kumulos* k = [[Kumulos alloc]init];
            [k setDelegate:self];
            [k updateUserWithUsername:fb_email andPassword:@"" andFirstname:fb_name andLastname:@"" andFlag:1];
            
        }
        
    }
    else {
        NSLog(@"ELSE3");
        NSLog(@"FB email: %@", fb_email);
        NSLog(@"FB name: %@", fb_name);
        //User does not exist. Add this account to kumulos
        Kumulos* k = [[Kumulos alloc]init];
        [k setDelegate:self];
        [k createNewUserWithUsername:fb_email andPassword:@"" andFirstname:fb_name andLastname:@"" andFlag:1];
    }
    
}

- (void) kumulosAPI:(Kumulos *)kumulos apiOperation:(KSAPIOperation *)operation updateUserDidCompleteWithResult:(NSNumber *)affectedRows{
    NSLog(@"updateUserDidCompleteWithResult");
    Kumulos* k = [[Kumulos alloc]init];
    [k setDelegate:self];
    [k getFriendsWithUserID1:[[[SharedStrings sharedString] getUserID] intValue]];
}

- (void) kumulosAPI:(Kumulos *)kumulos apiOperation:(KSAPIOperation *)operation createNewUserDidCompleteWithResult:(NSNumber *)newRecordID{
    NSLog(@"createNewUserDidCompleteWithResult");
    NSString *userID = [newRecordID stringValue];
    NSLog(@"Facebook login new ID = %@",userID);
    
    [[SharedStrings sharedString] setEmailAddress:fb_email];
    [[SharedStrings sharedString] setNickname:fb_name];
    [[SharedStrings sharedString] setUserID:userID];
    [[SharedStrings sharedString] setPassword:nil];
    
    Kumulos* k = [[Kumulos alloc]init];
    [k setDelegate:self];
    [k getFriendsWithUserID1:[userID intValue]];
}

- (void) kumulosAPI:(Kumulos*)kumulos apiOperation:(KSAPIOperation*)operation getFriendsDidCompleteWithResult:(NSArray*)theResults{
    //NSLog(@"getFriendsDidCompleteWithResult");
    
    [[SharedStrings sharedString] setFriends:theResults];
    
    //NSArray *friendsResult = [[SharedStrings sharedString] getFriends];
    
    //int count = [friendsResult count];
    //NSLog(@"FAVC Friends count = %u\n",count);
    
    [kumulos release];
    
    //Switch View to Summary Page
    NSLog(@"before sending to tab");
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Storyboard1" bundle:nil];
    UIViewController *controller = [storyboard instantiateViewControllerWithIdentifier:@"navcontroller"];
    
    //UINavigationController * navcontroller = [[UINavigationController alloc] init];
    //[self.navigationController pushViewController:navcontroller animated:YES];
    
    
    self.window.rootViewController = controller;
    [self.window makeKeyAndVisible];
    
}

/*- (void)tabBarController:(UITabBarController*)tabBarController didEndCustomizingViewControllers: (NSArray*)viewControllers
				 changed:(BOOL)changed
{
	NSLog(@"didEndCustomizingViewControllers");
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
	NSLog(@"didSelectViewController");
}*/

- (void)applicationWillResignActive:(UIApplication *)application
{
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    NSLog(@"applicationDidBecomeActive");
    [facebook1 extendAccessTokenIfNeeded];
}

- (id) init;
{
	//self.theAppDataObject = [[ExampleAppDataObject alloc] init];
	//[theAppDataObject release];
	return [super init];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    [facebook1  release];
    [window release];
    [navigationController release];
	//self.theAppDataObject = nil;
	
	[super dealloc];
    

}


@end
