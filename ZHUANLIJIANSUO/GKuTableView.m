//
//  GKuTableView.m
//  ZHUANLIJIANSUO
//
//  Created by chenhuiguo on 12-9-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "GKuTableView.h"

@implementation GKuTableView
@synthesize tv1,list1,str,Gzong;
@synthesize nameTitle,delegate,gTheRow;
- (id)initWithFrame:(CGRect)frame Array:(NSArray *)array
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
		self.list1 = array;
        UITableView *tableview=[[UITableView alloc]initWithFrame:CGRectMake(5, 0, 160, 200)];
        self.tv1 = tableview;
        [tableview release];
        self.tv1.backgroundColor = Main_Color;
		self.tv1.layer.borderWidth = 2;
		self.tv1.layer.borderColor = [[UIColor colorWithRed:101.0/255.0 green:101.0/255.0 blue:101.0/255.0 alpha:1.0]CGColor];
		self.tv1.layer.cornerRadius = 5;
       
        self.tv1.dataSource = self;
        self.tv1.delegate = self;
        [self addSubview:self.tv1];
        [tv1 release];
		
    }
    return self;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.list1 count]+1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSMutableArray *arry3=[NSMutableArray arrayWithObjects:@"中国发明专利",@"中国发明授权",@"中国实用新型",@"中国外观设计",@"香港特区",@"中国台湾专利",@"中国外观设计（失效）",@"中国发明专利（失效）",@"中国实用新型（失效）",@"EPO",@"WIPO",@"英国",@"德国",@"法国",@"瑞士",@"韩国",@"俄罗斯",@"日本",@"东南亚",@"阿拉伯",@"美国",@"其它国家和地区", nil] ;
	NSMutableArray *value3 = [NSMutableArray arrayWithObjects:@"FMZL",@"FMSQ",@"SYXX",@"WGZL",@"HKPATENT",@"TWZL",@"WGSX",@"FMSX",@"XXSX",@"EPPATENT",@"WOPATENT",@"GBPATENT",@"DEPATENT",@"FRPATENT",@"CHPATENT",@"KRPATENT",@"RUPATENT",@"JPPATENT",@"ASPATENT",@"GCPATENT",@"USPATENT",@"APPATENT,ATPATENT,AUPATENT,CAPATENT,ESPATENT,ITPATENT,SEPATENT,OTHERPATENT",nil];
	NSLog(@"%d = %d",arry3.count,value3.count);
    static NSString *g = @"g";
    UITableViewCell *cell = [self.tv1 dequeueReusableCellWithIdentifier:g];
	if (indexPath.row == self.list1.count) {
		if (cell == nil) {
			cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:g] autorelease];
		}
		cell.textLabel.text = NSLocalizedString(@"总共",nil);
		cell.textLabel.font = [UIFont systemFontOfSize:12.0];
		long zong = 0;
		for (int i = 0; i<self.list1.count; i++) {
			zong = zong + [[[self.list1 objectAtIndex:i]objectForKey:@"total"]intValue];
		}
		cell.detailTextLabel.text = [NSString stringWithFormat:@"%ld",zong];
		cell.detailTextLabel.font = [UIFont systemFontOfSize:12.0];
		return cell;

	}
    if (cell == nil) {
        cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:g] autorelease];
    }
    int row = [indexPath row];
	for (int i = 0; i<value3.count; i++) {
		if ([[[self.list1 objectAtIndex:row]objectForKey:@"name"] isEqualToString:[value3 objectAtIndex:i]]) {
			cell.textLabel.text = NSLocalizedString([arry3 objectAtIndex:i],nil);
			cell.textLabel.font = [UIFont systemFontOfSize:12];
			break;
		}
	}
	if (cell.textLabel.text.length==0) {
		cell.textLabel.text =NSLocalizedString(@"其它国家和地区",nil);
		cell.textLabel.font = [UIFont systemFontOfSize:12];
	}
	cell.detailTextLabel.text = [[self.list1 objectAtIndex:row]objectForKey:@"total"];
	cell.detailTextLabel.font = [UIFont systemFontOfSize:12.0];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
	self.str = cell.textLabel.text;
	self.Gzong = cell.detailTextLabel.text;
	self.gTheRow = indexPath.row;
	[self.delegate performSelector:self.nameTitle withObject:self];
    [self removeFromSuperview];
}
@end
