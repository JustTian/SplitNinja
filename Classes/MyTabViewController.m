//
//  MyTabViewController.m
//  FirstApp
//
//  Created by nishith agarwal on 5/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MyTabViewController.h"

@interface MyTabViewController ()

@end

@implementation MyTabViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void) tabBar:(UITabBar *)tabBar willBeginCustomizingItems:(NSArray *)items
{
    UIView *editView = [self.tabBarController.view.subviews objectAtIndex:1];
    
    // change backgroundColor of Edit View
    editView.backgroundColor = [UIColor grayColor];
    
    
    
    // change color of Nav Bar in Edit View
    UINavigationBar *modalNavBar = [editView.subviews objectAtIndex:0];
    modalNavBar.tintColor = [UIColor orangeColor];
    
    // change title of Edit View
    modalNavBar.topItem.title = @"Edit Tabs";
    
}
- (void)tabBarController:(UITabBarController *)controller willBeginCustomizingViewControllers:(NSArray *)viewControllers {
    UIView *editView = [controller.view.subviews objectAtIndex:1];
    
    // change backgroundColor of Edit View
    editView.backgroundColor = [UIColor grayColor];
    
    
    
    // change color of Nav Bar in Edit View
    UINavigationBar *modalNavBar = [editView.subviews objectAtIndex:3];
    modalNavBar.tintColor = [UIColor orangeColor];
    
    // change title of Edit View
    modalNavBar.topItem.title = @"Edit Tabs";
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
