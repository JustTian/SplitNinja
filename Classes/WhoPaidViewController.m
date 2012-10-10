//addsymptom.m

#import "WhoPaidViewController.h"
#import "CustomCell.h"
#import "SharedStrings.h"



@implementation WhoPaidViewController


@synthesize cell;
@synthesize listData;
@synthesize table;

- (void)viewDidLoad
{    NSLog(@">>> Entering %s <<<", __PRETTY_FUNCTION__);
    
    self.navigationItem.title= @"Who Paid";
    table = self.tableView;
    
    //ADD BACKGROUND IMAGE
    UIImageView *footerimage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"backgroundtexture1.png"]];
    table = self.tableView;
    table.backgroundView = footerimage;
    [footerimage release];
    
    listData =[[NSMutableArray alloc] init];
    listData = [[SharedStrings sharedString] getFriendsName];
    [listData addObject:[[SharedStrings sharedString] getNickname]];
    
    UIBarButtonItem *saveButton=[[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonSystemItemDone target:self action:@selector(saveTheChanges)];
    
    isCheckedArr = [[NSMutableArray alloc] init];
    
    for (int i=0; i<[listData count]; i++) {
        [isCheckedArr addObject:@"0"];
    }
    
    self.navigationItem.rightBarButtonItem = saveButton;
    
    [saveButton release];
    
    TitlesArray = [[NSMutableArray alloc] init];    
}


- (void)saveTheChanges {
    NSLog(@">>> Entering %s <<<", __PRETTY_FUNCTION__);
    
    for (int i=0; i<[isCheckedArr count]; i++) {
        if ([[isCheckedArr objectAtIndex:i] isEqualToString:@"1"]) {
            for (int j=0; j<[TitlesArray count]; j++) {
                if ([[listData objectAtIndex:i] isEqualToString:[TitlesArray objectAtIndex:j]]) {
                    [TitlesArray removeObjectAtIndex:j];
                }
                
            }
            [TitlesArray addObject:[listData objectAtIndex:i]];
            
            
        }
        
    }
    
    for (int i=0; i<[TitlesArray count]; i++) {
        NSLog(@"%@",[TitlesArray objectAtIndex:i]);
        
    }
    [[SharedStrings sharedString] setWhoPaid:TitlesArray];
    NSLog(@"=======");
    [self.navigationController popViewControllerAnimated:YES];
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@">>> Entering %s <<<", __PRETTY_FUNCTION__);
    NSLog(@"rows is: %d", [listData count]);
    return [listData count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView
		 cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@">>> Entering %s <<<", __PRETTY_FUNCTION__);
    //NSString *contentForThisRow;
	
    static NSString *CellIdentifier = @"CustomCell";
    
    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[[CustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    
    
    UILabel *textLabel = [[[UILabel alloc] initWithFrame:CGRectMake(40.0, 7, 320.0,30)] autorelease];
    textLabel.tag = 1;
    textLabel.font = [UIFont systemFontOfSize:15.0];
    textLabel.text = [listData objectAtIndex:[indexPath row]];
    textLabel.textAlignment = UITextAlignmentLeft;
    textLabel.textColor =[UIColor colorWithRed:0.120 green:0.330 blue:0.550 alpha:1.000];
    textLabel.autoresizingMask = UIViewAutoresizingFlexibleRightMargin |
    UIViewAutoresizingFlexibleHeight;
    textLabel.backgroundColor = [UIColor clearColor];
    [cell.contentView addSubview:textLabel];
    }

    UIButton *image_bttn = [[[UIButton alloc] initWithFrame:CGRectMake(5.0, 4, 30,40)] autorelease];
    cell.bttn = image_bttn;
    [cell.bttn setImage:[UIImage imageNamed:@"145-persondot.png"] forState:UIControlStateNormal];
    cell.bttn.tag = 1;
    [cell.contentView addSubview:cell.bttn];

    
    UIButton *bttn = [[[UIButton alloc] initWithFrame:CGRectMake(290.0, 7, 20,30)] autorelease];
    cell.bttn = bttn;
    
    
    
    if ([[isCheckedArr objectAtIndex:indexPath.row] isEqualToString:@"1"])
    {
        [cell.bttn setImage:[UIImage imageNamed:@"117-todo.png"] forState:UIControlStateNormal];
        cell.bttn.tag = 2;
        [cell.contentView addSubview:cell.bttn];
    }
    else
    {
       [[cell.contentView viewWithTag:2]removeFromSuperview];
    }

    
    return cell;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{    NSLog(@">>> Entering %s <<<", __PRETTY_FUNCTION__);
    [table deselectRowAtIndexPath:indexPath animated:NO];
    
    if ([[isCheckedArr objectAtIndex:indexPath.row] isEqualToString:@"0"]){
        [isCheckedArr replaceObjectAtIndex:indexPath.row withObject:@"1"];
    }
    else {
        [isCheckedArr replaceObjectAtIndex:indexPath.row withObject:@"0"];
    }
    
    [table reloadData];
    
}


- (void)updateCheckbox:(id)sender {
    NSLog(@">>> Entering %s <<<", __PRETTY_FUNCTION__);
    
    if ([[isCheckedArr objectAtIndex:[sender tag]] isEqualToString:@"0"]) {
        
        [isCheckedArr replaceObjectAtIndex:[sender tag] withObject:@"1"];
        
    }
    else if ([[isCheckedArr objectAtIndex:[sender tag]] isEqualToString:@"1"]) {
        [isCheckedArr replaceObjectAtIndex:[sender tag] withObject:@"0"];
        
        for (int i=0; i<[TitlesArray count]; i++) {
            if ([[listData objectAtIndex:[sender tag]] isEqualToString:[TitlesArray objectAtIndex:i]]) {
                [TitlesArray removeObjectAtIndex:i];
            }
        }   
    }
    
    [table reloadData];
    
}


- (void)viewDidUnload
{
    [self setCell:nil];
    NSLog(@">>> Entering %s <<<", __PRETTY_FUNCTION__);
    //    self.listData = nil;
}


- (void)dealloc
{   
    
    [listData release];
    
    [TitlesArray release];
    [isCheckedArr release];
    
    [cell release];
    [super dealloc];
}

@end