//
//  NewUserViewController.m
//  FirstApp
//
//  Created by nishith agarwal on 4/9/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "NewUserViewController.h"
#import "Kumulos.h"
#import "PieChartViewController.h"
#import "FirstAppViewController.h"
#import "SharedStrings.h"

@implementation NewUserViewController
@synthesize firstname;
@synthesize lastname;
@synthesize emailaddress;
@synthesize password;
@synthesize home;


-(void) viewDidLoad{
    
    [super viewDidLoad];
    
    //[home setBackgroundImage:[UIImage imageNamed:@"menubar.png"] forBarMetrics:UIBarMetricsDefault];
    
}

-(IBAction)cancelButton:(id)sender;{
    [self dismissModalViewControllerAnimated:NO];
}

-(IBAction) doRegister: (id) sender;{
    NSLog(@">>> Entering %s <<<", __PRETTY_FUNCTION__);
    if (firstname.text.length == 0 || lastname.text.length == 0 || (![[SharedStrings sharedString] validateEmail:emailaddress.text]) || password.text.length == 0) {
        UIAlertView* alert = [[UIAlertView alloc]init];
        [alert addButtonWithTitle:@"OK"];
        [alert setDelegate:nil];
        [alert setTitle:@"Whoops"];
        [alert setMessage:@"You need to input all fields"];
        [alert show];
        [alert release];
        return;
    }
    
    else {
        Kumulos* k = [[Kumulos alloc]init];
        [k setDelegate:self];
        [k getUserWithUsername:emailaddress.text];
    }
    
}

- (void) kumulosAPI:(Kumulos *)kumulos apiOperation:(KSAPIOperation *)operation getUserDidCompleteWithResult:(NSArray *)theResults{
    NSLog(@">>> Entering %s <<<", __PRETTY_FUNCTION__);
    //NSString *pass = [[theResults objectAtIndex:0] objectForKey:@"password"];
    if([theResults count])
    {NSLog(@"if");
        NSString *pass = [[theResults objectAtIndex:0] objectForKey:@"password"];
        if([[[theResults objectAtIndex:0] objectForKey:@"flag"] boolValue] ==1 && pass.length>0)
        {
        UIAlertView* alert = [[UIAlertView alloc]init];
        [alert addButtonWithTitle:@"OK"];
        [alert setDelegate:nil];
        [alert setTitle:@"Whoops"];
        [alert setMessage:@"User already exists!"];
        [alert show];
        [alert release];
        return;
        }
        else {
            /*UIAlertView* alert = [[UIAlertView alloc]init];
            [alert addButtonWithTitle:@"OK"];
            [alert setDelegate:nil];
            [alert setTitle:@"Whoops"];
            [alert setMessage:@"Friend already exists!"];
            [alert show];
            [alert release];
            return;*/
            
            Kumulos* k = [[Kumulos alloc]init];
            [k setDelegate:self];
            [k updateUserWithUsername:emailaddress.text andPassword:password.text andFirstname:firstname.text andLastname:lastname.text andFlag:1];
            
        }
    
    }
    
    /*else if(emailaddress.text == NULL){
        UIAlertView* alert = [[UIAlertView alloc]init];
        [alert addButtonWithTitle:@"OK"];
        [alert setDelegate:nil];
        [alert setTitle:@"Whoops"];
        [alert setMessage:@"Username cannot be null!"];
        [alert show];
        [alert release];
        return;
        
    }*/
    
    else {
        NSLog(@"else");
        Kumulos* k = [[Kumulos alloc]init];
        [k setDelegate:self];
        [k createNewUserWithUsername:emailaddress.text andPassword:password.text andFirstname:firstname.text andLastname:lastname.text andFlag:1];
    }
}

- (void) kumulosAPI:(Kumulos *)kumulos apiOperation:(KSAPIOperation *)operation createNewUserDidCompleteWithResult:(NSNumber *)newRecordID{
    NSLog(@">>> Entering %s <<<", __PRETTY_FUNCTION__);
    [kumulos release];
    
    /*FirstAppViewController *controller = [[FirstAppViewController alloc] initWithNibName:nil bundle:nil];
    [self presentModalViewController:controller animated:NO];*/
    
    [self performSegueWithIdentifier:@"login" sender:self];
    
}

-(void) kumulosAPI:(Kumulos *)kumulos apiOperation:(KSAPIOperation *)operation updateUserDidCompleteWithResult:(NSNumber *)affectedRows{
    NSLog(@">>> Entering %s <<<", __PRETTY_FUNCTION__);
    [self performSegueWithIdentifier:@"login" sender:self];
}


//Hide Keyboard
-(IBAction) goawaykeyboard: (id) sender;{
	[sender resignFirstResponder];
}

-(IBAction) taponbackground: (id) sender;{
    [firstname resignFirstResponder];
    [lastname resignFirstResponder];
	[emailaddress resignFirstResponder];
	[password resignFirstResponder];
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
    [home release];
    [firstname release];
	[lastname release];	
    [emailaddress release];
	[password release];
    [super dealloc];
}


@end
