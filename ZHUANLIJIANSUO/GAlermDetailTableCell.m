//
//  GAlermDetailTableCell.m
//  ZHUANLIJIANSUO
//
//  Created by chenhuiguo on 12-8-27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "GAlermDetailTableCell.h"

@implementation GAlermDetailTableCell
@synthesize gArray;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}
-(void)gAddTextLabel
{
	for (int i = 0; i<self.gArray.count; i++) {
		UILabel *GSQHLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 12+i*20, 200, 20)];
		GSQHLabel1.text = [self.gArray objectAtIndex:i];
		GSQHLabel1.font = [UIFont systemFontOfSize:15.0];
		GSQHLabel1.textColor = Text_color_Black;
		GSQHLabel1.backgroundColor = [UIColor clearColor];
		[self addSubview:GSQHLabel1];
		[GSQHLabel1 release];
	}
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
