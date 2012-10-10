//
//  SettingsViewController.m
//  FirstApp
//
//  Created by nishith agarwal on 5/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SettingsViewController.h"
#import <MessageUI/MFMailComposeViewController.h>

@interface SettingsViewController ()

@end

@implementation SettingsViewController
@synthesize home;
@synthesize homeNavItem;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIImageView *backgroundimage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"backgroundtexture1.png"]];
    self.tableView.backgroundView = backgroundimage;
    [backgroundimage release];
    [self addNavigationBar];
}

- (void) addNavigationBar {
    NSLog(@">>> Entering %s <<<", __PRETTY_FUNCTION__);
    //[home setBackgroundImage:[UIImage imageNamed:@"menubar.png"] forBarMetrics:UIBarMetricsDefault];
    
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithTitle:@"Sign Out" style:UIBarButtonItemStylePlain target:self action:@selector(signOut:)];
    //barButton.tintColor = [UIColor orangeColor];

    
    UINavigationItem* navItem = homeNavItem;
    //navItem.leftBarButtonItem = rightButton;
    navItem.rightBarButtonItem = barButton;
    
    UILabel *bigLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 0, 200,20)];
    [bigLabel setBackgroundColor:[UIColor clearColor]];
    [bigLabel setNumberOfLines:2];
    [bigLabel setTextAlignment:UITextAlignmentCenter];
    [bigLabel setContentMode:UIViewContentModeCenter];
    [bigLabel setFont:[UIFont  systemFontOfSize:19]];
    [bigLabel setTextColor:[UIColor whiteColor]];
    [bigLabel setShadowColor:[UIColor darkGrayColor]];
    [bigLabel setShadowOffset:CGSizeMake(0, 1)];
    bigLabel.text = @"Settings";
    navItem.titleView = bigLabel;
    [bigLabel release];
    
    home.items = [NSArray arrayWithObject:navItem];
    
}

- (void) signOut:(id)sender
{
    NSLog(@"Sign Out function");
    [self performSegueWithIdentifier:@"signout" sender:self];
    
    
}

-(void) inviteFriends{
    
    if ([MFMailComposeViewController canSendMail]) {
        NSLog(@"Can send emails!!");
        NSString *messagebody = @"Split Ninja is a free service that helps friends to borrow money and stuff.";
        MFMailComposeViewController* controller = [[MFMailComposeViewController alloc] init];
        controller.mailComposeDelegate = self;
        [controller setSubject:@"Checkout this awesome app!"];
        [controller setMessageBody:messagebody isHTML:YES];
        //[controller setToRecipients:[NSArray arrayWithObject:@"support@billninja.com"]];
        if (controller) 
            [self presentModalViewController:controller animated:YES];
        [controller release];
    }
    
}

-(void) sendEmail{
    
    if ([MFMailComposeViewController canSendMail]) {
        NSLog(@"Can send emails!!");
        MFMailComposeViewController* controller = [[MFMailComposeViewController alloc] init];
        controller.mailComposeDelegate = self;
        [controller setToRecipients:[NSArray arrayWithObject:@"support@splitninja.com"]];
        if (controller) 
            [self presentModalViewController:controller animated:YES];
        [controller release];
    }
    
}

- (void)mailComposeController:(MFMailComposeViewController*)controller  
          didFinishWithResult:(MFMailComposeResult)result 
                        error:(NSError*)error;
{
    if (result == MFMailComposeResultSent) {
        NSLog(@"It's away!");
    }
    [self dismissModalViewControllerAnimated:YES];
}

- (void)viewDidUnload
{
    [self setHomeNavItem:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [home release];
    [homeNavItem release];
    [super dealloc];
}
@end
