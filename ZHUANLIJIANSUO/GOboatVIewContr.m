//
//  GOboatVIewContr.m
//  ZHUANLIJIANSUO
//
//  Created by chenhuiguo on 12-9-5.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "GOboatVIewContr.h"

@implementation GOboatVIewContr

- (id)init
{
    self = [super init];
    if (self) {
      self.title = @"关于";
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)loadView
{
 UIView *gt = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 460)];
 gt.backgroundColor = Main_Color;
 self.view = gt;
 [gt release];
}


- (void)viewDidLoad
{
	NSString *aString = @" 专利通(ios手机版)，国内首款，及时，方便,\n 快捷的手机专利信息查询应用工具。\n 知识产权出版社 （版权所有）\n 地址：北京海淀区马甸桥马甸南村1号\n 邮编：100088 \n 网址：http://www.ipph.cn \n E-Mail: lifeng@cnipr.com\n QQ:1284706187\n 电话：(010)82000860-8219";
	CGSize aSize = [aString sizeWithFont:[UIFont systemFontOfSize:15.0] constrainedToSize:CGSizeMake(300, 1000) lineBreakMode:NSLineBreakByCharWrapping];
	UILabel *aLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 300, aSize.height+10)];
	aLabel.backgroundColor = [UIColor whiteColor];
	aLabel.text = aString;
	aLabel.textColor = Text_Color_Green;
	aLabel.font = [UIFont systemFontOfSize:15.0];
	aLabel.numberOfLines = 0;
	aLabel.layer.borderWidth = 1;
	aLabel.layer.borderColor = [[UIColor colorWithRed:101.0/255.0 green:101.0/255.0 blue:101.0/255.0 alpha:1.0]CGColor];
	aLabel.layer.cornerRadius = 5;
	[self.view addSubview:aLabel];
    [aLabel release];
    [super viewDidLoad];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
