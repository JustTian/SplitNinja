//
//  PieChartViewController.m
//  FirstApp
//
//  Created by nishith agarwal on 4/10/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "PieChartViewController.h"
#import "BNPieChart.h"
#import "FirstAppAppDelegate.h"
#import "SharedStrings.h"
#import "Kumulos.h"


@implementation PieChartViewController
@synthesize segment;
@synthesize negative_sum;
@synthesize positive_sum;
@synthesize home;
@synthesize achart;
@synthesize negativeChart;
@synthesize fbname;

NSString * userID;
NSString *emailaddress, *password,*nickname;
NSString *friendname, *amount, *userID1, *userID2;

//FirstAppAppDelegate *appDelegate;

- (void) viewDidLoad{
    
    
    //UIImageView *backgroundimage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"backgroundtexture1.png"]];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"backgroundtexture1.png"]];
   // self.tableView.backgroundView = backgroundimage;
    
    
    [self customNavigationBar];
    [self customTabBar];
    [self segmentButton];
    [self displayPie];

}

- (void) segmentButton{
    
    [segment addTarget:self
	                     action:@selector(pickOne:)
	           forControlEvents:UIControlEventValueChanged];
}

//Action method executes when user touches the button
- (void) pickOne:(id)sender{
    
    [self performSegueWithIdentifier:@"friends" sender:self];
} 

- (void)viewWillAppear:(BOOL)animated
{
    NSLog(@">>> Entering %s <<<", __PRETTY_FUNCTION__);
    [super viewWillAppear:animated];
    [self loadView];

    [self viewDidLoad];
	
}

- (void) customNavigationBar {
    
    [home setBackgroundImage:[UIImage imageNamed:@"menubar.png"] forBarMetrics:UIBarMetricsDefault];
    UINavigationItem* navItem = self.navigationItem;
       
    /*UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"19-gear.png"] style:UIBarButtonSystemItemAdd target:nil action:@selector(addFriend:)];
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"111-user.png"] style:UIBarButtonSystemItemAdd target:nil action:@selector(addFriend:)];
    rightButton.tintColor = [UIColor lightGrayColor];
    leftButton.tintColor = [UIColor lightGrayColor];

    
    //[rightButton setBackgroundImage:[UIImage imageNamed:@"red-tab.png"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    navItem.leftBarButtonItem = leftButton;
    navItem.rightBarButtonItem = rightButton;*/
    
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
    
    home.items = [NSArray arrayWithObject:navItem];
    //[home setItems:[NSArray arrayWithObjects:theNavigationItem,nil]];
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

- (void) displayPie{
    
    fbname.text = [NSString stringWithFormat:@"%@", [[SharedStrings sharedString] getNickname]];
    
    NSMutableArray *contents;
    NSMutableArray *amounts;
    NSMutableArray *positive_friends, *negative_friends, *equal_friends;
    NSMutableArray *positive_amounts, *negative_amounts, *equal_amounts;
    
    contents = [[SharedStrings sharedString] getFriendsName];
    amounts = [[SharedStrings sharedString] getFriendsAmount];
    
    positive_friends = [[NSMutableArray alloc] init];
    negative_friends = [[NSMutableArray alloc] init];
    equal_friends = [[NSMutableArray alloc] init];
    positive_amounts = [[NSMutableArray alloc] init];
    negative_amounts = [[NSMutableArray alloc] init];
    equal_amounts = [[NSMutableArray alloc] init];
    
    
    float sum1=0.00, sum2=0.00;
    for(int i=0;i<[amounts count];i++)
    {
        if([[amounts objectAtIndex:i] floatValue]>0.00){
            float amountf = fabs([[amounts objectAtIndex:i] floatValue]);
            sum1 = sum1 + amountf;
            [positive_amounts addObject:[NSString stringWithFormat:@"%.02f", amountf]];
            [positive_friends addObject:[contents objectAtIndex:i]];
        }
        else if([[amounts objectAtIndex:i] floatValue]<0.00){
            float amountf = fabs([[amounts objectAtIndex:i] floatValue]);
            sum2 = sum2 + amountf;
            [negative_amounts addObject:[NSString stringWithFormat:@"%.02f", amountf]];
            [negative_friends addObject:[contents objectAtIndex:i]];
        }
    }
    
    float positive_ratio=0.0, negative_ratio=0.0;
    //Display positive pie
    if([positive_friends count]==0)
        [achart addSlicePortion:1 withName:@"None"];
    else {
        for (int i=0;i<[positive_friends count];i++)
        {
            //NSLog(@"Positive sum = %f", positive_sum);
            positive_ratio = fabs([[positive_amounts objectAtIndex:i] floatValue])/sum1;
            //NSLog(@"ratio = %0.1f", positive_ratio);
            NSString *percentage = [NSString stringWithFormat:@"%0.0f",(positive_ratio * 100)];
            //NSLog(@"Percentage = %@%%", percentage);
            NSString *str = [NSString stringWithFormat: @"%@(%@%%)",[positive_friends objectAtIndex:i],percentage];
            [achart addSlicePortion:positive_ratio withName:str];
        }
    }
    
    //Display negative pie
    if([negative_friends count]==0)
        [negativeChart addSlicePortion:1 withName:@"None"];
    else {
        for (int i=0;i<[negative_friends count];i++)
        {
            //NSLog(@"Negative sum = %f", negative_sum);
            negative_ratio = fabs([[negative_amounts objectAtIndex:i] floatValue])/sum2;
            NSString *percentage = [NSString stringWithFormat:@"%0.0f",(negative_ratio * 100)];
            NSString *str = [NSString stringWithFormat: @"%@(%@%%)",[negative_friends objectAtIndex:i],percentage];
            [negativeChart addSlicePortion:negative_ratio withName:str];
        }
        
    }
    
    positive_sum.text = [NSString stringWithFormat:@"$%.02f", sum1];
    negative_sum.text = [NSString stringWithFormat:@"$%.02f", sum2];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    NSLog(@">>> Entering %s <<<", __PRETTY_FUNCTION__);
    [home release], home = nil;
    [self setHome:nil];
    [self setAchart:nil];
    [self setPositive_sum:nil];
    [self setNegative_sum:nil];
    [self setSegment:nil];
    [super viewDidUnload];
}


- (void)dealloc {
    [emailaddress release];
    [password release];
    [nickname release];
    [userID release];
    [amount release];
    [friendname release];
    [userID1    release];
    [userID2    release];
	[achart release];
    [home release];
    [positive_sum release];
    [negative_sum release];
    [segment release];
    [super dealloc];
}


@end
