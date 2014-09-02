//
//  GAgencyTableCell.m
//  ZHUANLIJIANSUO
//
//  Created by chenhuiguo on 12-8-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "GAgencyTableCell.h"

@implementation GAgencyTableCell
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
	NSString *GSizeString = [NSString stringWithFormat:@"%@",self.GtitleName];
	CGSize size = [GSizeString sizeWithFont:[UIFont systemFontOfSize:14.0] constrainedToSize:CGSizeMake(320, 1000) lineBreakMode:NSLineBreakByCharWrapping];
	if (size.height<20) {
		size.height = 20;
	}
	GNameLabel.numberOfLines = 0;
	GNameLabel.frame = CGRectMake(5, 2, 310, size.height);
	GNameLabel.text = GSizeString;
	GNameLabel.font = [UIFont systemFontOfSize:14.0];
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

	
	NSArray *tArray = [[NSArray alloc]initWithObjects:@"负责人",@"电话", nil];
	NSArray *GtcontentArray = [[NSArray alloc]initWithObjects:[self.GcontentDic objectForKey:@"leader"],[self.GcontentDic objectForKey:@"tel"],nil];
	for (int i = 0; i<[tArray count]; i++) {
		UILabel *GSQHLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, GNameLabel.frame.origin.y+GNameLabel.frame.size.height+12+i*20, 60, 20)];
		GSQHLabel.text = [NSString stringWithFormat:@"%@:",NSLocalizedString([tArray objectAtIndex:i],nil)];
		GSQHLabel.textColor = [UIColor colorWithRed:101.0/255.0 green:101.0/255.0 blue:101.0/255.0 alpha:1.0];
		GSQHLabel.textAlignment = NSTextAlignmentLeft;
		GSQHLabel.font = [UIFont systemFontOfSize:14.0];
		GSQHLabel.backgroundColor = [UIColor clearColor];
		[self addSubview:GSQHLabel];
		[GSQHLabel release];
		
		UILabel *GSQHLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(60, GNameLabel.frame.origin.y+GNameLabel.frame.size.height+12+i*20, 255, 20)];
		GSQHLabel1.text = [GtcontentArray objectAtIndex:i];
		GSQHLabel1.font = [UIFont systemFontOfSize:14.0];
		GSQHLabel1.textColor = Text_color_Black;
		GSQHLabel1.backgroundColor = [UIColor clearColor];
		[self addSubview:GSQHLabel1];
		[GSQHLabel1 release];
	}
	
	UILabel *gAddrTitil = [[UILabel alloc]initWithFrame:CGRectMake(0, GNameLabel.frame.origin.y+GNameLabel.frame.size.height+12+2*20, 60, 20)];
	gAddrTitil.text = [NSString stringWithFormat:@"%@:", NSLocalizedString(@"地址",nil)];
	gAddrTitil.textColor = [UIColor colorWithRed:101.0/255.0 green:101.0/255.0 blue:101.0/255.0 alpha:1.0];
	gAddrTitil.numberOfLines = 1;
	gAddrTitil.textAlignment = NSTextAlignmentLeft;
	gAddrTitil.font = [UIFont systemFontOfSize:14.0];
	gAddrTitil.backgroundColor = [UIColor clearColor];
	[self addSubview:gAddrTitil];
	[gAddrTitil release];

	NSString *gAddressString = [NSString stringWithFormat:@"%@",[self.GcontentDic objectForKey:@"address"]];

	CGSize gAdSize = [gAddressString sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(255, 4000) lineBreakMode:NSLineBreakByCharWrapping];
	if (gAdSize.height<20) {
		gAdSize.height = 20;
	}
	UILabel *gAddrLabel = [[UILabel alloc]initWithFrame:CGRectMake(60, gAddrTitil.frame.origin.y,255, gAdSize.height)];
	gAddrLabel.text = gAddressString;
	gAddrLabel.numberOfLines = 0;
	gAddrLabel.font = [UIFont systemFontOfSize:14];
	gAddrLabel.textColor = Text_color_Black;
	gAddrLabel.backgroundColor = [UIColor clearColor];
	[self addSubview:gAddrLabel];
	[gAddrLabel release];
	[GtcontentArray release];
	[tArray release];
	
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
