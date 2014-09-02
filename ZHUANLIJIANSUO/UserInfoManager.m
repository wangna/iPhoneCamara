//
//  UserInfoManager.m
//  TestLineGraph
//
//  Created by hepburn X on 11-12-6.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "UserInfoManager.h"

static UserInfoManager *gUserManager = nil;

@implementation UserInfoManager 

@synthesize mUserName, mPassword, mSafePsd;
@synthesize mCrmid,mAuthid,mImageString,mPDFurl,mButtonTag;

+ (UserInfoManager *)Share {
    if (!gUserManager) {
        gUserManager = [[UserInfoManager alloc] init];
    }
    return gUserManager;
}

- (id)init {
    self = [super init];
    if (self) {
        mDict = [[NSMutableDictionary alloc] init];
        miBtnIndex = -1;
        
      
        
//        NSOperationQueue *tempQueue=[[NSOperationQueue alloc] init];
//        [tempQueue setMaxConcurrentOperationCount:1];
//        self.mQueue=tempQueue;
//        [tempQueue release];        
    }
    return self;
}

- (void)dealloc {
//    [mQueue cancelAllOperations];
//    [mQueue release];
    [mDict release];
    [super dealloc];
}
- (NSString *)mButtonTag{
    NSString *str = [mDict objectForKey:@"BTTag"];
    return (!str)?@"":str;
}
- (NSString *)mPDFurl{
    NSString *str = [mDict objectForKey:@"Pdfurl"];
    return (!str)?@"":str;
}
- (NSString *)mAuthid{
    NSString *str = [mDict objectForKey:@"authid"];
    return (!str)?@"":str;
}
- (NSString *)mUserName {
    NSString *str = [mDict objectForKey:@"username"];
    return (!str)?@"":str;
}

- (NSString *)mPassword {
    NSString *str = [mDict objectForKey:@"password"];
    return (!str)?@"":str;
}

- (NSString *)mSafePsd {
    NSString *str = [mDict objectForKey:@"safePsd"];
    return (!str)?@"":str;
}
- (NSString *)mCrmid {
	NSString *str = [mDict objectForKey:@"crmid"];
	return (!str)?@"":str;
}
- (NSString *)mImageString{
    NSString *str = [mDict objectForKey:@"imageString"];
	return (!str)?@"":str;

}
//////////set
- (void)setMButtonTag:(NSString *)value{
    [mDict setObject:value forKey:@"BTTag"];
	
}

- (void)setMPDFurl:(NSString *)value{
    [mDict setObject:value forKey:@"Pdfurl"];

}
-(void)setMAuthid:(NSString *)value{
    [mDict setObject:value forKey:@"authid"];
}
- (void)setMUserName:(NSString *)value {
    [mDict setObject:value forKey:@"username"];
	
}

- (void)setMPassword:(NSString *)value {
    [mDict setObject:value forKey:@"password"];
}

- (void)setMSafePsd:(NSString *)value {
    [mDict setObject:value forKey:@"safePsd"];
}
- (void)setMCrmid:(NSString *)value{
	[mDict setObject:value forKey:@"crmid"];
}
- (void)setMImageString:(NSString *)value{
    [mDict setObject:value forKey:@"imageString"];
}
@end
