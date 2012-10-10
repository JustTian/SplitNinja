//
//  ExampleAppDataObject.m
//  ViewControllerDataSharing
//
//  Created by Duncan Champney on 7/29/10.

#import "ExampleAppDataObject.h"


@implementation ExampleAppDataObject
@synthesize string1;
@synthesize data1;
@synthesize float1;

#pragma mark -
#pragma mark -Memory management methods

- (void)dealloc 
{
	//Release any properties declared as retain or copy.
	self.string1 = nil;
	self.data1 = nil;
	[super dealloc];
}
@end
