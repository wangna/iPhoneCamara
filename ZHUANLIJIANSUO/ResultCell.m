//
//  ResultCell.m
//  PatentSearch
//
//  Created by wei on 12-8-23.
//  Copyright (c) 2012年 wei. All rights reserved.
//

#import "ResultCell.h"
#import "FontLabel.h"
#import "FontLabelStringDrawing.h"
#import "FontManager.h"
#import "NSString+SBJSON.h"
#import "LawViewController.h"
@implementation ResultCell
@synthesize GtitleName,GStarImage,GcontentDic,gScore,btnLaw,index,sourceData,arrData,nav;
-(void)releaseSoap
{
	if (mSoapHttp) {
		[mSoapHttp Cancel];
		[mSoapHttp release];
		mSoapHttp = nil;
	}
}
-(NSString *)htmlPath{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	return [documentsDirectory stringByAppendingPathComponent:@"atext.html"];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
		self.backgroundColor = Main_Color;
    }
    return self;
}
-(void)CellAddTextLabel
{
	NSString *gtShangBiao = [self.GtitleName stringByReplacingOccurrencesOfString:@"～lt;SUB～gt;" withString:@""];
	NSString *gtXiaBiao = [gtShangBiao stringByReplacingOccurrencesOfString:@"～lt;/SUB～gt;" withString:@""];
	NSString *gClearColor = [gtXiaBiao stringByReplacingOccurrencesOfString:@"～lt;font color=red～gt;" withString:@""];
	NSString *sizeString = [gClearColor stringByReplacingOccurrencesOfString:@"～lt;/font～gt;" withString:@""];
   
	
	CGSize size = [sizeString sizeWithFont:[UIFont systemFontOfSize:16.4] constrainedToSize:CGSizeMake(315, 1000) lineBreakMode:NSLineBreakByCharWrapping];
	NSLog(@"%f",size.height);
	if (size.height<=21) {
		size.height = 30;
	}else if (size.height>21&&size.height<43) {
		size.height = 60;
	}else if (size.height>42&&size.height<64) {
		size.height = 80;
	}else if (size.height>63) {
		size.height=105;
	}

	
	NSString *tAhuanSan = [self.GtitleName stringByReplacingOccurrencesOfString:@"～lt;" withString:@"<"];
	NSString *tAzaihua1 = [[[[tAhuanSan stringByReplacingOccurrencesOfString:@"～gt;" withString:@">"]stringByReplacingOccurrencesOfString:@"～quot;" withString:@"\""]stringByReplacingOccurrencesOfString:@"～amp;amp;" withString:@"&"]stringByReplacingOccurrencesOfString:@"～amp;" withString:@"&"];
    NSString *tAzaihua=[tAzaihua1 stringByReplacingOccurrencesOfString:@"size='18sp'" withString:@"size='3px'"];
	NSString *htmlString = [@"<html><body bgcolor=\"#ecf6fb\"><p><font size=\"3px\"><font color=YellowGreen>" stringByAppendingFormat:@"%@%@",tAzaihua,@"</font></font></p></body></html>"];
    NSLog(@"htmlString++%@",htmlString);
	UIWebView *GNameLabel = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, 320, size.height)];
	GNameLabel.backgroundColor = Main_Color;
	GNameLabel.delegate = self;
	[GNameLabel loadHTMLString:htmlString baseURL:nil];
	float version = [[[UIDevice currentDevice] systemVersion] floatValue];
    if (version >= 5.0)
    {
        /* ios5/xcode4.2 以下不支持次方法 */
		GNameLabel.scrollView.scrollEnabled = NO;
		        /********************/
	
    }
	[self addSubview:GNameLabel];
	[GNameLabel release];
	
	tView = [[UIView alloc]initWithFrame:GNameLabel.frame];
	tView.backgroundColor = Main_Color;
	[self addSubview:tView];
	[tView release];
