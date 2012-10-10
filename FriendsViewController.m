//
//  FriendsViewController.m
//  FirstApp
//
//  Created by nishith agarwal on 4/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FriendsViewController.h"
#import "Kumulos.h"
#import "SharedStrings.h"
#import "HistoryViewController.h"
#import "addFriendViewController.h"
#import "AddTransactionsViewController.h"
#import "SettingsViewController.h"

/*@interface FriendsViewController ()

@end*/

@implementation FriendsViewController

//@synthesize cell1;
@synthesize home;
@synthesize homeNavItem;
@synthesize myTable;
@synthesize contents;
@synthesize amounts;

@synthesize positive_friends, negative_friends, equal_friends;
@synthesize positive_amounts, negative_amounts, equal_amounts;


NSArray * friendsResult;
UIActionSheet *pickerAction;
NSString * friendname,*friendemail;

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@">>> Entering %s <<<", __PRETTY_FUNCTION__);
    
    //cell1.imageView.image = [UIImage imageNamed:@"tabbar.png"];
    

    [self addTableData];
    [self addNavigationBar];
    [self applyPaddedFooter];
    //[self customTabBar];
    NSLog(@">>> Leaving %s <<<", __PRETTY_FUNCTION__);
}


- (void)viewWillAppear:(BOOL)animated
{
    NSLog(@">>> Entering %s <<<", __PRETTY_FUNCTION__);
    //[super viewWillAppear:animated];
    //[self loadView];
    
    //[self addTableData];
    
    //contents = [[SharedStrings sharedString] getFriendsName];
    //amounts = [[SharedStrings sharedString] getFriendsAmount];
    
    //NSLog(@"Friends count is: %d", [contents count]);
    
    [self addTableData];
    [myTable reloadData];
    NSLog(@"Reloaded data");
    
    [self viewDidLoad];
	
}

- (void) popupbuttons{
    NSLog(@">>> Entering %s <<<", __PRETTY_FUNCTION__);    
    UIActionSheet *menu1 = [[UIActionSheet alloc] initWithTitle:nil 
                                                       delegate:self 
                                              cancelButtonTitle:@"Cancel" 
                                         destructiveButtonTitle:nil 
                                              otherButtonTitles:@"Add Friend", @"Add Expense", @"Settings", nil];
    [menu1 setBounds:CGRectMake(0, 0, 320, 250)];
    menu1.actionSheetStyle = UIActionSheetStyleDefault;
    //[menu1 showFromTabBar:self.tabBarController.tabBar];
    [menu1 showInView:self.navigationController.view];
    [menu1 release];
}

-(void)actionSheet:(UIActionSheet *)menu1 clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSLog(@">>> Entering %s <<<", __PRETTY_FUNCTION__);
    switch (buttonIndex) {
        case 0:
            [self performSegueWithIdentifier:@"addfriends" sender:self];
            break;
        case 1:
            [self performSegueWithIdentifier:@"expense" sender:self];
            break;
        case 2:
            [self performSegueWithIdentifier:@"settings" sender:self];
            break;
        default:
            [pickerAction dismissWithClickedButtonIndex:0 animated:YES];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    NSLog(@"Preparing For Segue");
    if ([[segue identifier] isEqual:@"history"]) {
        HistoryViewController *vc =[segue destinationViewController];
        [vc setFriend_name:friendname];
        [vc setFriend_email:friendemail];
        [vc setTitle:@"History"];
        
    } 
    if ([[segue identifier] isEqual:@"addfriends"]) {
        NSLog(@"Preparing For Add Friends Segue");
        addFriendViewController *vc =[segue destinationViewController];
        //[vc setFriend_name:friendname];
        //[vc setFriend_email:friendemail];
        [vc setTitle:@"Add Friends"];
        
    } 
    if ([[segue identifier] isEqual:@"expense"]) {
        NSLog(@"Preparing For expense Segue");
        AddTransactionsViewController *vc =[segue destinationViewController];
        [vc setTitle:@"Add Expenses"];
        //AddTransactionsViewController *controller = [[AddTransactionsViewController alloc] init];
        //[self.navigationController pushViewController:controller animated:YES];
        
    } 
    if ([[segue identifier] isEqual:@"settings"]) {
        NSLog(@"Preparing For expense Segue");
        SettingsViewController *vc =[segue destinationViewController];
        //[vc setFriend_name:friendname];
        //[vc setFriend_email:friendemail];
        [vc setTitle:@"Settings"];
        
    } 
}

