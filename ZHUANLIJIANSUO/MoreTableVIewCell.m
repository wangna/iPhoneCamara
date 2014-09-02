//
//  MoreTableVIewCell.m
//  ZHUANLIJIANSUO
//
//  Created by chenhuiguo on 12-8-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MoreTableVIewCell.h"

@implementation MoreTableVIewCell
@synthesize GtitleName,GStarImage,GcontentDic,gScore;

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
	UILabel *GNameLabel = [[UILabel alloc]init];
	GNameLabel.backgroundColor = [UIColor clearColor];
	CGSize size = [self.GtitleName sizeWithFont:[UIFont systemFontOfSize:15.0] constrainedToSize:CGSizeMake(320, 1000) lineBreakMode:NSLineBreakByCharWrapping];
	if (size.height<20) {
		size.height = 20;
	}
	GNameLabel.frame = CGRectMake(5, 2, 310, size.height);
	GNameLabel.text = self.GtitleName;
	GNameLabel.numberOfLines = 0;
	GNameLabel.font = [UIFont systemFontOfSize:15.0];
	GNameLabel.textColor = Text_Color_Green;	
	[self addSubview:GNameLabel];
	[GNameLabel release];
	
	for (int i=0; i<3; i++) {
		UIImageView *gtImage = [[UIImageView alloc]initWithFrame:CGRectMake(0+i*10, GNameLabel.frame.size.height+1, 10, 10)];
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

	
	NSArray *tArray = [[NSArray alloc]initWithObjects:@"申请号",@"公开号",@"申请人", nil];
    NSArray *GtcontentArray = [[NSArray alloc]initWithObjects:[self.GcontentDic objectForKey:@"pan"],[self.GcontentDic objectForKey:@"ppn"],[self.GcontentDic objectForKey:@"papplicant"], nil];
	for (int i = 0; i<[tArray count]; i++) {
		UILabel *GSQHLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, GNameLabel.frame.origin.y+GNameLabel.frame.size.height+12+i*20, 100, 20)];
        GSQHLabel.text = [NSString stringWithFormat:@"%@:",NSLocalizedString([tArray objectAtIndex:i],nil)];

		GSQHLabel.textColor = [UIColor colorWithRed:101.0/255.0 green:101.0/255.0 blue:101.0/255.0 alpha:1.0];
		GSQHLabel.textAlignment = NSTextAlignmentCenter;
		GSQHLabel.font = [UIFont systemFontOfSize:14.0];
		GSQHLabel.backgroundColor = [UIColor clearColor];
		[self addSubview:GSQHLabel];
		[GSQHLabel release];
	
		UILabel *GSQHLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(105, GNameLabel.frame.origin.y+GNameLabel.frame.size.height+12+i*20, 200, 20)];
		GSQHLabel1.text = [GtcontentArray objectAtIndex:i];
		GSQHLabel1.font = [UIFont systemFontOfSize:14.0];
		GSQHLabel1.textColor = Text_color_Black;
		GSQHLabel1.backgroundColor = [UIColor clearColor];
		[self addSubview:GSQHLabel1];
		[GSQHLabel1 release];
	}
	[GtcontentArray release];
	[tArray release];
	
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