//	NSString *gtShangBiao = [self.GtitleName stringByReplacingOccurrencesOfString:@"～lt;SUB～gt;" withString:@""];
//	NSString *gtXiaBiao = [gtShangBiao stringByReplacingOccurrencesOfString:@"～lt;/SUB～gt;" withString:@""];
//	NSArray *tAry = [gtXiaBiao componentsSeparatedByString:@"～lt;font color=red～gt;"];
//	NSString *tQianStr;
//	if (tAry.count>1) {
//		tQianStr = [tAry objectAtIndex:0];
//	}else{
//		tQianStr = gtXiaBiao;
//	}
//	FontLabel *GNameLabel = [[FontLabel alloc]init];
//	GNameLabel.backgroundColor = [UIColor clearColor];
//	CGSize size = [tQianStr sizeWithFont:[UIFont systemFontOfSize:15.0] constrainedToSize:CGSizeMake(320, 20) lineBreakMode:NSLineBreakByCharWrapping];
//	if (size.height<20) {
//		size.height = 20;
//	}
//	if (size.width>320) {
//		size.width=320;
//	}
//	GNameLabel.frame = CGRectMake(0, 2, size.width, size.height);
//	GNameLabel.text = tQianStr;
//	GNameLabel.numberOfLines = 0;
//	GNameLabel.font = [UIFont systemFontOfSize:15.0];
//	GNameLabel.textColor = Text_Color_Green;	
//	[self addSubview:GNameLabel];
//	[GNameLabel release];
//	
//	float frameX = GNameLabel.frame.size.width;
//	//拼字符串
//	for (int j=1; j<tAry.count; j++) {
//		NSString *gTaS = [tAry objectAtIndex:j];
//		NSArray *gTAr = [gTaS componentsSeparatedByString:@"～lt;/font～gt;"];
//		UILabel *GNameLabel1 = [[UILabel alloc]init];
//		GNameLabel1.backgroundColor = [UIColor clearColor];
//		CGSize size1 = [[gTAr objectAtIndex:0] sizeWithFont:[UIFont systemFontOfSize:15.0] constrainedToSize:CGSizeMake(320, 20) lineBreakMode:NSLineBreakByCharWrapping];
//		if (GNameLabel.frame.size.width>320) {
//			GNameLabel1.frame = CGRectMake(0, 0, 0, 0);
//		}else
//			GNameLabel1.frame = CGRectMake(frameX, 2, size1.width, size1.height);
//		GNameLabel1.text = [gTAr objectAtIndex:0];
//		GNameLabel1.numberOfLines = 0;
//		GNameLabel1.font = [UIFont systemFontOfSize:15.0];
//		GNameLabel1.textColor = [UIColor redColor];	
//		[self addSubview:GNameLabel1];
//		[GNameLabel1 release];
//		frameX = frameX +size1.width;
//		if (gTAr.count>1) {
//		
//		UILabel *GNameLabel2 = [[UILabel alloc]init];
//		GNameLabel2.backgroundColor = [UIColor clearColor];
//		CGSize size2 = [[gTAr objectAtIndex:1] sizeWithFont:[UIFont systemFontOfSize:15.0] constrainedToSize:CGSizeMake(320, 20) lineBreakMode:NSLineBreakByCharWrapping];
//		if (size2.height<20) {
//			size2.height = 20;
//		}
//			if (GNameLabel1.frame.origin.x+GNameLabel1.frame.size.width>320) {
//				GNameLabel2.frame = CGRectMake(0, 0, 0, 0);
//			}else
//				GNameLabel2.frame = CGRectMake(frameX, 2, size2.width, size2.height);
//		GNameLabel2.text = [gTAr objectAtIndex:1];
//		GNameLabel2.numberOfLines = 0;
//		GNameLabel2.font = [UIFont systemFontOfSize:15.0];
//		GNameLabel2.textColor = Text_Color_Green;
//		[self addSubview:GNameLabel2];
//		[GNameLabel2 release];
//		frameX = frameX +size2.width;
//		}
//	}
	
	
}
-(void)addXingXIngWith:(CGRect)frame
{
	tView.backgroundColor = [UIColor clearColor];
	for (int i=0; i<3; i++) {
		UIImageView *gtImage = [[UIImageView alloc]initWithFrame:CGRectMake(2+i*10, frame.size.height-1, 10, 10)];
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
	btnLaw=[UIButton buttonWithType:UIButtonTypeCustom];
    [btnLaw setTitle:NSLocalizedString(@"历史法律状态",nil) forState:UIControlStateNormal];
    [btnLaw setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btnLaw addTarget:self action:@selector(gLaw) forControlEvents:UIControlEventTouchUpInside];
    btnLaw.titleLabel.font=[UIFont fontWithName:@"STHeitiSC-Light" size:14];
//    btnLaw.titleLabel.textColor=[UIColor blueColor];
    btnLaw.frame=CGRectMake(105, frame.size.height-5, 100, 20);
    [btnLaw showsTouchWhenHighlighted];
    [self addSubview:btnLaw];
	
	NSArray *tArray = [[NSArray alloc]initWithObjects:@"申请号",@"公开日",@"主分类号",@"公开号",@"申请人", nil];
	GtcontentArray = [[NSArray alloc]initWithObjects:[self.GcontentDic objectForKey:@"an"],[self.GcontentDic objectForKey:@"pd"],[self.GcontentDic objectForKey:@"pic"],[self.GcontentDic objectForKey:@"pnm"],[self.GcontentDic objectForKey:@"pa"], nil];
	for (int i = 0; i<[tArray count]; i++) {
		UILabel *GSQHLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, frame.origin.y+frame.size.height+12+i*20, 100, 20)];
        NSString *str=[NSString stringWithFormat:@"%@:",NSLocalizedString([tArray objectAtIndex:i],nil)];
		GSQHLabel.text =str;
		GSQHLabel.textColor = [UIColor colorWithRed:101.0/255.0 green:101.0/255.0 blue:101.0/255.0 alpha:1.0];
		GSQHLabel.textAlignment = NSTextAlignmentLeft;
		GSQHLabel.font = [UIFont systemFontOfSize:14.0];
		GSQHLabel.backgroundColor = [UIColor clearColor];
		[self addSubview:GSQHLabel];
		[GSQHLabel release];
        btnLaw.titleLabel.textColor=[UIColor blueColor];

		UILabel *GSQHLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(105, frame.origin.y+frame.size.height+12+i*20, 200, 20)];
		GSQHLabel1.text = [GtcontentArray objectAtIndex:i];
		GSQHLabel1.font = [UIFont systemFontOfSize:14.0];
		GSQHLabel1.textColor = Text_color_Black;
		GSQHLabel1.backgroundColor = [UIColor clearColor];
		[self addSubview:GSQHLabel1];
		[GSQHLabel1 release];
	}
	self.backgroundColor = Main_Color;
