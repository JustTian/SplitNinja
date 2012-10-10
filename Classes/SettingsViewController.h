//
//  SettingsViewController.h
//  FirstApp
//
//  Created by nishith agarwal on 5/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsViewController : UITableViewController
{
    IBOutlet UINavigationBar *home;
}
@property (retain, nonatomic) IBOutlet UINavigationBar *home;
@property (retain, nonatomic) IBOutlet UINavigationItem *homeNavItem;

-(IBAction) inviteFriends;
-(IBAction) sendEmail;
@end
