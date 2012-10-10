//
//  HistoryViewController.m
//  FirstApp
//
//  Created by nishith agarwal on 5/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HistoryViewController.h"
#import "Kumulos.h"
#import "SharedStrings.h"
#import "MyTableCell.h"

@interface HistoryViewController ()

@end

@implementation HistoryViewController
@synthesize homeNavItem;
@synthesize myTable;
@synthesize home;
@synthesize friend_name;
@synthesize friend_email;

NSMutableArray *contents, *amounts, *dates;


- (void)viewWillAppear:(BOOL)animated
{
    NSLog(@">>> Entering %s <<<", __PRETTY_FUNCTION__);
	
    [super viewWillAppear:animated];
    
    /*NSLog(@"Hist Friend Name = %@",friend_name);
    NSLog(@"Hist Friend Email = %@",friend_email);
    
    Kumulos* k = [[Kumulos alloc]init];
    [k setDelegate:self];
    [k getUserWithUsername:friend_email];*/
	
    NSLog(@"<<< Leaving %s >>>", __PRETTY_FUNCTION__);
}


- (void)viewDidLoad
{NSLog(@">>> Entering %s <<<", __PRETTY_FUNCTION__);
    [super viewDidLoad];

    [self addNavigationBar];
    [self applyPaddedFooter];
    
    
    dates = [[NSMutableArray alloc] init];
    contents = [[NSMutableArray alloc] init];
    amounts = [[NSMutableArray alloc] init];
    
    NSLog(@"Hist Friend Name = %@",friend_name);
    NSLog(@"Hist Friend Email = %@",friend_email);
    
    Kumulos* k = [[Kumulos alloc]init];
    [k setDelegate:self];
    [k getUserWithUsername:friend_email];

}



- (void) kumulosAPI:(Kumulos *)kumulos apiOperation:(KSAPIOperation *)operation getUserDidCompleteWithResult:(NSArray *)theResults{
    NSLog(@"Get friend details complete");
    NSString *frienduserID = [[theResults objectAtIndex:0] objectForKey:@"userID"];
    NSLog(@"Friend UserID = %@",frienduserID);
    Kumulos* k = [[Kumulos alloc]init];
    [k setDelegate:self];
    [k getTransactionsWithPaidby:[[[SharedStrings sharedString] getUserID] intValue] andOwedBy:[frienduserID intValue]];
    [k getTransactionsWithPaidby:[frienduserID intValue] andOwedBy: [[[SharedStrings sharedString] getUserID] intValue]];
    
}


    
-(void) kumulosAPI:(Kumulos *)kumulos apiOperation:(KSAPIOperation *)operation getTransactionsDidCompleteWithResult:(NSArray *)theResults{
    NSLog(@"Yaa1");
    if([theResults count])
    {
        for(int i=0;i<[theResults count];i++)
        {
        float amountf = [[[theResults objectAtIndex:i] objectForKey:@"amount"] floatValue];
        NSString *description = [[theResults objectAtIndex:i] objectForKey:@"description"];
        NSString *paidby = [[theResults objectAtIndex:i] objectForKey:@"paidby"];
        NSDate *date= [[theResults objectAtIndex:i] objectForKey:@"timeCreated"];
           
        NSDateFormatter* formatter = [[[NSDateFormatter alloc] init] autorelease];
        [formatter setDateFormat:@"MM-dd-YY"];
        NSString* timeCreated = [formatter stringFromDate:date];
            
       // NSLog(@"Date1 = %@", timeCreated);
            
            if([paidby isEqualToString:[[SharedStrings sharedString] getUserID]])
                {
                    [dates addObject:[NSString stringWithFormat:@"%@", timeCreated]];
                    [contents addObject:[NSString stringWithFormat:@"%@", description]];
                    [amounts  addObject:[NSString stringWithFormat:@"-$%.02f", amountf]];
                }
            else {
                [dates addObject:[NSString stringWithFormat:@"%@", timeCreated]];
                [contents addObject:[NSString stringWithFormat:@"%@", description]];
                [amounts addObject:[NSString stringWithFormat:@"$%.02f", amountf]];
            }

        }
        //NSLog(@"Yaa");
        [myTable reloadData];
    }
}

- (void) addNavigationBar {
    //self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    //[self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"menubar.png"] forBarMetrics:UIBarMetricsDefault];
    //[home setBackgroundImage:[UIImage imageNamed:@"menubar.png"] forBarMetrics:UIBarMetricsDefault];
    
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonSystemItemAdd target:self action:@selector(handleBack:)];
    //UINavigationItem* 
    UINavigationItem *navItem = homeNavItem;
    //navItem.leftBarButtonItem = leftButton;
    navItem.rightBarButtonItem =  [self editButtonItem];
    [leftButton release];
    
    UILabel *bigLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 0, 200,20)];
    [bigLabel setBackgroundColor:[UIColor clearColor]];
    [bigLabel setNumberOfLines:2];
    [bigLabel setTextAlignment:UITextAlignmentCenter];
    [bigLabel setContentMode:UIViewContentModeCenter];
    [bigLabel setFont:[UIFont  systemFontOfSize:19]];
    [bigLabel setTextColor:[UIColor whiteColor]];
    [bigLabel setShadowColor:[UIColor darkGrayColor]];
    [bigLabel setShadowOffset:CGSizeMake(0, 1)];
    bigLabel.text = friend_name;
    navItem.titleView = bigLabel;
    [bigLabel release];
    
    //home.items = [NSArray arrayWithObject:navItem];
}

