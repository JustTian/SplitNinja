//
//  SharedStrings.m
//  FirstApp
//
//  Created by nishith agarwal on 4/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SharedStrings.h"

static SharedStrings *sharedString;

@implementation SharedStrings

-(id)init{
    
    self = [super init];
    string = [NSString new];
    emailaddress = [NSString new];
    password = [NSString new];
    nickname = [NSString new];
    userid = [NSString new];
    friends = [NSArray new];
    transactions = [NSArray new];
    whopaid = [NSArray new];
    whoowes = [NSArray new];
    return self;
}

+(SharedStrings *)sharedString{
    if (!sharedString) {
        sharedString = [[SharedStrings alloc] init];
    }
    return sharedString;
}

-(void)setString:(NSString *)newString{
    string = newString;
}

-(void)setEmailAddress:(NSString *)newString{
    emailaddress = [[NSString alloc] initWithString:newString];
}
-(void)setPassword:(NSString *)newString{
    password = [[NSString alloc] initWithString:newString];
}
-(void)setNickname:(NSString *)newString{
    nickname = [[NSString alloc] initWithString:newString];
}
-(void)setUserID:(NSString *)newString{
    userid = [[NSString alloc] initWithString:newString];
}
-(void)setFriends:(NSArray *)newString{
    friends = [[NSArray alloc] initWithArray:newString];
}
-(void)setTransactions:(NSArray *)newString{
    transactions = [[NSArray alloc] initWithArray:newString];
}
-(void)setWhoPaid:(NSMutableArray *)newString{
    whopaid = [[NSMutableArray alloc] initWithArray:newString];
}
-(void)setWhoOwes:(NSMutableArray *)newString{
    whoowes = [[NSMutableArray alloc] initWithArray:newString];
}

-(NSString *)getString{
    return string;
}
-(NSString *)getEmailAddress{
    return emailaddress;
}
-(NSString *)getPassword{
    return password;
}
-(NSString *)getNickname{
    return nickname;
}
-(NSString *)getUserID{
    return userid;
}
-(NSArray *)getFriends{
    return friends;
}
-(NSArray *)getTransactions{
    return transactions;
}
-(NSMutableArray *)getWhoPaid{
    return whopaid;
}
-(NSMutableArray *)getWhoOwes{
    return whoowes;
}

//Validates Email Address Format
-(BOOL)validateEmail:(NSString *)email {  
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}";   
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];   
    return [emailTest evaluateWithObject:email];  
} 

-(NSMutableArray *) getFriendsName{
    NSString *userID11, *friendname1;
    NSString *myemail = [[SharedStrings sharedString] getEmailAddress];
    NSArray *friendsResult = [[SharedStrings sharedString] getFriends];
    NSMutableArray *key_array = [[NSMutableArray alloc] init];
    int count = [friendsResult count];
    //NSLog(@"FVVC Friends count = %u\n",count);
    
    if (count > 0) {
        for(int i=0;i<count;i++){
            userID11 = [[[friendsResult objectAtIndex:i] objectForKey:@"userID1"] objectForKey:@"username"];
            //userID21 = [[[friendsResult objectAtIndex:i] objectForKey:@"userID2"] objectForKey:@"username"]; 
            
            if ([userID11 isEqualToString:myemail])
                friendname1 = [[[friendsResult objectAtIndex:i] objectForKey:@"userID2"] objectForKey:@"firstname"]; 
            else 
                friendname1 = [[[friendsResult objectAtIndex:i] objectForKey:@"userID1"] objectForKey:@"firstname"]; 
            
            [key_array addObject:[NSString stringWithFormat:@"%@", friendname1]];
            //NSLog(@"FVVC Friends Data= %@",[key_array objectAtIndex:i]);
        }
    }
    
    return key_array;
}

-(NSMutableArray *) getFriendsEmail{
    NSString *userID11, *friendname1;
    NSString *myemail = [[SharedStrings sharedString] getEmailAddress];
    NSArray *friendsResult = [[SharedStrings sharedString] getFriends];
    NSMutableArray *key_array = [[NSMutableArray alloc] init];
    int count = [friendsResult count];
    //NSLog(@"FVVC Friends count = %u\n",count);
    
    if (count > 0) {
        for(int i=0;i<count;i++){
            userID11 = [[[friendsResult objectAtIndex:i] objectForKey:@"userID1"] objectForKey:@"username"];
            //userID21 = [[[friendsResult objectAtIndex:i] objectForKey:@"userID2"] objectForKey:@"username"]; 
            
            if ([userID11 isEqualToString:myemail])
                friendname1 = [[[friendsResult objectAtIndex:i] objectForKey:@"userID2"] objectForKey:@"username"]; 
            else 
                friendname1 = [[[friendsResult objectAtIndex:i] objectForKey:@"userID1"] objectForKey:@"username"]; 
            
            [key_array addObject:[NSString stringWithFormat:@"%@", friendname1]];
            //NSLog(@"FVVC Friends Data= %@",[key_array objectAtIndex:i]);
        }
    }
    
    return key_array;
}

-(NSMutableArray *) getFriendsAmount{

    NSString *amount1;
    NSString *userID11;
    NSArray *friendsResult = [[SharedStrings sharedString] getFriends];
    NSString *myemail = [[SharedStrings sharedString] getEmailAddress];
    NSMutableArray *key_array1 = [[NSMutableArray alloc] init];
    int count = [friendsResult count];
    NSLog(@"FVVC Friends count = %u\n",count);
    
    if (count > 0) {
        for(int i=0;i<count;i++){
            userID11 = [[[friendsResult objectAtIndex:i] objectForKey:@"userID1"] objectForKey:@"username"];
            //userID21 = [[[friendsResult objectAtIndex:i] objectForKey:@"userID2"] objectForKey:@"username"]; 
            float amountf = [[[friendsResult objectAtIndex:i] objectForKey:@"amount"] floatValue];
            
            if ([userID11 isEqualToString:myemail]){
                    
                float amountf = [[[friendsResult objectAtIndex:i] objectForKey:@"amount"] floatValue];
                //NSLog(@"FVVC Friends  Float= %f",amountf);
                amount1 = [NSString stringWithFormat:@"%.02f", amountf];
                //NSLog(@"FVVC Friends Data= %@",amount1);
            }
            else
            {
                amount1 = [NSString stringWithFormat:@"%.02f", ((-1) * amountf)];
                //NSLog(@"FVVC Friends Data= %@",amount1);
            }
            [key_array1 addObject:[NSString stringWithFormat:@"%@", amount1]];
            //NSLog(@"FVVC Friends Data= %@",[key_array1 objectAtIndex:i]);
        }
    }
    return key_array1;
}

@end