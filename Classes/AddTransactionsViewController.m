//
//  AddTransactionsViewController.m
//  FirstApp
//
//  Created by nishith agarwal on 4/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AddTransactionsViewController.h"
#import <MessageUI/MFMailComposeViewController.h>

#import <AddressBook/AddressBook.h>
#import <AddressBook/ABAddressBook.h>
#import <AddressBook/ABPerson.h>
#import "WhoPaidViewController.h"
#import "WhoOwesViewController.h"
#import "SharedStrings.h"
#import "Kumulos.h"

@interface AddTransactionsViewController ()

@end

@implementation AddTransactionsViewController
//@synthesize dateText;
@synthesize whoowescell;
@synthesize whopaidcell;
@synthesize dateButton;
@synthesize myTable;
@synthesize description;
@synthesize amount;
//@synthesize dateLabel;
//@synthesize home;
UIActionSheet *pickerAction;
NSArray *pickerArray;

- (void)viewDidLoad
{   NSLog(@">>> Entering %s <<<", __PRETTY_FUNCTION__);
    [super viewDidLoad];
    [self applyPaddedFooter];
    [self addNavigationBar];
    [[SharedStrings sharedString] setWhoPaid:nil];
    [[SharedStrings sharedString] setWhoPaid:nil];

}

- (void)viewWillAppear:(BOOL)animated
{
    NSLog(@">>> Entering %s <<<", __PRETTY_FUNCTION__);

    if ([[[SharedStrings sharedString] getWhoPaid] count] > 0)
    {
        UIButton *bttn = [[[UIButton alloc] initWithFrame:CGRectMake(270.0, 7, 20,30)] autorelease];
        whopaidcell.bttn = bttn;
        
        [whopaidcell.bttn setImage:[UIImage imageNamed:@"117-todo.png"] forState:UIControlStateNormal];
        whopaidcell.bttn.tag = 2;
        [whopaidcell.contentView addSubview:whopaidcell.bttn];
    }
    
    if ([[[SharedStrings sharedString] getWhoOwes] count] > 0)
    {
        UIButton *bttn = [[[UIButton alloc] initWithFrame:CGRectMake(270.0, 7, 20,30)] autorelease];
        whoowescell.bttn = bttn;
        
        [whoowescell.bttn setImage:[UIImage imageNamed:@"117-todo.png"] forState:UIControlStateNormal];
        whoowescell.bttn.tag = 2;
        [whoowescell.contentView addSubview:whoowescell.bttn];
    }
}

//PICK DATE
- (void) pickDate:(id)sender{
    
    pickerAction=[[UIActionSheet alloc]initWithTitle:nil delegate:nil cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
    [pickerAction setActionSheetStyle:UIActionSheetStyleBlackTranslucent];
    CGRect pickerFrame = CGRectMake(0, 40, 0, 0);
    
    UIDatePicker *datePicker =[[[UIDatePicker alloc]initWithFrame:pickerFrame] autorelease];
    [datePicker setDatePickerMode:UIDatePickerModeDate];
    [pickerAction addSubview:datePicker];
    
    UISegmentedControl *closeButton=[[UISegmentedControl alloc]initWithItems:[NSArray arrayWithObject:@"OK"]];
    closeButton.momentary = YES;
    closeButton.frame=CGRectMake(260, 7.0f, 50.0f, 30.0f);
    closeButton.segmentedControlStyle =UISegmentedControlStyleBar;
    closeButton.tintColor = [UIColor blackColor];
    
    
    [closeButton addTarget:self action:@selector(closeDatePicker) forControlEvents:UIControlEventValueChanged];
    [pickerAction addSubview:closeButton];
    [closeButton release];
    [pickerAction showInView:self.view];
    [pickerAction setBounds:CGRectMake(0, 0, 320, 464)];
}
- (void) closeDatePicker{
    NSDate *pickedDate = [[NSDate alloc] init];
    for (UIView *view in pickerAction.subviews) {
        if ([view isKindOfClass:[UIDatePicker class]]){
            UIDatePicker *picker = (UIDatePicker *)view;
            pickedDate = picker.date;
        }
    }
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMMM d, YYYY"];
    NSString *str  = [formatter stringFromDate:pickedDate ];
    [pickedDate release];
    //NSLog(@"Date = %@", str);
    [pickerAction dismissWithClickedButtonIndex:0 animated:YES];
    dateButton.titleLabel.text = str;
    [dateButton setTitle:str forState:UIControlStateNormal];
    //dateText.text = str;
    dateButton.titleLabel.textColor = [UIColor blackColor];
    //NSLog(@"Date Label = %@", dateButton.titleLabel.text);
}

//SET NAVIGATION BAR
- (void) addNavigationBar {
    NSLog(@">>> Entering %s <<<", __PRETTY_FUNCTION__);
    //[home setBackgroundImage:[UIImage imageNamed:@"menubar.png"] forBarMetrics:UIBarMetricsDefault];

    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonSystemItemFlexibleSpace target:self action:@selector(savetransaction:)];

    UINavigationItem* navItem = self.navigationItem;
    
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
    bigLabel.text = @"Add Expense";
    navItem.titleView = bigLabel;
    [bigLabel release];
    
    //home.items = [NSArray arrayWithObject:navItem];
    
}

