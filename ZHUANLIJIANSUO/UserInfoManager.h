//
//  UserInfoManager.h
//  TestLineGraph
//
//  Created by hepburn X on 11-12-6.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfoManager : NSObject {
    NSMutableDictionary *mDict;
    int miBtnIndex;
    
}
@property (nonatomic, assign) NSString *mUserName;
@property (nonatomic, assign) NSString *mPassword;
@property (nonatomic, assign) NSString *mSafePsd;
@property (nonatomic, assign) NSString *mCrmid;
@property (nonatomic,assign) NSString *mAuthid;
@property (nonatomic, assign) NSString *mImageString;
@property (nonatomic, assign) NSString *mPDFurl;
@property (nonatomic, assign) NSString *mButtonTag;

+ (UserInfoManager *)Share;

#define kkUserName [UserInfoManager Share].mUserName
#define kkPassWord [UserInfoManager Share].mPassword
#define kkmobilePhone [UserInfoManager Share].mSafePsd

#define kkemail [UserInfoManager Share].mCrmid
#define kkSessionID [UserInfoManager Share].mAuthid
#define kkImageString [UserInfoManager Share].mImageString
#define kkLinkman [UserInfoManager Share].mPDFurl
#define kkloginName [UserInfoManager Share].mButtonTag
@end
