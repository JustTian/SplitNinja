//
//  HistoryViewController.h
//  FirstApp
//
//  Created by nishith agarwal on 5/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Kumulos.h"

@interface HistoryViewController : UITableViewController <KumulosDelegate>
{
    IBOutlet UITableView *myTable;
    IBOutlet UINavigationBar *home;
    NSString *friend_name;
    NSString *friend_email;
}
@property (retain, nonatomic) IBOutlet UINavigationItem *homeNavItem;
@property (retain, nonatomic) IBOutlet UITableView *myTable;
@property (retain, nonatomic) IBOutlet UINavigationBar *home;
@property (retain, nonatomic) NSString *friend_name;
@property (retain, nonatomic) NSString *friend_email;

@end
