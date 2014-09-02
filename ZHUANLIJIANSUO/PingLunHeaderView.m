//
//  PingLunHeaderView.m
//  ZHUANLIJIANSUO
//
//  Created by chenhuiguo on 12-8-30.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "PingLunHeaderView.h"

@implementation PingLunHeaderView
@synthesize GcontentDic;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
       self.backgroundColor = Main_Color;
    }
    return self;
}
-(void)CellAddTextLabel
{
    NSString *aString = [self.GcontentDic objectForKey:@"name"];
	
	
	NSString *tAhuanSan = [aString stringByReplacingOccurrencesOfString:@"～lt;" withString:@"<"];
	NSString *tAzaihua2 = [tAhuanSan stringByReplacingOccurrencesOfString:@"～gt;" withString:@">"];
    NSString *tAzaihua=[tAzaihua2 stringByReplacingOccurrencesOfString:@"size='18px'" withString:@"size='3px'"];
    NSString *str=[aString stringByReplacingOccurrencesOfString:@"～lt;font color=#CCbb33 size='18px'～gt;" withString:@""];
    NSString *str1=[str stringByReplacingOccurrencesOfString:@"～lt;font color=#66CC33 size='18px'～gt;" withString:@""];
    NSString *str2=[str1 stringByReplacingOccurrencesOfString:@"～lt;font color=#cccccc size='18px'～gt;" withString:@""];
    NSString *strTitle=[str2 stringByReplacingOccurrencesOfString:@"～lt;/font～gt;" withString:@""];
    NSLog(@"string+++%@",strTitle);
    CGSize size = [strTitle sizeWithFont:[UIFont systemFontOfSize:16] constrainedToSize:CGSizeMake(320, 1000) lineBreakMode:NSLineBreakByCharWrapping];
	NSString *htmlString = [@"<html><body bgcolor=\"#ecf6fb\"><p><font size=\"3px\"><font color=YellowGreen>" stringByAppendingFormat:@"%@%@",tAzaihua,@"</font></font></p></body></html>"];
    NSLog(@"String++%@",htmlString);
	UIWebView *GNameLabel = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, 320, size.height+10)];
	GNameLabel.backgroundColor = Main_Color;
	GNameLabel.delegate = self;
	[GNameLabel loadHTMLString:htmlString baseURL:nil];
	[self addSubview:GNameLabel];
	[GNameLabel release];

//    
//	UILabel *GNameLabel = [[UILabel alloc]init];
//	GNameLabel.backgroundColor = [UIColor clearColor];
//	NSString *aString = [self.GcontentDic objectForKey:@"name"];
//	CGSize size = [aString sizeWithFont:[UIFont systemFontOfSize:15.0] constrainedToSize:CGSizeMake(320, 1000) lineBreakMode:NSLineBreakByCharWrapping];
//	if (size.height<20) {
//		size.height = 20;
//	}
//	GNameLabel.frame = CGRectMake(5, 2, 310, size.height);
//    NSLog(@"aString++%@",aString);
//    NSString *str=[aString stringByReplacingOccurrencesOfString:@"～lt;font color=#CCbb33 size='18px'～gt;" withString:@""];
//    NSString *strTitle=[str stringByReplacingOccurrencesOfString:@"～lt;/font～gt;" withString:@""];
//	GNameLabel.text = strTitle;
//	GNameLabel.font = [UIFont systemFontOfSize:15.0];
//	GNameLabel.textColor = Text_Color_Green;	
//	[self addSubview:GNameLabel];
//	[GNameLabel release];
	CGFloat aValue = [[self.GcontentDic objectForKey:@"Score"]floatValue];
    NSLog(@"777--%f",GNameLabel.frame.size.height);
	for (int i=0; i<3; i++) {
		UIImageView *gtImage = [[UIImageView alloc]initWithFrame:CGRectMake(10+i*10, size.height+10, 10, 10)];
		if (aValue>=i+1) {
			gtImage.image = [UIImage imageNamed:@"quan.png"];
		}else if (aValue>=i+0.5) {
			gtImage.image = [UIImage imageNamed:@"ban.png"];
		}else {
			gtImage.image = [UIImage imageNamed:@"wuL.png"];
		}
		[self addSubview:gtImage];
		[gtImage release];
	}
}
	
@end
