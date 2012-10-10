//
//  Kumulos.m
//  Kumulos
//
//  Created by Kumulos Bindings Compiler on May  9, 2012
//  Copyright ioweyou All rights reserved.
//

#import "Kumulos.h"

@implementation Kumulos

-(Kumulos*)init {

    if ([super init]) {
        theAPIKey = @"8y3b73ds06hxw62zdk3tq9pjfr9k9cxw";
        theSecretKey = @"qwbmzyq6";
        useSSL = NO;
    }

    return self;
}

-(Kumulos*)initWithAPIKey:(NSString*)APIKey andSecretKey:(NSString*)secretKey{
    if([super init]){
        theAPIKey = [APIKey copy];
        theSecretKey = [secretKey copy];
    }
    return self;
 }


-(KSAPIOperation*) addFriendWithUserID1:(NSUInteger)userID1 andAmount:(float)amount andUserID2:(NSUInteger)userID2 andFriendID:(NSUInteger)friendID{

    
     NSMutableDictionary* theParams = [[NSMutableDictionary alloc]init];
            [theParams setValue:[NSNumber numberWithInt:userID1] forKey:@"userID1"];
                    [theParams setValue:[NSNumber numberWithFloat:amount] forKey:@"amount"];
                    [theParams setValue:[NSNumber numberWithInt:userID2] forKey:@"userID2"];
                    [theParams setValue:[NSNumber numberWithInt:friendID] forKey:@"friendID"];
                        
    KSAPIOperation* newOp = [[KSAPIOperation alloc]initWithAPIKey:theAPIKey andSecretKey:theSecretKey andMethodName:@"addFriend" andParams:theParams];
    [newOp setDelegate:self];
    [newOp setUseSSL:useSSL];
            
    //we pass the method signature for the kumulosProxy callback on this thread
 
    [newOp setCallbackSelector:@selector( kumulosAPI: apiOperation: addFriendDidCompleteWithResult:)];
    [newOp setSuccessCallbackMethodSignature:[self methodSignatureForSelector:@selector(apiOperation: didCompleteWithResult:)]];
    [newOp setErrorCallbackMethodSignature:[self methodSignatureForSelector:@selector(apiOperation: didFailWithError:)]];
    [opQueue addOperation:newOp];
 
    return newOp;
    
}

-(KSAPIOperation*) deleteFriendWithUserID2:(NSUInteger)userID2 andUserID1:(NSUInteger)userID1{

    
     NSMutableDictionary* theParams = [[NSMutableDictionary alloc]init];
            [theParams setValue:[NSNumber numberWithInt:userID2] forKey:@"userID2"];
                    [theParams setValue:[NSNumber numberWithInt:userID1] forKey:@"userID1"];
                        
    KSAPIOperation* newOp = [[KSAPIOperation alloc]initWithAPIKey:theAPIKey andSecretKey:theSecretKey andMethodName:@"deleteFriend" andParams:theParams];
    [newOp setDelegate:self];
    [newOp setUseSSL:useSSL];
            
    //we pass the method signature for the kumulosProxy callback on this thread
 
    [newOp setCallbackSelector:@selector( kumulosAPI: apiOperation: deleteFriendDidCompleteWithResult:)];
    [newOp setSuccessCallbackMethodSignature:[self methodSignatureForSelector:@selector(apiOperation: didCompleteWithResult:)]];
    [newOp setErrorCallbackMethodSignature:[self methodSignatureForSelector:@selector(apiOperation: didFailWithError:)]];
    [opQueue addOperation:newOp];
 
    return newOp;
    
}

-(KSAPIOperation*) getFriendsWithUserID1:(NSUInteger)userID1{

    
     NSMutableDictionary* theParams = [[NSMutableDictionary alloc]init];
            [theParams setValue:[NSNumber numberWithInt:userID1] forKey:@"userID1"];
                        
    KSAPIOperation* newOp = [[KSAPIOperation alloc]initWithAPIKey:theAPIKey andSecretKey:theSecretKey andMethodName:@"getFriends" andParams:theParams];
    [newOp setDelegate:self];
    [newOp setUseSSL:useSSL];
            
    //we pass the method signature for the kumulosProxy callback on this thread
 
    [newOp setCallbackSelector:@selector( kumulosAPI: apiOperation: getFriendsDidCompleteWithResult:)];
    [newOp setSuccessCallbackMethodSignature:[self methodSignatureForSelector:@selector(apiOperation: didCompleteWithResult:)]];
    [newOp setErrorCallbackMethodSignature:[self methodSignatureForSelector:@selector(apiOperation: didFailWithError:)]];
    [opQueue addOperation:newOp];
 
    return newOp;
    
}