- (void) addTableData{
    NSLog(@">>> Entering %s <<<", __PRETTY_FUNCTION__);
    contents = [[SharedStrings sharedString] getFriendsName];
    amounts = [[SharedStrings sharedString] getFriendsAmount];
    
    positive_friends = [[NSMutableArray alloc] init];
    negative_friends = [[NSMutableArray alloc] init];
    equal_friends = [[NSMutableArray alloc] init];
    positive_amounts = [[NSMutableArray alloc] init];
    negative_amounts = [[NSMutableArray alloc] init];
    equal_amounts = [[NSMutableArray alloc] init];
    
    for(int i=0;i<[amounts count];i++)
    {
        if([[amounts objectAtIndex:i] floatValue]>0.00){
            NSString *name = [contents objectAtIndex:i];
            [positive_amounts addObject:[amounts objectAtIndex:i]];
            [positive_friends addObject:name];
            //NSLog(@"F1VC Email = %@",[contents objectAtIndex:i]);
            //NSLog(@"F1VC Email = %@",[positive_friends objectAtIndex:i]);
        }
        else if([[amounts objectAtIndex:i] floatValue]<0.00){
            float amountf = fabs([[amounts objectAtIndex:i] floatValue]);
            [negative_amounts addObject:[NSString stringWithFormat:@"%.02f", amountf]];
            [negative_friends addObject:[contents objectAtIndex:i]];
        }
        else{
            float amountf = fabs([[amounts objectAtIndex:i] floatValue]);
            [equal_amounts addObject:[NSString stringWithFormat:@"%.02f", amountf]];
            [equal_friends addObject:[contents objectAtIndex:i]];
        }
        
    }
    
}

- (void) addNavigationBar {
    NSLog(@">>> Entering %s <<<", __PRETTY_FUNCTION__);
    //home = self.navigationController.navigationBar;
    //[home setBackgroundImage:[UIImage imageNamed:@"menubar.png"] forBarMetrics:UIBarMetricsDefault];
    
    //UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"111-user.png"] style:UIBarButtonSystemItemAdd target:self action:@selector(addFriend:)];
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"111-user.png"] style:UIBarButtonSystemItemAdd target:self action:@selector(addFriend:)];
    //[[UIBarButtonItem alloc] initWithTitle:@"Add" style:UIBarButtonItemStylePlain target:self action:@selector(addFriend:)];
    //[barButton setImage:[UIImage imageNamed:@"111-user.png"]];
    //barButton.tintColor = [UIColor orangeColor];
    
    //self.navigationItem.rightBarButtonItem = barButton;
    UINavigationItem* navItem = homeNavItem;//[[UINavigationItem alloc] initWithTitle:@"XX"]; 
    navItem.leftBarButtonItem = [self editButtonItem];
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
    bigLabel.text = [NSString stringWithFormat:@"%@", [[SharedStrings sharedString] getNickname]];
    navItem.titleView = bigLabel;
    [bigLabel release];

    //home.items = [NSArray arrayWithObject:navItem];
    
}

- (void) customTabBar{
    
    UIImage* tabBarBackground = [UIImage imageNamed:@"Tabbar1.png"];
    
    UITabBar *tabBar = self.tabBarController.tabBar;
    [tabBar setBackgroundImage:tabBarBackground];
    [tabBar setBackgroundColor:[UIColor redColor]];
    [tabBar setSelectionIndicatorImage:[UIImage imageNamed:@"red-tab.png"]];
    [tabBar setSelectedImageTintColor:[UIColor orangeColor]];
    [tabBar setTintColor:[UIColor lightGrayColor]];
    
    [[UITabBarItem appearance] setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [UIColor orangeColor], UITextAttributeTextColor, 
      [UIFont fontWithName:@"font" size:0.0], UITextAttributeFont, 
      nil] 
                                             forState:UIControlStateHighlighted];
}

- (IBAction) addFriend:(id)sender
{
    NSLog(@"PRESSED ADD BUTTON");
    [self popupbuttons];
    
    
}

