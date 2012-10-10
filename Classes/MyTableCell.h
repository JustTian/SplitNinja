//
//  MyTableCell.h
//  FirstApp
//
//  Created by nishith agarwal on 5/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyTableCell : UITableViewCell
{
NSMutableArray *columns;
}
- (void)addColumn:(CGFloat)position;

@end