/*- (IBAction) handleBack:(id)sender
{
    [self dismissModalViewControllerAnimated:NO];
}*/

//SET BACKGROUND IMAGE
- (void)applyPaddedFooter {
    UIImageView *footerimage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"backgroundtexture1.png"]];
	self.myTable.tableFooterView = footerimage;
    self.myTable.backgroundView = footerimage;
}

//PICK WHO PAID
- (IBAction) pickWhoPaid:(id)sender;
{
    WhoPaidViewController *controller = [[WhoPaidViewController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}

//PICK WHO OWES
- (IBAction) pickWhoOwes:(id)sender;
{
    WhoOwesViewController *controller = [[WhoOwesViewController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}

//SAVE TRANSACTION
- (void) savetransaction:(id)sender
{    NSLog(@"SAVE TRANSACTION");
    if(description.text.length==0 || amount.text.length==0 || ([[[SharedStrings sharedString] getWhoPaid] count]==0) || ([[[SharedStrings sharedString] getWhoOwes] count]==0) )
    {
        UIAlertView* alert = [[UIAlertView alloc]init];
        [alert addButtonWithTitle:@"OK"];
        [alert setDelegate:nil];
        [alert setTitle:@"Whoops"];
        [alert setMessage:@"You need to input all fields"];
        [alert show];
        [alert release];
        return;
    }
    
    //ADD CHECK TO MAKE SURE YOU ARE IN THE TRANSACTION
    //ADD CHECK TO MAKE SURE AMOUNT IS FLOAT
    
    else{
        NSLog(@"Who Paid Count: %d", [[[SharedStrings sharedString] getWhoPaid] count]);
        NSLog(@"Who Owes Count: %d", [[[SharedStrings sharedString] getWhoOwes] count]);
        
        
        Kumulos* k = [[Kumulos alloc]init];
        [k setDelegate:self];
        [k addTransactionWithDescription:description.text andAmount:2.0 andId:0 andPaidby:1 andOwedBy:1];
        
        
        //[self sendStealthEmail];
    }
}

//SEND EMAIL WHEN TRANSACTION IS ADDED
- (void) sendStealthEmail
{
    NSLog(@"Composing Email");
    MFMailComposeViewController *mailComposeViewController = [[MFMailComposeViewController alloc] init];
    mailComposeViewController.mailComposeDelegate = self;
    [mailComposeViewController setToRecipients:[NSArray arrayWithObject:@"agarwal1985@gmail.com"]];
    [mailComposeViewController setSubject:@"Stealth email"];
    [mailComposeViewController setMessageBody:@"Pwned" isHTML:NO];
    [mailComposeViewController view];
}

- (void) mailComposeController:(MFMailComposeViewController*)mailComposeViewController bodyFinishedLoadingWithResult:(NSInteger)result error:(NSError*)error
{
    NSLog(@"Sending email");
    @try
    {
        id mailComposeController = [mailComposeViewController valueForKeyPath:@"internal.mailComposeController"];
        id sendButtonItem = [mailComposeViewController valueForKeyPath:@"internal.mailComposeView.sendButtonItem"];
        [mailComposeController performSelector:@selector(send:) withObject:sendButtonItem];
    }
    @catch (NSException *e) {}
    [mailComposeViewController release];
    //[self dismissModalViewControllerAnimated:NO];
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)viewDidUnload
{
    NSLog(@">>> Entering %s <<<", __PRETTY_FUNCTION__);
    [description release], description = nil;
    [amount release], amount = nil;
    [self setDateButton:nil];
    [self setWhopaidcell:nil];
    [self setWhoowescell:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    //[pickerAction release];
    [description release];
    [amount release];
    [myTable release];
    [dateButton release];
    //[dateText release];
    [whopaidcell release];
    [whoowescell release];
    [super dealloc];
}
@end