- (void)applyPaddedFooter {
        NSLog(@">>> Entering %s <<<", __PRETTY_FUNCTION__);
    UIImageView *footerimage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"backgroundtexture1.png"]];
	//UIView *footer = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 400)] autorelease];
	//footer.backgroundColor = [UIColor lightTextColor];
	//self.myTable.tableFooterView = footerimage;
    self.myTable.backgroundView = footerimage;
    [footerimage release];
    
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{    NSLog(@">>> Entering %s <<<", __PRETTY_FUNCTION__);
    NSInteger rows=0;
    if(section == 0){
        rows = [positive_friends count];
    }
    if (section == 1) {
        rows = [negative_friends count];
    }
    if(section == 2){
        rows = [equal_friends count];
    }
    NSLog(@"rows is: %d", rows);
    return rows;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
        NSLog(@">>> Entering %s <<<", __PRETTY_FUNCTION__);
    //[self addTableData];
    return 3;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSLog(@">>> Entering %s <<<", __PRETTY_FUNCTION__);
    
    // create the label objects
    UILabel *headerLabel = [[[UILabel alloc] initWithFrame:CGRectZero] autorelease];
    headerLabel.backgroundColor = [UIColor darkGrayColor];
    headerLabel.font = [UIFont boldSystemFontOfSize:11];
    headerLabel.frame = CGRectMake(0,0,320,16);
    
    if(section == 0 && positive_friends.count>0){
        UIView* customView = [[[UIView alloc] initWithFrame:CGRectMake(0,0,320,16)] autorelease];
        headerLabel.text =  @" You need to collect";
        headerLabel.textColor = [UIColor whiteColor];
        [customView addSubview:headerLabel];
        return customView;
    }
    if(section == 1 && negative_friends.count>0){
        UIView* customView = [[[UIView alloc] initWithFrame:CGRectMake(0,0,320,16)] autorelease];
        headerLabel.text = @" You Owe";
        headerLabel.textColor = [UIColor whiteColor];
        [customView addSubview:headerLabel];
        return customView;
    }
    if(section == 2 && equal_friends.count>0){
        UIView* customView = [[[UIView alloc] initWithFrame:CGRectMake(0,0,320,16)] autorelease];
        headerLabel.text = @" You are even with";
        headerLabel.textColor = [UIColor whiteColor];
        [customView addSubview:headerLabel];
        return customView;
    }
    else {
        headerLabel.frame = CGRectMake(0,0,0,0);
        UIView* customView = [[[UIView alloc] initWithFrame:CGRectMake(0,0,0,0)] autorelease];
        return customView;
    }
    //eturn customView;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
        NSLog(@">>> Entering %s <<<", __PRETTY_FUNCTION__);
    if(section == 0 && positive_friends.count>0){
        return 16.0;
    }
    if(section == 1 && negative_friends.count>0){
        return 16.0;
    }
    if(section == 2 && equal_friends.count>0){
	return 16.0;
    }
    else {
        return 0.0;
    }
}



/*- (void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{

    cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"backgroundtexture1.png"]];
    cell.frame = CGRectMake(0,1,500,100);
}*/

- (UITableViewCell *)tableView:(UITableView *)tableView
		 cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@">>> Entering %s <<<", __PRETTY_FUNCTION__);
    NSString *contentForThisRow;
    NSString *amountForThisRow;
	
    static NSString *CellIdentifier = @"myCell";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    if (cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
    
    }
    
    
    if(indexPath.section == 0)
    {
        contentForThisRow =  [positive_friends objectAtIndex:[indexPath row]];
        amountForThisRow = [NSString stringWithFormat: @"$%@", [positive_amounts objectAtIndex:[indexPath row]]];
        [[cell textLabel] setText:contentForThisRow];
        [[cell detailTextLabel] setText:amountForThisRow];
    }
    if(indexPath.section == 1)
    {
        contentForThisRow =  [negative_friends objectAtIndex:[indexPath row]];
        amountForThisRow = [NSString stringWithFormat: @"$%@", [negative_amounts objectAtIndex:[indexPath row]]];
        [[cell textLabel] setText:contentForThisRow];
        [[cell detailTextLabel] setText:amountForThisRow];
    }
    if(indexPath.section == 2)
    {
        contentForThisRow =  [equal_friends objectAtIndex:[indexPath row]];
        amountForThisRow = [NSString stringWithFormat: @"$%@", [equal_amounts objectAtIndex:[indexPath row]]];
        [[cell textLabel] setText:contentForThisRow];
        [[cell detailTextLabel] setText:amountForThisRow];
    }

	
    //NSLog(@"<<< Leaving %s >>>", __PRETTY_FUNCTION__);
    return cell;
    
}

//GO TO HISTORY PAGE
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{    NSLog(@">>> Entering %s <<<", __PRETTY_FUNCTION__);
    [myTable deselectRowAtIndexPath:indexPath animated:NO];
 
    if(indexPath.section==0){
    friendname = [positive_friends objectAtIndex:[indexPath row]];
    }
    if(indexPath.section==1){
        friendname = [negative_friends objectAtIndex:[indexPath row]];
    }
    if(indexPath.section==2){
        friendname = [equal_friends objectAtIndex:[indexPath row]];
    }
    NSUInteger indexOfTheObject = [contents indexOfObject:friendname];
    friendemail = [[[SharedStrings sharedString] getFriendsEmail] objectAtIndex:indexOfTheObject];
    [self performSegueWithIdentifier:@"history" sender:self];

}
    


