//
//  GAlermTableCell.m
//  ZHUANLIJIANSUO
//
//  Created by chenhuiguo on 12-8-27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "GAlermTableCell.h"

@implementation GAlermTableCell
@synthesize gImageName,gLabelText;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}
-(void)gAddImageAndText
{
	UIImageView *gImageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 17, 20, 10)];
	gImageView.image = [UIImage imageNamed:self.gImageName];
	[self addSubview:gImageView];
	[gImageView release];
	
	UILabel *gContentLabel = [[UILabel alloc]initWithFrame:CGRectMake(42, 7, 260, 30)];
	gContentLabel.text = self.gLabelText;
	gContentLabel.backgroundColor = [UIColor clearColor];
	if (self.gImageName) {
		gContentLabel.textColor = Text_Color_Green;
	}else
		gContentLabel.textColor = [UIColor colorWithRed:101.0/255.0 green:101.0/255.0 blue:101.0/255.0 alpha:1.0];
	gContentLabel.font = [UIFont systemFontOfSize:14.0];
	
	[self addSubview:gContentLabel];
	[gContentLabel release];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

}

@end
