//
//  GSearchHistCell.m
//  ZHUANLIJIANSUO
//
//  Created by chenhuiguo on 12-9-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "GSearchHistCell.h"

@implementation GSearchHistCell
@synthesize gDic;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
       self.backgroundColor = Main_Color;
    }
    return self;
}
-(NSString *)stringChangeArrayAndChangeBack:(NSString *)string
{
    NSString *aGStrin = [string stringByReplacingOccurrencesOfString:@"%25" withString:@""];
	NSString *aZaiBian = [aGStrin stringByReplacingOccurrencesOfString:@"%3D" withString:@"="];
    NSArray *tArray = [aZaiBian componentsSeparatedByString:@" or "];
    if (tArray.count>1) {
        NSString *tStr = [tArray objectAtIndex:0];
        NSArray *tArray1 = [tStr componentsSeparatedByString:@"="];
        aZaiBian = [NSString stringWithFormat:@"%@%@%@%@",@"[",NSLocalizedString(@"关键字=",nil),[tArray1 objectAtIndex:1],@"]"];
        return aZaiBian;
    }else
        return aZaiBian;
}
-(void)gAddSearchHistData
{
	NSString *gTiaoJian = [self.gDic objectForKey:@"gTiaoJian"];
    NSString *aZaiBian = [self stringChangeArrayAndChangeBack:gTiaoJian];
    NSArray *arr=[aZaiBian componentsSeparatedByString:@"="];
    NSString *key=NSLocalizedString([arr objectAtIndex:0],nil);
	CGSize size = [aZaiBian sizeWithFont:[UIFont systemFontOfSize:15.0] constrainedToSize:CGSizeMake(320, 1000) lineBreakMode:NSLineBreakByCharWrapping];
	if (size.height<20) {
		size.height = 20;
	}
	UILabel *mlabel = [[UILabel alloc]initWithFrame:CGRectMake(3, 0, 314, size.height)];
    mlabel.backgroundColor = [UIColor clearColor];
    mlabel.textColor = Text_Color_Green;
    NSMutableString *text=[[NSMutableString alloc]initWithCapacity:0];
    [text setString:key];
    for (int i=1; i<arr.count; i++) {
        NSString *appstr=[NSString stringWithFormat:@"=%@",[arr objectAtIndex:i]];
        NSLog(@"appstr---%@",appstr);
        [text appendString:appstr];
        NSLog(@"text===%@",text);
    }
    mlabel.text = text;
	mlabel.tag = 1;
	mlabel.numberOfLines = 0;
    mlabel.font = [UIFont boldSystemFontOfSize:14];
    [self.contentView addSubview:mlabel];
    [mlabel release];
	[text release];
	NSMutableArray *arry3=[NSMutableArray arrayWithObjects:@"中国发明专利",@"中国发明授权",@"中国使用新型",@"中国外观设计",@"香港特区",@"中国台湾专利",@"中国外观设计（失效）",@"中国发明专利（失效）",@"中国实用新型（失效）",@"EPO",@"WIPO",@"英国",@"德国",@"法国",@"瑞士",@"韩国",@"俄罗斯",@"日本",@"东南亚",@"阿拉伯",@"美国",@"其它国家和地区", nil] ;
	NSMutableArray *value3 = [NSMutableArray arrayWithObjects:@"FMZL",@"FMSQ",@"SYXX",@"WGZL",@"HKPATENT",@"TWZL",@"WGSX",@"FMSX",@"XXSX",@"EPPATENT",@"WOPATENT",@"GBPATENT",@"DEPATENT",@"FRPATENT",@"CHPATENT",@"KRPATENT",@"RUPATENT",@"JPPATENT",@"ASPATENT",@"GCPATENT",@"USPATENT",@"APPATENT,ATPATENT,AUPATENT,CAPATENT,ESPATENT,ITPATENT,SEPATENT,OTHERPATENT",nil];
    stringArr =[NSMutableArray arrayWithCapacity:0];
	stringArr = [NSMutableArray arrayWithArray:[[self.gDic objectForKey:@"gkuString"] componentsSeparatedByString:@","]];
	NSMutableArray *tFiMutable = [[NSMutableArray alloc]initWithCapacity:10];
	NSLog(@"%d",stringArr.count);
	//对比换中文，
    for (int i = 0; i<stringArr.count; i++) {
        if ([[stringArr objectAtIndex:i]isEqualToString:@""]) {
            [stringArr removeObjectAtIndex:i];
        }
		
	}
    for (int j=0; j<stringArr.count; j++) {
        NSString *tLinshi = [stringArr objectAtIndex:j];
		for (int i1 = 0; i1<value3.count; i1++) {
			if ([tLinshi isEqualToString:[value3 objectAtIndex:i1]]) {
				[tFiMutable addObject:NSLocalizedString([arry3 objectAtIndex:i1],nil)];
				break;
			}
		}
    }
	//如果少了加其他国家喝地区
    if (stringArr.count>tFiMutable.count) {
        [tFiMutable addObject:NSLocalizedString(@"其它国家和地区",nil)];
    }
//	for (int j = 0; j<stringArr.count-tFiMutable.count; j++) {
//		[tFiMutable addObject:NSLocalizedString(@"其它国家和地区",nil)];
//	}
	
	NSString *gKuString = [tFiMutable componentsJoinedByString:@","];
	CGSize size1 = [gKuString sizeWithFont:[UIFont systemFontOfSize:15.0] constrainedToSize:CGSizeMake(320, 1000) lineBreakMode:NSLineBreakByCharWrapping];
	if (size1.height<20) {
		size1.height = 20;
	}
	UILabel *mlabel1 = [[UILabel alloc]initWithFrame:CGRectMake(3, size.height+2, 314, size1.height)];
    mlabel1.backgroundColor = [UIColor clearColor];
    mlabel1.textColor = Text_color_Black;
	mlabel1.numberOfLines = 0;
    mlabel1.text = gKuString;
	mlabel1.tag = 2;
    mlabel1.font = [UIFont boldSystemFontOfSize:14];
    [self.contentView addSubview:mlabel1];
    [mlabel1 release];
	
	NSDateFormatter *gFmate = [[NSDateFormatter alloc]init];
	[gFmate setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
	NSDate *aDate = [self.gDic objectForKey:@"gDateString"];
	NSString *gDateString = [gFmate stringFromDate:aDate];
	CGSize size2 = [gDateString sizeWithFont:[UIFont systemFontOfSize:15.0] constrainedToSize:CGSizeMake(320, 1000) lineBreakMode:NSLineBreakByCharWrapping];
	if (size2.height<20) {
		size2.height = 20;
	}
	UILabel *mlabel2 = [[UILabel alloc]initWithFrame:CGRectMake(3, mlabel1.frame.origin.y+mlabel1.frame.size.height+2, 314, size2.height)];
    mlabel2.backgroundColor = [UIColor clearColor];
    mlabel2.textColor = [UIColor colorWithRed:101.0/255.0 green:101.0/255.0 blue:101.0/255.0 alpha:1.0];
    mlabel2.text = gDateString;
    mlabel2.font = [UIFont boldSystemFontOfSize:14];
    [self.contentView addSubview:mlabel2];
    [mlabel2 release];
	[gFmate release];
    [tFiMutable release];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
