//
//  AddTransactionsViewController.h
//  FirstApp
//
//  Created by nishith agarwal on 4/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Kumulos.h"
#import "CustomCell.h"

@interface AddTransactionsViewController : UITableViewController <UIPickerViewDataSource, UIPickerViewDelegate, UIPickerViewAccessibilityDelegate, KumulosDelegate>
{
   // IBOutlet UILabel *dateLabel;
    IBOutlet UITextField *description;
    IBOutlet UITextField *amount;
    //IBOutlet UINavigationBar *home;
    IBOutlet UITableView *myTable;
   // IBOutlet UITextField *dateText;
}
@property (retain, nonatomic) IBOutlet CustomCell *whoowescell;
@property (retain, nonatomic) IBOutlet CustomCell *whopaidcell;
//@property (retain, nonatomic) IBOutlet UITextField *dateText;
@property (retain, nonatomic) IBOutlet UIButton *dateButton;
@property (retain, nonatomic) IBOutlet UITableView *myTable;
@property (retain, nonatomic) IBOutlet UITextField *description;
@property (retain, nonatomic) IBOutlet UITextField *amount;
//@property (retain, nonatomic) IBOutlet UILabel *dateLabel;
//@property (retain, nonatomic) IBOutlet UINavigationBar *home;
- (IBAction) pickDate:(id)sender;
//- (IBAction) handleBack:(id)sender;
//- (IBAction) pickContacts:(id)sender;
- (IBAction) pickWhoPaid:(id)sender;
- (IBAction) pickWhoOwes:(id)sender;
- (void) savetransaction:(id)sender;
@end
