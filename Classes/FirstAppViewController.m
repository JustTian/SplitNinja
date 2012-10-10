
#import "FirstAppViewController.h"
#import "NewUserViewController.h"
#import "PieChartViewController.h"
#include "Kumulos.h"
#import "FBConnect.h"
#import "FBRequest.h"
#import "FirstAppAppDelegate.h"
#import "SharedStrings.h"


@implementation FirstAppViewController
@synthesize emailaddress;
@synthesize password;
@synthesize facebook;
@synthesize fbname;
@synthesize home;
@synthesize userName;
NSArray *permissions;
FirstAppAppDelegate *appDelegate;
NSString *fb_firstname, *fb_lastname, *fb_email;

- (void)viewDidLoad
{
    NSLog(@"viewDidLoad");
    [super viewDidLoad];
    //[self addNavigationBar];
    
    permissions = [[NSArray alloc] initWithObjects:
                   @"user_likes",
                   @"read_stream",
                   @"email",
                   @"offline_access",
                   nil];
}

- (void) addNavigationBar {
    NSLog(@">>> Entering %s <<<", __PRETTY_FUNCTION__);
    [home setBackgroundImage:[UIImage imageNamed:@"menubar.png"] forBarMetrics:UIBarMetricsDefault];
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Sign In" style:UIBarButtonSystemItemAdd target:nil action:@selector(login:)];
    
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:@"New User" style:UIBarButtonItemStylePlain target:nil action:@selector(newuser:)];
    
    UINavigationItem* navItem = self.navigationItem;
    navItem.leftBarButtonItem = leftButton;
    navItem.rightBarButtonItem = rightButton;
    [leftButton release];
    [rightButton release];
    
    UILabel *bigLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 0, 200,20)];
    [bigLabel setBackgroundColor:[UIColor clearColor]];
    [bigLabel setNumberOfLines:2];
    [bigLabel setTextAlignment:UITextAlignmentCenter];
    [bigLabel setContentMode:UIViewContentModeCenter];
    [bigLabel setFont:[UIFont  systemFontOfSize:19]];
    [bigLabel setTextColor:[UIColor whiteColor]];
    [bigLabel setShadowColor:[UIColor darkGrayColor]];
    [bigLabel setShadowOffset:CGSizeMake(0, 1)];
    bigLabel.text = @"Split Ninja";
    navItem.titleView = bigLabel;
    [bigLabel release];
    
    home.items = [NSArray arrayWithObject:navItem];
    
}

-(IBAction) facebooklogin: (id) sender;{
    NSLog(@"fbClickLoginButton");
    
    appDelegate = (FirstAppAppDelegate *) [[UIApplication sharedApplication] delegate];
    
    if (![appDelegate.facebook1 isSessionValid]) {
            NSLog(@"if: fbClickLoginButton");
        [appDelegate.facebook1 authorize:permissions];
    }
    else {
            NSLog(@"else: fbClickLoginButton");
        [self sendFBRequest];
    }
}


- (void) newuser:(id)sender{
    //NSLog(@"Entering new user");
        [self performSegueWithIdentifier:@"user" sender:self];
}
/*-(IBAction) paypal: (id) sender;{	
    
    [self performSegueWithIdentifier:@"tab" sender:self];
	PayPalViewController *newuserController = [[PayPalViewController alloc]
												initWithNibName:@"PayPalViewController"
												bundle:nil];
	[self.view addSubview:newuserController.view];	
}*/


//Authenticate Login and go to the Summary Page
-(IBAction) login: (id) sender;{	

    //Send query to authenticate username/password	
    if (![[SharedStrings sharedString] validateEmail:emailaddress.text] || password.text.length == 0) {
        UIAlertView* alert = [[UIAlertView alloc]init];
        [alert addButtonWithTitle:@"OK"];
        [alert setDelegate:nil];
        [alert setTitle:@"Whoops"];
        [alert setMessage:@"We didn't recognise your username and password"];
        [alert show];
        [alert release];
        return;
    }
    else {
        Kumulos* k = [[Kumulos alloc]init];
        [k setDelegate:self];
        //[self showLoadingIndicator];
        [k userLoginWithUsername:emailaddress.text andPassword:password.text andFlag:1];
	}    
}

//Send Facebook Request
-(void) sendFBRequest{
    NSLog(@"getFBInfo"); 
    [appDelegate.facebook1 requestWithGraphPath:@"me" andDelegate:self];
    NSLog(@"after requestsent");
    return;
}

//Get Facebook Response
- (void)request:(FBRequest *)request didFailWithError:(NSError *)error{
    NSLog(@"did fail: %@", [error localizedDescription]);
    NSLog(@"Err details: %@", [error description]);
}
- (void)request:(FBRequest *)request didLoad:(id)result {
    NSLog(@"request:didLoad78");
    NSDictionary *userInfo = (NSDictionary *)result;
    fb_firstname = [NSString stringWithFormat:@"%@",[userInfo objectForKey:@"first_name"]];
    fb_email = [NSString stringWithFormat:@"%@",[userInfo objectForKey:@"email"]];
    fb_lastname = [NSString stringWithFormat:@"%@",[userInfo objectForKey:@"last_name"]];
    
    [[SharedStrings sharedString] setEmailAddress:fb_email];
    [[SharedStrings sharedString] setNickname:fb_firstname];
    [[SharedStrings sharedString] setString:fb_lastname];
    
    NSLog(@"Facebook email = %@", fb_email);
    NSLog(@"Facebook lastname = %@", fb_lastname);
    NSLog(@"Facebook firstname = %@", fb_firstname);
    
    Kumulos* k = [[Kumulos alloc]init];
    [k setDelegate:self];
    [k getUserWithUsername:fb_email];
    
    /*[[SharedStrings sharedString] setEmailAddress:fb_email];
    [[SharedStrings sharedString] setNickname:fb_name];
    [[SharedStrings sharedString] setUserID:@"5"];*/ 
    
    /*Kumulos* k = [[Kumulos alloc]init];
    [k setDelegate:self];
    [k getFriendsWithUserID1:5];*/

}

