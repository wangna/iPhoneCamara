//
//  DanDuHttp.h
//  ZHUANLIJIANSUO
//
//  Created by chenhuiguo on 12-9-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DanDuParamlist.h"

@interface DanDuHttp : NSObject<NSXMLParserDelegate> {
	NSMutableData *webData;
	
	BOOL mbSuccess;
    NSURLConnection *mConnection;
	NSXMLParser *mXmlParse;
	NSJSONSerialization *mJSONSerial;
	NSMutableString *mDataString;
	NSMutableArray *mArray;
	NSMutableDictionary *mDIc;
}

@property (nonatomic, assign) id delegate;
@property (nonatomic, assign) SEL OnSoapRespond;
@property (nonatomic, assign) SEL OnSoapFail;
@property (readonly, assign) NSMutableArray *mArray;
@property (readonly,assign) NSMutableArray *mgvertA;
@property(nonatomic,assign)NSMutableData *webData;
@property (nonatomic,assign)NSMutableArray *mgCateArray;
@property(nonatomic,assign)NSMutableDictionary *mDIc;
- (void)PostSoadMessage:(NSDictionary *)serverip :(NSString *)mind :(NSString *)action;
- (void)Cancel;


@end


