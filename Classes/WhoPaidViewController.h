//WhoPaidViewController.h


#import <UIKit/UIKit.h>
#import "CustomCell.h"

@interface WhoPaidViewController : UITableViewController <UITableViewDelegate, UINavigationBarDelegate, UINavigationControllerDelegate>
{
    
    NSMutableArray *listData;
    IBOutlet UITableView *table;
    IBOutlet CustomCell *cell;
    
    NSMutableArray *TitlesArray;
    
    
    NSMutableArray *isCheckedArr;
}
@property (retain, nonatomic) IBOutlet CustomCell *cell;
@property(nonatomic,retain)NSMutableArray *listData;
@property (retain, nonatomic) IBOutlet UITableView *table;

- (void)saveTheChanges;


@end