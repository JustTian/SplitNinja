//
//  PickDateViewController.m
//  FirstApp
//
//  Created by nishith agarwal on 5/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PickDateViewController.h"

@interface PickDateViewController ()

@end

@implementation PickDateViewController
@synthesize home;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addNavigationBar];
}

- (void) addNavigationBar {
    [home setBackgroundImage:[UIImage imageNamed:@"menubar.png"] forBarMetrics:UIBarMetricsDefault];
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonSystemItemAdd target:nil action:@selector(save:)];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonSystemItemAdd target:self action:@selector(handleBack:)];
    UINavigationItem* navItem = self.navigationItem;
    navItem.leftBarButtonItem = leftButton;
    navItem.rightBarButtonItem = rightButton;
    [leftButton release];
    
    UILabel *bigLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 0, 200,20)];
    [bigLabel setBackgroundColor:[UIColor clearColor]];
    [bigLabel setNumberOfLines:2];
    [bigLabel setTextAlignment:UITextAlignmentCenter];
    [bigLabel setContentMode:UIViewContentModeCenter];
    [bigLabel setFont:[UIFont  systemFontOfSize:19]];
    [bigLabel setTextColor:[UIColor whiteColor]];
    [bigLabel setShadowColor:[UIColor darkGrayColor]];
    [bigLabel setShadowOffset:CGSizeMake(0, 1)];
    bigLabel.text = @"Date";
    navItem.titleView = bigLabel;
    [bigLabel release];
    
    home.items = [NSArray arrayWithObject:navItem];
}

- (void) handleBack:(id)sender
{
    [self dismissModalViewControllerAnimated:NO];
}

- (void) save:(id)sender
{
    [self dismissModalViewControllerAnimated:NO];
    
}

- (void)viewDidUnload
{
    [self setHome:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [home release];
    [super dealloc];
}
@end