//DELETE FRIENDS - Removes friends form list if balance is equal to zero
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    // If row is deleted, remove it from the list.
    if (editingStyle == UITableViewCellEditingStyleDelete){
        if(indexPath.section==0 || indexPath.section==1){NSLog(@"IF");
            UIAlertView* alert = [[UIAlertView alloc]init];
             [alert addButtonWithTitle:@"OK"];
             [alert setDelegate:nil];
             [alert setTitle:@"Whoops"];
             [alert setMessage:@"Can't delete friends with nonzero balance!"];
             [alert show];
             [alert release];
             return;
        }
        else{NSLog(@"ELSEa");
            //Remove from arrays
            NSString *friendname = [equal_friends objectAtIndex:[indexPath row]];
            
            NSUInteger indexOfTheObject = [contents indexOfObject:friendname];
            NSString *friendemail = [[[SharedStrings sharedString] getFriendsEmail] objectAtIndex:indexOfTheObject];
            
            NSLog(@"Friend Name = %@",friendname);
            NSLog(@"Friend UserID = %@",friendemail);
            [equal_friends removeObjectAtIndex:[indexPath row]];
            [equal_amounts removeObjectAtIndex:[indexPath row]]; 
            [myTable deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
            //[myTable reloadData];
            //NSLog(@"Reloaded data");
            Kumulos* k = [[Kumulos alloc]init];
            [k setDelegate:self];
            [k getUserWithUsername:friendemail];

        }
        
    }
    
    
}

- (void) kumulosAPI:(Kumulos *)kumulos apiOperation:(KSAPIOperation *)operation getUserDidCompleteWithResult:(NSArray *)theResults{
    NSLog(@"Get friend details complete");
    NSString *frienduserID = [[theResults objectAtIndex:0] objectForKey:@"userID"];
    NSLog(@"Friend UserID = %@",frienduserID);
    Kumulos* k = [[Kumulos alloc]init];
    [k setDelegate:self];
    [k deleteFriendWithUserID2:[[[SharedStrings sharedString] getUserID] intValue] andUserID1:[frienduserID intValue]];
    [k deleteFriendWithUserID2:[frienduserID intValue] andUserID1:[[[SharedStrings sharedString] getUserID] intValue]];
    
}

- (void) kumulosAPI:(Kumulos *)kumulos apiOperation:(KSAPIOperation *)operation deleteFriendDidCompleteWithResult:(NSNumber *)affectedRows{
    NSLog(@"FRIEND DELETED!!!");
    
    Kumulos* k = [[Kumulos alloc]init];
    [k setDelegate:self];
    [k getFriendsWithUserID1:[[[SharedStrings sharedString] getUserID] intValue]];
}

- (void) kumulosAPI:(Kumulos*)kumulos apiOperation:(KSAPIOperation*)operation getFriendsDidCompleteWithResult:(NSArray*)theResults{
    NSLog(@"getFriendsDidCompleteWithResult");
    
    //NSLog(@"Updating myTable");
    [[SharedStrings sharedString] setFriends:theResults];
    [self addTableData];
    
    [kumulos release];
    
}
- (void)viewDidUnload
{
    NSLog(@">>> Entering %s <<<", __PRETTY_FUNCTION__);
    /*[myTable release], myTable = nil;
    [contents release], contents = nil;
    [amounts release], amounts = nil;
    [friendsResult release], friendsResult = nil;*/
    
    [home release];
    home = nil;
    [self setHome:nil];
    //[self setCell1:nil];
    [self setHomeNavItem:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    NSLog(@">>> Entering %s <<<", __PRETTY_FUNCTION__);
    [myTable release], myTable = nil;
    [contents release], contents = nil;
    [amounts release], amounts = nil;
    
    [positive_friends release], positive_friends = nil;
    [positive_amounts release], positive_amounts = nil;
    [negative_friends release], negative_friends = nil;
    [negative_amounts release], negative_amounts = nil;   
    [equal_friends release], equal_friends = nil;
    [equal_amounts release], equal_amounts = nil;
    [friendsResult release], friendsResult = nil;
    [home release];
    //[cell1 release];
    [homeNavItem release];
    [super dealloc];
}
@end
