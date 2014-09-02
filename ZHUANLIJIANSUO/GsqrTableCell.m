//
//  GsqrTableCell.m
//  ZHUANLIJIANSUO
//
//  Created by chenhuiguo on 12-9-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "GsqrTableCell.h"

@implementation GsqrTableCell
@synthesize titleLabel,valueLabel,valueString,ifLiang;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
		ifLiang = NO;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

}
-(void)addTheDetailData
{
    UILabel *alabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 320, 20)];
    alabel.backgroundColor = [UIColor clearColor];
    alabel.textColor = Text_Color_Green;
    alabel.font = [UIFont boldSystemFontOfSize:14.0];
	alabel.tag = 1;
	alabel.text =self.titleLabel;
    [self addSubview:alabel];
    [alabel release];
	
	UIImageView *gtImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 22, 15, 15)];
	if (ifLiang) {
		gtImage.image = [UIImage imageNamed:@"ziXing.png"];
	}else
		gtImage.image = [UIImage imageNamed:@"wuL.png"];
	[self addSubview:gtImage];
	[gtImage release];

	CGSize detailSize =  [self.valueString sizeWithFont:[UIFont boldSystemFontOfSize:14] constrainedToSize:CGSizeMake(320, 4000) lineBreakMode:NSLineBreakByCharWrapping];
    UILabel *blabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 22, 300, detailSize.height)];
    blabel.backgroundColor = [UIColor clearColor];
    blabel.highlightedTextColor = [UIColor whiteColor];
    blabel.lineBreakMode = NSLineBreakByCharWrapping;
    blabel.numberOfLines = 0;
    blabel.opaque = NO;
    blabel.textColor = Text_color_Black;
    blabel.tag = 2;
    blabel.font = [UIFont boldSystemFontOfSize:15];
    blabel.text = self.valueLabel;
    [self addSubview:blabel];
    [blabel release];
	
}


@end
