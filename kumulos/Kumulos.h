//
//  Kumulos.h
//  Kumulos
//
//  Created by Kumulos Bindings Compiler on May  9, 2012
//  Copyright ioweyou All rights reserved.
//

#import <Foundation/Foundation.h>
#import "libKumulos.h"


@class Kumulos;
@protocol KumulosDelegate <kumulosProxyDelegate>
@optional

 
- (void) kumulosAPI:(Kumulos*)kumulos apiOperation:(KSAPIOperation*)operation addFriendDidCompleteWithResult:(NSNumber*)newRecordID;
 
- (void) kumulosAPI:(Kumulos*)kumulos apiOperation:(KSAPIOperation*)operation deleteFriendDidCompleteWithResult:(NSNumber*)affectedRows;
 
- (void) kumulosAPI:(Kumulos*)kumulos apiOperation:(KSAPIOperation*)operation getFriendsDidCompleteWithResult:(NSArray*)theResults;
 
- (void) kumulosAPI:(Kumulos*)kumulos apiOperation:(KSAPIOperation*)operation addTransactionDidCompleteWithResult:(NSNumber*)newRecordID;
 
- (void) kumulosAPI:(Kumulos*)kumulos apiOperation:(KSAPIOperation*)operation getOwedTransactionDidCompleteWithResult:(NSArray*)theResults;
 
- (void) kumulosAPI:(Kumulos*)kumulos apiOperation:(KSAPIOperation*)operation getPaidTransactionsDidCompleteWithResult:(NSArray*)theResults;
 
- (void) kumulosAPI:(Kumulos*)kumulos apiOperation:(KSAPIOperation*)operation getTransactionsDidCompleteWithResult:(NSArray*)theResults;
 
- (void) kumulosAPI:(Kumulos*)kumulos apiOperation:(KSAPIOperation*)operation createNewUserDidCompleteWithResult:(NSNumber*)newRecordID;
 
- (void) kumulosAPI:(Kumulos*)kumulos apiOperation:(KSAPIOperation*)operation getUserDidCompleteWithResult:(NSArray*)theResults;
 
- (void) kumulosAPI:(Kumulos*)kumulos apiOperation:(KSAPIOperation*)operation updateUserDidCompleteWithResult:(NSNumber*)affectedRows;
 
- (void) kumulosAPI:(Kumulos*)kumulos apiOperation:(KSAPIOperation*)operation userLoginDidCompleteWithResult:(NSArray*)theResults;

@end

@interface Kumulos : kumulosProxy {
    NSString* theAPIKey;
    NSString* theSecretKey;
}

-(Kumulos*)init;
-(Kumulos*)initWithAPIKey:(NSString*)APIKey andSecretKey:(NSString*)secretKey;

   
-(KSAPIOperation*) addFriendWithUserID1:(NSUInteger)userID1 andAmount:(float)amount andUserID2:(NSUInteger)userID2 andFriendID:(NSUInteger)friendID;
    
   
-(KSAPIOperation*) deleteFriendWithUserID2:(NSUInteger)userID2 andUserID1:(NSUInteger)userID1;
    
   
-(KSAPIOperation*) getFriendsWithUserID1:(NSUInteger)userID1;
    
   
-(KSAPIOperation*) addTransactionWithDescription:(NSString*)description andAmount:(float)amount andId:(NSInteger)id andPaidby:(NSUInteger)paidby andOwedBy:(NSUInteger)owedBy;
    
   
-(KSAPIOperation*) getOwedTransactionWithOwedBy:(NSUInteger)owedBy;
    
   
-(KSAPIOperation*) getPaidTransactionsWithPaidby:(NSUInteger)paidby;
    
   
-(KSAPIOperation*) getTransactionsWithPaidby:(NSUInteger)paidby andOwedBy:(NSUInteger)owedBy;
    
   
-(KSAPIOperation*) createNewUserWithUsername:(NSString*)username andPassword:(NSString*)password andFirstname:(NSString*)firstname andLastname:(NSString*)lastname andFlag:(BOOL)flag;
    
   
-(KSAPIOperation*) getUserWithUsername:(NSString*)username;
    
   
-(KSAPIOperation*) updateUserWithUsername:(NSString*)username andPassword:(NSString*)password andFirstname:(NSString*)firstname andLastname:(NSString*)lastname andFlag:(BOOL)flag;
    
   
-(KSAPIOperation*) userLoginWithUsername:(NSString*)username andPassword:(NSString*)password andFlag:(BOOL)flag;
    
            
@end