//	[GtcontentArray release];
	[tArray release];
}
-(void)gLaw
{
    mSoapHttp = nil;
    NSLog(@"GtcontentArray++%@",GtcontentArray);
    
    NSString *paNum=[GtcontentArray objectAtIndex:0];
    paNum=[paNum stringByReplacingOccurrencesOfString:@"CN" withString:@""];
    NSArray *arrBefore=[paNum componentsSeparatedByString:@"."];
    paNum=[NSString stringWithFormat:@"%@%@%@",@"%25",[arrBefore objectAtIndex:0],@"%25"];

    NSString *lawMess=[NSString stringWithFormat:@"申请号=%@",paNum];
    NSLog(@"Law++%@",lawMess);
    [self releaseSoap];
    mSoapHttp = [[SoapHttpManager alloc]init];
    mSoapHttp.delegate = self;
     mSoapHttp.view=self;
    mSoapHttp.OnSoapFail = @selector(GcanetFail);
    mSoapHttp.OnSoapRespond = @selector(GgetJson);
	if (self.sourceData==nil) {
		self.sourceData = @"FMZL,SYXX,WGZL";
	}
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    NSString *DID=[user objectForKey:@"DID"];
    
    NSDictionary *JsonDIc = [[NSDictionary alloc]initWithObjectsAndKeys:lawMess,@"strWhere",DID,@"strImei",nil];
	NSString *tString2 = [NSString stringWithFormat:@"http://59.151.99.154:8080/pss-mp/getLegalStatus"];
	NSString *tString3 = @"";
	[mSoapHttp PostSoadMessage:JsonDIc :tString2 :tString3];
	[JsonDIc release];
	[MBProgressHUD showHUDAddedTo:self animated:YES];
    
}
-(void)GgetJson
{
    [MBProgressHUD hideHUDForView:self animated:YES];
    self.arrData=[mSoapHttp.jsonStr JSONValue];
    NSLog(@"arrdata++%@",arrData);
    LawViewController *lawView=[[LawViewController alloc]init];
    [lawView add];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"LAW" object:self.arrData];
    [self.nav pushViewController:lawView animated:YES];
    [lawView release];
}
-(IBAction)GcanetFail
{
	[MBProgressHUD hideHUDForView:self animated:YES];
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"网络连接失败！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
    [alert release];
}
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
	[self addXingXIngWith:webView.frame];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}
-(void)dealloc
{
	
	self.GcontentDic = nil;
	self.GtitleName = nil;
	self.GStarImage = nil;
	[super dealloc];
}
@end
