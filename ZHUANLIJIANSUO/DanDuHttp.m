//
//  DanDuHttp.m
//  ZHUANLIJIANSUO
//
//  Created by chenhuiguo on 12-9-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DanDuHttp.h"
#import <CommonCrypto/CommonDigest.h>

@implementation DanDuHttp

@synthesize delegate, OnSoapRespond, OnSoapFail, mArray,webData = webData,mgvertA,mgCateArray,mDIc = mDIc;

- (id)init {
	mConnection = nil;
	self = [super init];
	if (self) {
		mgCateArray = [[NSMutableArray alloc]initWithCapacity:10];
		webData = [[NSMutableData data] retain];
		mArray = [[NSMutableArray alloc]init];
		mgvertA = [[NSMutableArray alloc]init];
		mDataString = [[NSMutableString alloc]init];
		mDIc = [[NSMutableDictionary alloc]init];
	}
	return self;
}

- (void)Cancel {
    if (mConnection) {
		[mConnection cancel];
        [mConnection release];
        mConnection = nil;
    }
}

- (void)dealloc {
	self.mDIc = nil;
    [self Cancel];
    [webData release];
    if (mXmlParse) {
        [mXmlParse release];
    }
	[mgvertA release];
	[mArray release];
	[mDataString release];
	[super dealloc];
}
/////////从服务器请求数据
- (void)PostSoadMessage:(NSDictionary *)serverip :(NSString *)mind :(NSString *)action;
{
	NSURL *url = [NSURL URLWithString:mind];
	NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] initWithURL:url] autorelease];
    [request setHTTPMethod:@"POST"];
	[request  addValue:action forHTTPHeaderField:@"action"];
    [request setTimeoutInterval:8];
    [request addValue: @"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    NSString *sBody = @"";
    for (NSString *key in serverip.allKeys) {
        NSString *value = [serverip objectForKey:key];
        if (sBody.length>0) {
            sBody = [sBody stringByAppendingString:@"&"];
        }
        sBody = [sBody stringByAppendingFormat:@"%@=%@", key, value];
    }
    
    [request setHTTPBody: [sBody dataUsingEncoding:NSUTF8StringEncoding]];
	NSLog(@"22222DanDu22222%@",sBody);
    mConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
	
	//如果连接已经建好，则初始化data121212121
	if(mConnection) {
		webData = [[NSMutableData alloc]initWithLength:0];
	}
	else {
		NSLog(@"theConnection is NULL");
	}
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES; 
}
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
	[webData setLength: 0];
	NSLog(@"connection: didReceiveResponse:1");
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
	[webData appendData:data];
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
//	NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
	NSString *theXML = [[NSString alloc] initWithBytes: [webData mutableBytes] length:[webData length] encoding:NSUTF8StringEncoding];
	NSString *ATihuan = [theXML stringByReplacingOccurrencesOfString:@"&" withString:@"～"];
	NSData *tData = [ATihuan dataUsingEncoding:NSUTF8StringEncoding];
	
	NSLog(@"11DanDu111%@",theXML);
	[theXML release];
	if (mXmlParse) {
		mXmlParse = nil;
	}
	mXmlParse = [[NSXMLParser alloc] initWithData:tData];
	[mXmlParse setDelegate:self];
	[mXmlParse parse];
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

//如果电脑没有连接网络，则出现此信息（不是网络服务器不通）
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
	NSLog(@"ERROR with theConenction");
	[connection release];
    mConnection = nil;
	[self.delegate performSelector:self.OnSoapFail];
	
}
- (void)parserDidStartDocument:(NSXMLParser *)parser {
    [mArray removeAllObjects];
}

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
	if ([elementName isEqualToString:@"Response"]) {
		[mArray addObject:attributeDict];
	}
	else if([elementName isEqualToString:@"Data"])
	{
		[self.mDIc removeAllObjects];
		[self.mDIc addEntriesFromDictionary:attributeDict];
//		[mArray addObject:attributeDict];
	}else if([elementName isEqualToString:@"vertifyinfo"])
	{
		[mgvertA addObject:attributeDict];
	}else if([elementName isEqualToString:@"Category"])
	{
		[mgCateArray addObject:attributeDict];
	}
	
	[mDataString setString:@""];
}
-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
	if([elementName isEqualToString:@"Data"])
	{
		if (self.mDIc.count>0) {
			NSArray *array = [[NSArray alloc]initWithArray:mgvertA];
			[self.mDIc setObject:array forKey:@"nianjian"];
			NSDictionary *aDic = [[NSDictionary alloc]initWithDictionary:self.mDIc];
			[mArray addObject:aDic];
			[mgvertA removeAllObjects];
			[array release];
			[aDic release];
		}
	
	}
	//    
	//	 NSRange range = [elementName rangeOfString:@"return"];
	//	if ((range.length>0)&&(![mDataString isEqualToString:@""])) {
	//		NSLog(@"111111111%@",mDataString);
	//		id array = [mDataString JSONValue];
	//		if (array) {
	//			if ([array isKindOfClass:[NSArray class]]) {
	//				[mArray addObjectsFromArray:array];
	//			}else if([array isKindOfClass:[NSDictionary class]])
	//			{
	//				[mArray addObject:array];
	//			}
	//		}
	//	}
	//}
}
-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
	[mDataString appendString:string];
}
- (void)parserDidEndDocument:(NSXMLParser *)parser 
{
	NSLog(@"%@",mArray);
  	[self.delegate performSelector:self.OnSoapRespond];
}
+ (NSString *)md5:(NSString *)str {
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, strlen(cStr), result );
    return [NSString stringWithFormat:
            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

@end




