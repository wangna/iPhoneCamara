//
//  SmallViewPage.m
//  PatentSearch
//
//  Created by wei on 12-8-24.
//  Copyright (c) 2012年 wei. All rights reserved.
//

#import "SmallViewPage.h"

@implementation SmallViewPage
@synthesize tv1,list1,str;
@synthesize nameTitle,delegate,mDisStr;
- (id)initWithFrame:(CGRect)frame 
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        mGarray = [[NSArray alloc]initWithObjects:@"名称",@"分类号",@"申请号",@"主分类号",@"公开号",@"公开日",@"申请日",@"申请人",@"代理机构",@"代理人",@"国省代码",@"地址",@"平均分",@"优先权",@"摘要",@"主权项", nil];
		NSArray *tArray = [[NSArray alloc]initWithObjects:@"名称",@"分类号",@"申请号",@"主分类号",@"公开（公告）号",@"公开（公告）日",@"申请日",@"申请（专利权）人",@"代理机构",@"代理人",@"国省代码",@"地址",@"平均分",@"优先权",@"摘要",@"主权项", nil];
		self.list1 = tArray;
		[tArray release];
        UITableView *tabView=[[UITableView alloc]initWithFrame:CGRectMake(5, 90, 150, 290)];
        self.tv1 =tabView;
        [tabView release];
        self.tv1.backgroundColor = Main_Color;
		self.tv1.layer.borderWidth = 2;
		self.tv1.layer.borderColor = [[UIColor colorWithRed:101.0/255.0 green:101.0/255.0 blue:101.0/255.0 alpha:1.0]CGColor];
		self.tv1.layer.cornerRadius = 5;
        [self addSubview:self.tv1];
        self.tv1.dataSource = self;
        self.tv1.delegate = self;
        [tv1 release];

    }
    return self;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.list1 count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *g = @"g";
    UITableViewCell *cell = [self.tv1 dequeueReusableCellWithIdentifier:g];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:g] autorelease];
    }
    int row = [indexPath row];
    cell.textLabel.text = NSLocalizedString([mGarray objectAtIndex:row],nil);
	cell.textLabel.font = [UIFont systemFontOfSize:13.0];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    int row = [indexPath row];
    self.str = [self.list1 objectAtIndex:row];
    self.mDisStr = [mGarray objectAtIndex:row];
    [self removeFromSuperview];
    [self.tv1 deselectRowAtIndexPath:indexPath animated:YES];
    [self.delegate performSelector:self.nameTitle withObject:self];
    
}
-(void)dealloc
{
	[mGarray release];
	self.list1 = nil;
	self.tv1 = nil;
	self.str = nil;
    [super dealloc];
}

@end