-(KSAPIOperation*) addTransactionWithDescription:(NSString*)description andAmount:(float)amount andId:(NSInteger)id andPaidby:(NSUInteger)paidby andOwedBy:(NSUInteger)owedBy{

    
     NSMutableDictionary* theParams = [[NSMutableDictionary alloc]init];
            [theParams setValue:description forKey:@"description"];
                    [theParams setValue:[NSNumber numberWithFloat:amount] forKey:@"amount"];
                    [theParams setValue:[NSNumber numberWithInt:id] forKey:@"id"];
                    [theParams setValue:[NSNumber numberWithInt:paidby] forKey:@"paidby"];
                    [theParams setValue:[NSNumber numberWithInt:owedBy] forKey:@"owedBy"];
                        
    KSAPIOperation* newOp = [[KSAPIOperation alloc]initWithAPIKey:theAPIKey andSecretKey:theSecretKey andMethodName:@"addTransaction" andParams:theParams];
    [newOp setDelegate:self];
    [newOp setUseSSL:useSSL];
            
    //we pass the method signature for the kumulosProxy callback on this thread
 
    [newOp setCallbackSelector:@selector( kumulosAPI: apiOperation: addTransactionDidCompleteWithResult:)];
    [newOp setSuccessCallbackMethodSignature:[self methodSignatureForSelector:@selector(apiOperation: didCompleteWithResult:)]];
    [newOp setErrorCallbackMethodSignature:[self methodSignatureForSelector:@selector(apiOperation: didFailWithError:)]];
    [opQueue addOperation:newOp];
 
    return newOp;
    
}

-(KSAPIOperation*) getOwedTransactionWithOwedBy:(NSUInteger)owedBy{

    
     NSMutableDictionary* theParams = [[NSMutableDictionary alloc]init];
            [theParams setValue:[NSNumber numberWithInt:owedBy] forKey:@"owedBy"];
                        
    KSAPIOperation* newOp = [[KSAPIOperation alloc]initWithAPIKey:theAPIKey andSecretKey:theSecretKey andMethodName:@"getOwedTransaction" andParams:theParams];
    [newOp setDelegate:self];
    [newOp setUseSSL:useSSL];
            
    //we pass the method signature for the kumulosProxy callback on this thread
 
    [newOp setCallbackSelector:@selector( kumulosAPI: apiOperation: getOwedTransactionDidCompleteWithResult:)];
    [newOp setSuccessCallbackMethodSignature:[self methodSignatureForSelector:@selector(apiOperation: didCompleteWithResult:)]];
    [newOp setErrorCallbackMethodSignature:[self methodSignatureForSelector:@selector(apiOperation: didFailWithError:)]];
    [opQueue addOperation:newOp];
 
    return newOp;
    
}

-(KSAPIOperation*) getPaidTransactionsWithPaidby:(NSUInteger)paidby{

    
     NSMutableDictionary* theParams = [[NSMutableDictionary alloc]init];
            [theParams setValue:[NSNumber numberWithInt:paidby] forKey:@"paidby"];
                        
    KSAPIOperation* newOp = [[KSAPIOperation alloc]initWithAPIKey:theAPIKey andSecretKey:theSecretKey andMethodName:@"getPaidTransactions" andParams:theParams];
    [newOp setDelegate:self];
    [newOp setUseSSL:useSSL];
            
    //we pass the method signature for the kumulosProxy callback on this thread
 
    [newOp setCallbackSelector:@selector( kumulosAPI: apiOperation: getPaidTransactionsDidCompleteWithResult:)];
    [newOp setSuccessCallbackMethodSignature:[self methodSignatureForSelector:@selector(apiOperation: didCompleteWithResult:)]];
    [newOp setErrorCallbackMethodSignature:[self methodSignatureForSelector:@selector(apiOperation: didFailWithError:)]];
    [opQueue addOperation:newOp];
 
    return newOp;
    
}

-(KSAPIOperation*) getTransactionsWithPaidby:(NSUInteger)paidby andOwedBy:(NSUInteger)owedBy{

    
     NSMutableDictionary* theParams = [[NSMutableDictionary alloc]init];
            [theParams setValue:[NSNumber numberWithInt:paidby] forKey:@"paidby"];
                    [theParams setValue:[NSNumber numberWithInt:owedBy] forKey:@"owedBy"];
                        
    KSAPIOperation* newOp = [[KSAPIOperation alloc]initWithAPIKey:theAPIKey andSecretKey:theSecretKey andMethodName:@"getTransactions" andParams:theParams];
    [newOp setDelegate:self];
    [newOp setUseSSL:useSSL];
            
    //we pass the method signature for the kumulosProxy callback on this thread
 
    [newOp setCallbackSelector:@selector( kumulosAPI: apiOperation: getTransactionsDidCompleteWithResult:)];
    [newOp setSuccessCallbackMethodSignature:[self methodSignatureForSelector:@selector(apiOperation: didCompleteWithResult:)]];
    [newOp setErrorCallbackMethodSignature:[self methodSignatureForSelector:@selector(apiOperation: didFailWithError:)]];
    [opQueue addOperation:newOp];
 
    return newOp;
    
}

