//
//  DetailTitleCell.m
//  ZHUANLIJIANSUO
//
//  Created by chenhuiguo on 12-9-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DetailTitleCell.h"

@implementation DetailTitleCell
@synthesize gTitle,gScore,ifLiang;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
		UIImageView *gtImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 10, 15, 15)];
		self.ifLiang = gtImage;
		[self addSubview:self.ifLiang];
		[gtImage release];
    }
    return self;
}
-(void)gAddTitleLabel
{
	
	NSString *gtShangBiao = [self.gTitle stringByReplacingOccurrencesOfString:@"～lt;SUB～gt;" withString:@""];
	NSString *gtXiaBiao = [gtShangBiao stringByReplacingOccurrencesOfString:@"～lt;/SUB～gt;" withString:@""];
	NSString *gClearColor = [gtXiaBiao stringByReplacingOccurrencesOfString:@"～lt;font color=red～gt;" withString:@""];
	NSString *sizeString = [gClearColor stringByReplacingOccurrencesOfString:@"～lt;/font～gt;" withString:@""];
	
	CGSize size = [sizeString sizeWithFont:[UIFont systemFontOfSize:16.4] constrainedToSize:CGSizeMake(275, 1000) lineBreakMode:NSLineBreakByCharWrapping];
	if (size.height<=21) {
		size.height = 30;
	}else if (size.height>21&&size.height<43) {
		size.height = 60;
	}else if (size.height>42&&size.height<64) {
		size.height = 80;
	}else if (size.height>63) {
		size.height=105;
	}
	
	
	NSString *tAhuanSan = [self.gTitle stringByReplacingOccurrencesOfString:@"～lt;" withString:@"<"];
	NSString *tAzaihua2 = [[[[tAhuanSan stringByReplacingOccurrencesOfString:@"～gt;" withString:@">"]stringByReplacingOccurrencesOfString:@"～quot;" withString:@"\""]stringByReplacingOccurrencesOfString:@"～amp;amp;" withString:@"&"]stringByReplacingOccurrencesOfString:@"～amp;" withString:@"&"];
    NSString *tAzaihua=[tAzaihua2 stringByReplacingOccurrencesOfString:@"size='18px'" withString:@"size='3px'"];
	NSString *htmlString = [@"<html><body bgcolor=\"#ecf6fb\"><p><font size=\"3px\"><font color=YellowGreen>" stringByAppendingFormat:@"%@%@",tAzaihua,@"</font></font></p></body></html>"];
    NSLog(@"String++%@",htmlString);
	UIWebView *GNameLabel = [[UIWebView alloc]initWithFrame:CGRectMake(15, 0, 300, size.height)];
	GNameLabel.backgroundColor = Main_Color;
	GNameLabel.delegate = self;
	[GNameLabel loadHTMLString:htmlString baseURL:nil];
	[self addSubview:GNameLabel];
	[GNameLabel release];
	
	tView = [[UIView alloc]initWithFrame:GNameLabel.frame];
	tView.backgroundColor = Main_Color;
	[self addSubview:tView];
	[tView release];

	
//	NSString *gtShangBiao = [self.gTitle stringByReplacingOccurrencesOfString:@"～lt;SUB～gt;" withString:@""];
//	NSString *gtXiaBiao = [gtShangBiao stringByReplacingOccurrencesOfString:@"～lt;/SUB～gt;" withString:@""];
//	UILabel *GNameLabel = [[UILabel alloc]init];
//	GNameLabel.backgroundColor = [UIColor clearColor];
//	CGSize size = [gtXiaBiao sizeWithFont:[UIFont systemFontOfSize:14.0] constrainedToSize:CGSizeMake(290, 1000) lineBreakMode:NSLineBreakByCharWrapping];
//	if (size.height<20) {
//		size.height = 20;
//	}
//	GNameLabel.frame = CGRectMake(15, 2, size.width, size.height);
//	GNameLabel.text = gtXiaBiao;
//	GNameLabel.numberOfLines = 0;
//	GNameLabel.font = [UIFont systemFontOfSize:14.0];
//	GNameLabel.textColor = Text_Color_Green;	
//	[self addSubview:GNameLabel];
//	[GNameLabel release];
//	
	for (int i=0; i<3; i++) {
		UIImageView *gtImage = [[UIImageView alloc]initWithFrame:CGRectMake(3+i*10, GNameLabel.frame.size.height+1, 10, 10)];
		if (self.gScore>=i+1) {
			gtImage.image = [UIImage imageNamed:@"quan.png"];
		}else if (self.gScore>=i+0.5) {
			gtImage.image = [UIImage imageNamed:@"ban.png"];
		}else {
			gtImage.image = [UIImage imageNamed:@"wuL.png"];
		}
		[self addSubview:gtImage];
		[gtImage release];
	}
	

}
-(void)addviewwithFrame:(CGRect)frame
{
	
}
-(void)webViewDidFinishLoad:(UIWebView *)webView{
	tView.backgroundColor = [UIColor clearColor];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)dealloc
{
	self.gTitle = nil;
	self.ifLiang = nil;
	[super dealloc];
}

@end
