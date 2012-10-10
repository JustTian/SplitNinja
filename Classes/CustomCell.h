//CustomCell.h

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>


@interface CustomCell :UITableViewCell {
    IBOutlet UILabel *textLabel;
    IBOutlet UIButton *bttn;
    BOOL isChecked;
    NSString *ans;
    
    
}
@property (nonatomic,retain) IBOutlet UILabel *textLabel;
@property (nonatomic,assign) BOOL isChecked;
@property(nonatomic,assign)IBOutlet UIButton *bttn;
//-(void)checkBoxClicked:(id)sender;

@end