- (void) kumulosAPI:(Kumulos *)kumulos apiOperation:(KSAPIOperation *)operation getUserDidCompleteWithResult:(NSArray *)theResults{
    NSLog(@"getUserDidCompleteWithResult");
    NSString *lastname = [[SharedStrings sharedString] getString];
    NSString *firstname = [[SharedStrings sharedString] getNickname];
    
    if ([theResults count]) {
        NSLog(@"IF2");
        NSString *nickname = [[theResults objectAtIndex:0] objectForKey:@"firstname"];
        NSString *userID = [[theResults objectAtIndex:0] objectForKey:@"userID"];
        NSString *email = [[theResults objectAtIndex:0] objectForKey:@"username"];
        NSString *password1 = [[theResults objectAtIndex:0] objectForKey:@"password"];
        NSString *flag = [[theResults objectAtIndex:0] objectForKey:@"flag"];
        
        if([flag boolValue] ==1)
        {
            
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
            //User exists but has not registered yet (flag=0). Update his flag to 1.
            [[SharedStrings sharedString] setEmailAddress:fb_email];
            [[SharedStrings sharedString] setNickname:firstname];
            [[SharedStrings sharedString] setUserID:userID];
            [[SharedStrings sharedString] setPassword:@""];
            
            Kumulos* k = [[Kumulos alloc]init];
            [k setDelegate:self];
            [k updateUserWithUsername:fb_email andPassword:@"" andFirstname:firstname andLastname:@"" andFlag:1];
            
        }

        
    }
    else {
        NSLog(@"ELSE2");
        //User does not exist. Add this account to kumulos
        

        
        NSLog(@"Facebook email = %@", fb_email);
        NSLog(@"Facebook lastname = %@", lastname);
        NSLog(@"Facebook firstname = %@", firstname);
                                                                    
        Kumulos* k = [[Kumulos alloc]init];
        [k setDelegate:self];
        [k createNewUserWithUsername:fb_email andPassword:@"" andFirstname:firstname andLastname:@"" andFlag:1];
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
    
    //[[SharedStrings sharedString] setEmailAddress:fb_email];
    //[[SharedStrings sharedString] setNickname:fb_firstname];
    [[SharedStrings sharedString] setUserID:userID];
    [[SharedStrings sharedString] setPassword:@""];
    
    Kumulos* k = [[Kumulos alloc]init];
    [k setDelegate:self];
    [k getFriendsWithUserID1:[userID intValue]];
}



- (void) kumulosAPI:(Kumulos*)kumulos apiOperation:(KSAPIOperation*)operation userLoginDidCompleteWithResult:(NSArray*)theResults{
    NSLog(@"userLoginDidCompleteWithResult");
    if ([theResults count]) {
        
        NSString *nickname = [[theResults objectAtIndex:0] objectForKey:@"firstname"];
        NSString *userID = [[theResults objectAtIndex:0] objectForKey:@"userID"];
        
        [[SharedStrings sharedString] setEmailAddress:emailaddress.text];
        [[SharedStrings sharedString] setPassword:password.text];
        [[SharedStrings sharedString] setNickname:nickname];
        [[SharedStrings sharedString] setUserID:userID];
        
        
        /*NSLog(@"FAVC Email = %@",emailaddress.text);
        NSLog(@"FAVC Password = %@",password.text);
        NSLog(@"FAVC Nickname = %@",nickname);
        NSLog(@"FAVC UserID = %@",userID);*/
        
        Kumulos* k = [[Kumulos alloc]init];
        [k setDelegate:self];
        [k getFriendsWithUserID1:[userID intValue]];

        
        /*PieChartViewController *controller = [[PieChartViewController alloc] initWithNibName:nil bundle:nil];
        [self presentModalViewController:controller animated:NO];*/
        
    }
	else {
        
        UIAlertView* alert = [[UIAlertView alloc]init];
        
        [alert addButtonWithTitle:@"OK"];
        [alert setDelegate:nil];
        [alert setTitle:@"We didn't recognise your username and password"];
        [alert setMessage:@"Please try again."];
        [alert show];
        [alert release];
    }

	[kumulos release];
}

- (void) kumulosAPI:(Kumulos*)kumulos apiOperation:(KSAPIOperation*)operation getFriendsDidCompleteWithResult:(NSArray*)theResults{
    //NSLog(@"getFriendsDidCompleteWithResult");
    
    [[SharedStrings sharedString] setFriends:theResults];
    
    //NSArray *friendsResult = [[SharedStrings sharedString] getFriends];
    
    //int count = [friendsResult count];
    //NSLog(@"FAVC Friends count = %u\n",count);
    
    [kumulos release];
    //Switch View to Summary Page
    NSLog(@"USE THE TAB SEGUE");
    [self performSegueWithIdentifier:@"tab" sender:self];
    UINavigationController * navcontroller = [[UINavigationController alloc] init];
    [self.navigationController pushViewController:navcontroller animated:YES];

}


//Hide Keyboard
-(IBAction) goawaykeyboard: (id) sender;{
	[sender resignFirstResponder];
}
-(IBAction) taponbackground: (id) sender;{
	[emailaddress resignFirstResponder];
	[password resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    [self setHome:nil];
}

- (void)dealloc {
    [fb_lastname release];
    [fb_firstname release];
    [fb_email release];
	[emailaddress release];
	[password release];
    [home release];
    [super dealloc];
}

@end
