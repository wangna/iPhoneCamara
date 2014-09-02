//
//  PingLunCell.m
//  ZHUANLIJIANSUO
//
//  Created by chenhuiguo on 12-8-30.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "PingLunCell.h"

@implementation PingLunCell
@synthesize GcontentDic;

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
	NSString *aString = [self.GcontentDic objectForKey:@"content"];
	CGSize size = [aString sizeWithFont:[UIFont systemFontOfSize:15.0] constrainedToSize:CGSizeMake(310, 1000) lineBreakMode:NSLineBreakByCharWrapping];
	if (size.height<20) {
		size.height = 20;
	}
	GNameLabel.frame = CGRectMake(5, 2, 310, size.height);
	GNameLabel.text = aString;
	GNameLabel.font = [UIFont systemFontOfSize:15.0];
	GNameLabel.textColor = Text_Color_Green;	
	[self addSubview:GNameLabel];
	[GNameLabel release];
	CGFloat aValue = [[self.GcontentDic objectForKey:@"score"]floatValue];
	for (int i=0; i<3; i++) {
		UIImageView *gtImage = [[UIImageView alloc]initWithFrame:CGRectMake(0+i*10, GNameLabel.frame.size.height+1, 10, 10)];
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
	
	
	    NSString *agString = [NSString stringWithFormat:@"%@ %@",[self.GcontentDic objectForKey:@"name"],[self.GcontentDic objectForKey:@"time"]];
		UILabel *GSQHLabel = [[UILabel alloc]initWithFrame:CGRectMake(2, GNameLabel.frame.origin.y+GNameLabel.frame.size.height+12, 316, 20)];
			GSQHLabel.text = agString;
		GSQHLabel.textColor = [UIColor colorWithRed:101.0/255.0 green:101.0/255.0 blue:101.0/255.0 alpha:1.0];
		GSQHLabel.textAlignment = NSTextAlignmentLeft;
		GSQHLabel.font = [UIFont systemFontOfSize:14.0];
		GSQHLabel.backgroundColor = [UIColor clearColor];
		[self addSubview:GSQHLabel];
		[GSQHLabel release];
		
		
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
