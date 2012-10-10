//
//  addFriendViewController.m
//  FirstApp
//
//  Created by nishith agarwal on 5/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "addFriendViewController.h"
#import "Kumulos.h"
#import "SharedStrings.h"
#import "FriendsViewController.h"

@interface addFriendViewController ()

@end

@implementation addFriendViewController
@synthesize homeNavItem;
@synthesize home;
@synthesize friendName;
@synthesize friendEmail;


- (IBAction)viewDidLoad
{
    [super viewDidLoad];
    [self addNavigationBar];
    [home setBackgroundImage:[UIImage imageNamed:@"menubar.png"] forBarMetrics:UIBarMetricsDefault];
}

- (void) addNavigationBar {
    NSLog(@">>> Entering %s <<<", __PRETTY_FUNCTION__);
    //home = self.navigationController.navigationBar;
    //[home setBackgroundImage:[UIImage imageNamed:@"menubar.png"] forBarMetrics:UIBarMetricsDefault];
    
    //UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"111-user.png"] style:UIBarButtonSystemItemAdd target:nil action:@selector(addFriend:)];
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(saveFriend:)];
    //[barButton setImage:[UIImage imageNamed:@"111-user.png"]];
   // barButton.tintColor = [UIColor orangeColor];
    
    //self.navigationItem.rightBarButtonItem = barButton;
    UINavigationItem* navItem = homeNavItem;//[[UINavigationItem alloc] initWithTitle:@"XX"]; 
    //navItem.leftBarButtonItem = [self editButtonItem];
    navItem.rightBarButtonItem = barButton;
    //rightButton.tintColor = [UIColor orangeColor];
    //[rightButton release];
    
    UILabel *bigLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 0, 200,20)];
    [bigLabel setBackgroundColor:[UIColor clearColor]];
    [bigLabel setNumberOfLines:2];
    [bigLabel setTextAlignment:UITextAlignmentCenter];
    [bigLabel setContentMode:UIViewContentModeCenter];
    [bigLabel setFont:[UIFont  systemFontOfSize:19]];
    [bigLabel setTextColor:[UIColor whiteColor]];
    [bigLabel setShadowColor:[UIColor darkGrayColor]];
    [bigLabel setShadowOffset:CGSizeMake(0, 1)];
    bigLabel.text = [NSString stringWithFormat:@"Add Friend"];
    navItem.titleView = bigLabel;
    [bigLabel release];
    
    //home.items = [NSArray arrayWithObject:navItem];
    
}

- (IBAction) saveFriend:(id)sender
{
    NSLog(@"Save Friend function"); 
    if (![[SharedStrings sharedString] validateEmail:friendEmail.text] || friendName.text.length == 0 || [friendEmail.text isEqualToString:[[SharedStrings sharedString] getEmailAddress]]) {
        UIAlertView* alert = [[UIAlertView alloc]init];
        [alert addButtonWithTitle:@"OK"];
        [alert setDelegate:nil];
        [alert setTitle:@"Whoops"];
        [alert setMessage:@"Invalid entry"];
        [alert show];
        [alert release];
        return;
    }
    else if ([[[SharedStrings sharedString] getFriendsEmail] containsObject:friendEmail.text]) {
        UIAlertView* alert = [[UIAlertView alloc]init];
        [alert addButtonWithTitle:@"OK"];
        [alert setDelegate:nil];
        [alert setTitle:@"Whoops"];
        [alert setMessage:@"Friend already exists"];
        [alert show];
        [alert release];
        return;
    }
    else {
        Kumulos* k = [[Kumulos alloc]init];
        [k setDelegate:self];
        [k getUserWithUsername:friendEmail.text];
	}   
}

- (void) kumulosAPI:(Kumulos *)kumulos apiOperation:(KSAPIOperation *)operation getUserDidCompleteWithResult:(NSArray *)theResults{
    
    if([theResults count])
    {
        /*UIAlertView* alert = [[UIAlertView alloc]init];
        [alert addButtonWithTitle:@"OK"];
        [alert setDelegate:nil];
        [alert setTitle:@"Whoops"];
        [alert setMessage:@"User already exists!"];
        [alert show];
        [alert release];
        return;*/
        
        
        NSString *userID = [[theResults objectAtIndex:0] objectForKey:@"userID"];
        
        Kumulos* k = [[Kumulos alloc]init];
        [k setDelegate:self];
        [k addFriendWithUserID1:[[[SharedStrings sharedString] getUserID] intValue] andAmount:0.00 andUserID2:[userID intValue] andFriendID:0];
        
    }
    
    else {
        
        Kumulos* k = [[Kumulos alloc]init];
        [k setDelegate:self];
        [k createNewUserWithUsername:friendEmail.text andPassword:nil andFirstname:friendName.text andLastname:nil andFlag:0];
    }
}

- (void) kumulosAPI:(Kumulos *)kumulos apiOperation:(KSAPIOperation *)operation createNewUserDidCompleteWithResult:(NSNumber *)newRecordID{
    //NSLog(@"createNewUserDidComplete");
    Kumulos* k = [[Kumulos alloc]init];
    [k setDelegate:self];
    [k addFriendWithUserID1:[[[SharedStrings sharedString] getUserID] intValue] andAmount:0.00 andUserID2:[newRecordID intValue] andFriendID:0];
    
}

- (void) kumulosAPI:(Kumulos*)kumulos apiOperation:(KSAPIOperation*)operation addFriendDidCompleteWithResult:(NSNumber*)newRecordID{
    
    Kumulos* k = [[Kumulos alloc]init];
    [k setDelegate:self];
    [k getFriendsWithUserID1:[[[SharedStrings sharedString] getUserID] intValue]];
    
    
}

- (void) kumulosAPI:(Kumulos*)kumulos apiOperation:(KSAPIOperation*)operation getFriendsDidCompleteWithResult:(NSArray*)theResults{
    NSLog(@"getFriendsDidCompleteWithResult");
    
    [[SharedStrings sharedString] setFriends:theResults];
    
    NSArray *friendsResult = [[SharedStrings sharedString] getFriends];
    
    int count = [friendsResult count];
    NSLog(@"AFVC Friends count = %u\n",count);
    
    [kumulos release];
    
    //Switch View to Friends Page
     //[self dismissModalViewControllerAnimated:YES];
    //[self performSegueWithIdentifier:@"friendadded" sender:self];
    
   [self.navigationController popViewControllerAnimated:TRUE];
    
}


- (void) cancelButton{
    
    [self dismissModalViewControllerAnimated:NO];
}



- (void)viewDidUnload
{
    [self setHome:nil];
    [self setFriendName:nil];
    [self setFriendEmail:nil];
    [self setHomeNavItem:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [home release];
    [friendName release];
    [friendEmail release];
    [homeNavItem release];
    [super dealloc];
}
@end