- (void)applyPaddedFooter {
    UIImageView *footerimage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"backgroundtexture1.png"]];
	//UIView *footer = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 400)] autorelease];
	//footer.backgroundColor = [UIColor lightTextColor];
	//self.myTable.tableFooterView = footerimage;
    self.myTable.backgroundView = footerimage;
    [footerimage release];
}

- (void) handleBack:(id)sender
{
    [self dismissModalViewControllerAnimated:NO];
    
}

- (void) save:(id)sender
{
    [self dismissModalViewControllerAnimated:NO];
    
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    NSInteger rows=0;
    if(section == 0){
        rows = [contents count];
    }
    if (section == 1) {
        rows = [contents count];
    }
    //NSLog(@"rows is: %d", rows);
    return rows;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

/*- (void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"backgroundtexture1.png"]];
    cell.frame = CGRectMake(0,1,500,100);
}*/

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSLog(@">>> Entering %s <<<", __PRETTY_FUNCTION__);
    //UIView* customView = [[[UIView alloc] initWithFrame:CGRectMake(0,0,320,16)] autorelease];
    
    // create the label objects
    UILabel *headerLabel = [[[UILabel alloc] initWithFrame:CGRectZero] autorelease];
    headerLabel.backgroundColor = [UIColor darkGrayColor];
    headerLabel.font = [UIFont boldSystemFontOfSize:11];
    headerLabel.frame = CGRectMake(0,0,320,16);
    
    if(section == 0 && contents.count>0){
        UIView* customView = [[[UIView alloc] initWithFrame:CGRectMake(0,0,320,16)] autorelease];
        headerLabel.text =  @"Transactions";
        headerLabel.textColor = [UIColor whiteColor];
        [customView addSubview:headerLabel];
        return customView;
    }
    if(section == 1 && contents.count>0){
        UIView* customView = [[[UIView alloc] initWithFrame:CGRectMake(0,0,320,16)] autorelease];
        headerLabel.text = @" Your friend paid for";
        headerLabel.textColor = [UIColor whiteColor];
        [customView addSubview:headerLabel];
        return customView;
    }
    else {
        UIView* customView = [[[UIView alloc] initWithFrame:CGRectMake(0,0,0,0)] autorelease];
        return customView;
    }
    //eturn customView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
		 cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@">>> Entering %s <<<", __PRETTY_FUNCTION__);
	
    NSString *dateForThisRow = [dates objectAtIndex:[indexPath row]];
    NSString *contentForThisRow =  [contents objectAtIndex:[indexPath row]];
    NSString *amountForThisRow = [amounts objectAtIndex:[indexPath row]];
	
    static NSString *CellIdentifier = @"myCell";
    
    MyTableCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[[MyTableCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
        UILabel *label = [[[UILabel alloc] initWithFrame:CGRectMake(0.0, 0, 80.0,tableView.rowHeight)] autorelease];
        [cell addColumn:0];
        label.tag = 1;
        label.font = [UIFont systemFontOfSize:15.0];
        label.text = dateForThisRow;//[NSString stringWithFormat:@"%d", indexPath.row];
        label.textAlignment = UITextAlignmentLeft;
        label.textColor =[UIColor colorWithRed:0.120 green:0.330 blue:0.550 alpha:1.000];
        label.autoresizingMask = UIViewAutoresizingFlexibleRightMargin |
        UIViewAutoresizingFlexibleHeight;
        label.backgroundColor = [UIColor clearColor];
        [cell.contentView addSubview:label];
        
        
        label =  [[[UILabel alloc] initWithFrame:CGRectMake(80.0, 0, 160.0,tableView.rowHeight)] autorelease];
        [cell addColumn:20];
        label.tag = 2;
        label.font = [UIFont systemFontOfSize:15.0];
        // add some silly value
        label.text = contentForThisRow;//[NSString stringWithFormat:@"%d", indexPath.row * 4];
        label.textAlignment = UITextAlignmentLeft;
        label.textColor =[UIColor colorWithRed:0.120 green:0.330 blue:0.550 alpha:1.000];
        label.autoresizingMask = UIViewAutoresizingFlexibleRightMargin |
        UIViewAutoresizingFlexibleHeight;
        label.backgroundColor = [UIColor clearColor];
        [cell.contentView addSubview:label];
        
        label =  [[[UILabel alloc] initWithFrame:CGRectMake(240.0, 0, 80.0,tableView.rowHeight)] autorelease];
        [cell addColumn:20];
        label.tag = 3;
        label.font = [UIFont systemFontOfSize:15.0];
        // add some silly value
        label.text = amountForThisRow;//[NSString stringWithFormat:@"%d", indexPath.row * 4];
        label.textAlignment = UITextAlignmentRight;
        label.textColor = [UIColor colorWithRed:0.120 green:0.330 blue:0.550 alpha:1.000];
        label.autoresizingMask = UIViewAutoresizingFlexibleRightMargin |
        UIViewAutoresizingFlexibleHeight;
        label.backgroundColor = [UIColor clearColor];
        [cell.contentView addSubview:label];
    }
    
	
    NSLog(@"<<< Leaving %s >>>", __PRETTY_FUNCTION__);
    //[contentForThisRow release];
    return cell;
    
}


- (void)viewDidUnload
{
    [self setHome:nil];
    [self setMyTable:nil];
    [self setHomeNavItem:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source




// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate
/*
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
  
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
    
}*/

- (void)dealloc {
    [friend_name release];
    [friend_email release];
    [home release];
    [myTable release];
    [homeNavItem release];
    [super dealloc];
}
@end
