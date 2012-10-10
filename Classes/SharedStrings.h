//
//  SharedStrings.h
//  FirstApp
//
//  Created by nishith agarwal on 4/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SharedStrings : NSObject{
    NSString *string;
    NSString *emailaddress;
    NSString *password;
    NSString *nickname;
    NSString *userid;
    
    NSArray *friends;
    NSArray *transactions;
    NSArray *whopaid;
    NSArray *whoowes;
}

+(SharedStrings *)sharedString;

-(void)setString:(NSString *)newString;
-(void)setEmailAddress:(NSString *)newString;
-(void)setPassword:(NSString *)newString;
-(void)setNickname:(NSString *)newString;
-(void)setUserID:(NSString *)newString;
-(void)setFriends:(NSArray *)newString;
-(void)setTransactions:(NSArray *)newString;
-(void)setWhoPaid:(NSMutableArray *)newString;
-(void)setWhoOwes:(NSMutableArray *)newString;

-(NSString *)getString;
-(NSString *)getEmailAddress;
-(NSString *)getPassword;
-(NSString *)getNickname;
-(NSString *)getUserID;
-(NSArray *)getFriends;
-(NSArray *)getTransactions;
-(NSMutableArray *)getWhoPaid;
-(NSMutableArray *)getWhoOwes;

-(BOOL)validateEmail:(NSString *)newString;
-(NSMutableArray *) getFriendsName;
-(NSMutableArray *) getFriendsEmail;
-(NSMutableArray *) getFriendsAmount;
@end