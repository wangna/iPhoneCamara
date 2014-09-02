//
//  SoapHttpManager.h
//  Test309Hospital
//
//  Created by Hepburn on 11-8-17.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ParamList.h"
#import "MBProgressHUD.h"
@interface SoapHttpManager : NSObject<NSXMLParserDelegate,MBProgressHUDDelegate> {
	NSMutableData *webData;

	BOOL mbSuccess;
    NSURLConnection *mConnection;
	NSXMLParser *mXmlParse;
	NSJSONSerialization *mJSONSerial;
	NSMutableString *mDataString;
	NSMutableArray *mArray;
}
@property(nonatomic,retain)UIView *view;
@property(nonatomic,retain)NSString *jsonStr;
@property (nonatomic, assign) id delegate;
@property (nonatomic, assign) SEL OnSoapRespond;
@property (nonatomic, assign) SEL OnSoapFail;
@property (readonly, assign) NSMutableArray *mArray;
@property (readonly,assign) NSMutableArray *mgvertA;
@property(nonatomic,retain) NSString *mDic;
@property(nonatomic,assign)NSMutableData *webData;
@property (nonatomic,assign)NSMutableArray *mgCateArray;
- (void)PostSoadMessage:(NSDictionary *)serverip :(NSString *)mind :(NSString *)action;
- (void)Cancel;


@end
