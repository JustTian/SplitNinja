//CustomCell.m


#import "CustomCell.h"


@implementation CustomCell


@synthesize textLabel,bttn,isChecked;



-(id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier {
    NSLog(@"<<< Leaving %s >>>", __PRETTY_FUNCTION__);
    if (self = [super initWithFrame:frame ]) {
        
        //textLabel = [[UILabel alloc]init];
        
        //textLabel.textAlignment = UITextAlignmentLeft;
        
        
    }
    return self;
}

NSString *ABC=NULL;
NSString *xyz=NULL;
//-(void)checkBoxClicked:(id)sender{
//  
//    UIButton *tappedButton = (UIButton*)sender;
//  
//  
//    if([tappedButton.currentImage isEqual:[UIImage imageNamed:@"chkbox_unckd.png"]]) {
//        [sender  setImage:[UIImage imageNamed: @"chkbox_ckd.png"] forState:UIControlStateNormal];
//        UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"Message" 
//                                                         message:textLabel.text
//                                                        delegate:self
//                                               cancelButtonTitle:@"OK"
//                                               otherButtonTitles:nil,nil]autorelease];
//        [alert show];
//      
//        ans = textLabel.text;
//      
//      
//        NSLog(@"%@",ans);
//      
//      
//    }
//  
//    else {
//        [sender setImage:[UIImage imageNamed:@"chkbox_unckd.png"]forState:UIControlStateNormal];
//    }
//  
//  
//  
//}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    //  [bttn setImage:[UIImage imageNamed:@"chkbox_ckd.png"] forState:UIControlStateNormal];
    [super setSelected:selected animated:animated];
    
}
- (void)dealloc {
    
    [super dealloc];
}

@end