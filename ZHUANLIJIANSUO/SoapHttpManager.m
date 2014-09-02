
//
//  SoapHttpManager.m
//  Test309Hospital
//
//  Created by Hepburn on 11-8-17.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SoapHttpManager.h"
#import <CommonCrypto/CommonDigest.h>
#import "JSON.h"
 
@implementation SoapHttpManager

@synthesize delegate, OnSoapRespond, OnSoapFail, mArray,mDic,webData = webData,mgvertA,mgCateArray,jsonStr,view;

- (id)init {
	mConnection = nil;
	self = [super init];
	if (self) {
		mgCateArray = [[NSMutableArray alloc]initWithCapacity:10];
		webData = [[NSMutableData data] retain];
		mArray = [[NSMutableArray alloc]init];
		mgvertA = [[NSMutableArray alloc]init];
		mDataString = [[NSMutableString alloc]init];
		self.mDic = @"随便";
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
	self.mDic = nil;
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
//    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    [request setHTTPBody: [sBody dataUsingEncoding:NSUTF8StringEncoding]];
	NSLog(@"sBody2222222222%@",sBody);
    NSLog(@"mind121212121%@",mind);
    mConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
		
	//如果连接已经建好，则初始化data
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
	jsonStr=theXML;
    if ([jsonStr isEqualToString:@""]) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        MBProgressHUD *hud=[[MBProgressHUD alloc]initWithView:self.view];
        [self.view addSubview:hud];
        hud.mode=MBProgressHUDModeText;
        hud.labelText=NSLocalizedString(@"没有查询结果", nil);
        [hud show:YES];
        [hud hide:YES afterDelay:1];
        [hud release];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"GUANZHU" object:nil];
    }
	NSLog(@"theXML1111155555%@",theXML);
    if ([theXML isEqualToString:@"Controller does not exist"]) {
        mArray=nil;
        return;
    }
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
		[mArray addObject:attributeDict];
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
- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError
{
    if ([jsonStr isEqualToString:@""]||[self.view.class isSubclassOfClass:UIWindow.class]||[self.view.class isSubclassOfClass:UITableViewCell.class]) {
        
        
    }
    else{
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        MBProgressHUD *hud=[[MBProgressHUD alloc]initWithView:self.view];
        [self.view addSubview:hud];
        hud.mode=MBProgressHUDModeText;
        hud.labelText=NSLocalizedString(@"数据错误", nil);
        [hud show:YES];
        [hud hide:YES afterDelay:1];
        [hud release];
        NSLog(@"解析错误");
    }
}
@end

