//
//  PieChartViewController.h
//  FirstApp
//
//  Created by nishith agarwal on 4/10/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BNPieChart.h"
#import "Kumulos.h"

@interface PieChartViewController : UIViewController <KumulosDelegate>  {

	BNPieChart *achart;
    BNPieChart *negativeChart;
    UILabel *fbname;
    IBOutlet UILabel *positive_sum;
    IBOutlet UILabel *negative_sum;
	
    IBOutlet UINavigationBar *home;
    IBOutlet UISegmentedControl *segment;
}
@property (retain, nonatomic) IBOutlet UISegmentedControl *segment;
@property (retain, nonatomic) IBOutlet UILabel *negative_sum;
@property (retain, nonatomic) IBOutlet UILabel *positive_sum;
@property (retain, nonatomic) IBOutlet UINavigationBar *home;

@property(retain, nonatomic) IBOutlet BNPieChart *achart;
@property(retain, nonatomic) IBOutlet BNPieChart *negativeChart;
@property(retain, nonatomic) IBOutlet UILabel *fbname;

@end
