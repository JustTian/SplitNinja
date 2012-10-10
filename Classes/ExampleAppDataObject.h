//
//  ExampleAppDataObject.h
//  ViewControllerDataSharing
//
//  Created by Duncan Champney on 7/29/10.

#import <Foundation/Foundation.h>
#import "AppDataObject.h"


@interface ExampleAppDataObject : AppDataObject 
{
	NSString*	string1;
	NSData*		data1;
	NSInteger	int1;
	CGFloat		float1;
}

@property (nonatomic, copy) NSString* string1;
@property (nonatomic, retain) NSData* data1;
@property (nonatomic) CGFloat	float1;

@end