-(KSAPIOperation*) createNewUserWithUsername:(NSString*)username andPassword:(NSString*)password andFirstname:(NSString*)firstname andLastname:(NSString*)lastname andFlag:(BOOL)flag{

    
     NSMutableDictionary* theParams = [[NSMutableDictionary alloc]init];
            [theParams setValue:username forKey:@"username"];
                    [theParams setValue:password forKey:@"password"];
                    [theParams setValue:firstname forKey:@"firstname"];
                    [theParams setValue:lastname forKey:@"lastname"];
                    [theParams setValue:[NSNumber numberWithBool:flag] forKey:@"flag"];
                        
    KSAPIOperation* newOp = [[KSAPIOperation alloc]initWithAPIKey:theAPIKey andSecretKey:theSecretKey andMethodName:@"createNewUser" andParams:theParams];
    [newOp setDelegate:self];
    [newOp setUseSSL:useSSL];
            
    //we pass the method signature for the kumulosProxy callback on this thread
 
    [newOp setCallbackSelector:@selector( kumulosAPI: apiOperation: createNewUserDidCompleteWithResult:)];
    [newOp setSuccessCallbackMethodSignature:[self methodSignatureForSelector:@selector(apiOperation: didCompleteWithResult:)]];
    [newOp setErrorCallbackMethodSignature:[self methodSignatureForSelector:@selector(apiOperation: didFailWithError:)]];
    [opQueue addOperation:newOp];
 
    return newOp;
    
}

-(KSAPIOperation*) getUserWithUsername:(NSString*)username{

    
     NSMutableDictionary* theParams = [[NSMutableDictionary alloc]init];
            [theParams setValue:username forKey:@"username"];
                        
    KSAPIOperation* newOp = [[KSAPIOperation alloc]initWithAPIKey:theAPIKey andSecretKey:theSecretKey andMethodName:@"getUser" andParams:theParams];
    [newOp setDelegate:self];
    [newOp setUseSSL:useSSL];
            
    //we pass the method signature for the kumulosProxy callback on this thread
 
    [newOp setCallbackSelector:@selector( kumulosAPI: apiOperation: getUserDidCompleteWithResult:)];
    [newOp setSuccessCallbackMethodSignature:[self methodSignatureForSelector:@selector(apiOperation: didCompleteWithResult:)]];
    [newOp setErrorCallbackMethodSignature:[self methodSignatureForSelector:@selector(apiOperation: didFailWithError:)]];
    [opQueue addOperation:newOp];
 
    return newOp;
    
}

-(KSAPIOperation*) updateUserWithUsername:(NSString*)username andPassword:(NSString*)password andFirstname:(NSString*)firstname andLastname:(NSString*)lastname andFlag:(BOOL)flag{

    
     NSMutableDictionary* theParams = [[NSMutableDictionary alloc]init];
            [theParams setValue:username forKey:@"username"];
                    [theParams setValue:password forKey:@"password"];
                    [theParams setValue:firstname forKey:@"firstname"];
                    [theParams setValue:lastname forKey:@"lastname"];
                    [theParams setValue:[NSNumber numberWithBool:flag] forKey:@"flag"];
                        
    KSAPIOperation* newOp = [[KSAPIOperation alloc]initWithAPIKey:theAPIKey andSecretKey:theSecretKey andMethodName:@"updateUser" andParams:theParams];
    [newOp setDelegate:self];
    [newOp setUseSSL:useSSL];
            
    //we pass the method signature for the kumulosProxy callback on this thread
 
    [newOp setCallbackSelector:@selector( kumulosAPI: apiOperation: updateUserDidCompleteWithResult:)];
    [newOp setSuccessCallbackMethodSignature:[self methodSignatureForSelector:@selector(apiOperation: didCompleteWithResult:)]];
    [newOp setErrorCallbackMethodSignature:[self methodSignatureForSelector:@selector(apiOperation: didFailWithError:)]];
    [opQueue addOperation:newOp];
 
    return newOp;
    
}

-(KSAPIOperation*) userLoginWithUsername:(NSString*)username andPassword:(NSString*)password andFlag:(BOOL)flag{

    
     NSMutableDictionary* theParams = [[NSMutableDictionary alloc]init];
            [theParams setValue:username forKey:@"username"];
                    [theParams setValue:password forKey:@"password"];
                    [theParams setValue:[NSNumber numberWithBool:flag] forKey:@"flag"];
                        
    KSAPIOperation* newOp = [[KSAPIOperation alloc]initWithAPIKey:theAPIKey andSecretKey:theSecretKey andMethodName:@"userLogin" andParams:theParams];
    [newOp setDelegate:self];
    [newOp setUseSSL:useSSL];
            
    //we pass the method signature for the kumulosProxy callback on this thread
 
    [newOp setCallbackSelector:@selector( kumulosAPI: apiOperation: userLoginDidCompleteWithResult:)];
    [newOp setSuccessCallbackMethodSignature:[self methodSignatureForSelector:@selector(apiOperation: didCompleteWithResult:)]];
    [newOp setErrorCallbackMethodSignature:[self methodSignatureForSelector:@selector(apiOperation: didFailWithError:)]];
    [opQueue addOperation:newOp];
 
    return newOp;
    
}

@end