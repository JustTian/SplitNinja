//
//  FriendsViewController.h
//  FirstApp
//
//  Created by nishith agarwal on 4/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Kumulos.h"

@interface FriendsViewController : UITableViewController <UITableViewDelegate, KumulosDelegate, UIActionSheetDelegate, UINavigationBarDelegate, UINavigationControllerDelegate>

{
    IBOutlet UITableView *myTable;
    //IBOutlet UITableViewCell *cell1;
    
    NSMutableArray *contents;
    NSMutableArray *amounts;
    NSMutableArray *positive_friends, *negative_friends, *equal_friends;
    NSMutableArray *positive_amounts, *negative_amounts, *equal_amounts;
    IBOutlet UINavigationBar *home;
}
//@property (retain, nonatomic) IBOutlet UITableViewCell *cell1;
@property (retain, nonatomic) IBOutlet UINavigationBar *home;
@property (retain, nonatomic) IBOutlet UINavigationItem *homeNavItem;
@property (retain, nonatomic) IBOutlet UITableView *myTable;
@property (retain, nonatomic) IBOutlet NSMutableArray *contents;
@property (retain, nonatomic) IBOutlet NSMutableArray *amounts;
@property (retain, nonatomic) IBOutlet NSMutableArray *positive_friends;
@property (retain, nonatomic) IBOutlet NSMutableArray *negative_friends;
@property (retain, nonatomic) IBOutlet NSMutableArray *equal_friends;
@property (retain, nonatomic) IBOutlet NSMutableArray *positive_amounts;
@property (retain, nonatomic) IBOutlet NSMutableArray *negative_amounts;
@property (retain, nonatomic) IBOutlet NSMutableArray *equal_amounts;

- (IBAction)addFriend:(id)sender;

@end
