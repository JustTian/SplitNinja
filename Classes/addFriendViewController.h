//
//  addFriendViewController.h
//  FirstApp
//
//  Created by nishith agarwal on 5/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Kumulos.h"

@interface addFriendViewController : UITableViewController <KumulosDelegate>
{
    IBOutlet UINavigationBar *home;
    IBOutlet UITextField *friendName;
    IBOutlet UITextField *friendEmail;
}
@property (retain, nonatomic) IBOutlet UINavigationItem *homeNavItem;
@property (retain, nonatomic) IBOutlet UINavigationBar *home;
@property (retain, nonatomic) IBOutlet UITextField *friendName;
@property (retain, nonatomic) IBOutlet UITextField *friendEmail;

- (IBAction) saveFriend:(id)sender; 
-(IBAction) cancelButton;

@end
