//
//  GMoreTableViewHeader.m
//  ZHUANLIJIANSUO
//
//  Created by chenhuiguo on 12-8-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "GMoreTableViewHeader.h"

@implementation GMoreTableViewHeader
@synthesize GmNum,GAddJumpView,delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}
-(void)GaddTitleAndImage
{
	UILabel *GtNumLabel = [[UILabel alloc]initWithFrame:CGRectMake(3, 0, 200, self.frame.size.height)];
	if (self.GmNum == NULL) {
		GtNumLabel.text = [NSString stringWithFormat:NSLocalizedString(@"总共（%@）",nil),@"0"];
	}else
		GtNumLabel.text = [NSString stringWithFormat:NSLocalizedString(@"总共（%@）",nil),self.GmNum];
	GtNumLabel.font = [UIFont systemFontOfSize:15.0];
	GtNumLabel.backgroundColor = [UIColor clearColor];
	GtNumLabel.textColor = [UIColor colorWithRed:5.0/255.0 green:10.0/255.0 blue:20.0/255.0 alpha:1.0];
	[self addSubview:GtNumLabel];
	[GtNumLabel release];
	
	}
-(void)GaddJumpButton
{
	UIButton *GtJumpButton = [UIButton buttonWithType:UIButtonTypeCustom];
	GtJumpButton.frame = CGRectMake(220, 0, 110, self.frame.size.height);
	[GtJumpButton addTarget:self action:@selector(AddJumpView) forControlEvents:UIControlEventTouchDown];
	
	UILabel *GtimageLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 60, self.frame.size.height)];
	GtimageLabel.text = NSLocalizedString(@"跳转",nil);
	GtimageLabel.font = [UIFont systemFontOfSize:15.0];
	GtimageLabel.textAlignment = NSTextAlignmentRight;
	GtimageLabel.backgroundColor = [UIColor whiteColor];
	GtimageLabel.textColor = [UIColor colorWithRed:5.0/255.0 green:10.0/255.0 blue:20.0/255.0 alpha:1.0];
	[GtJumpButton addSubview:GtimageLabel];
	[GtimageLabel release];
	
	UIImageView *GtImage = [[UIImageView alloc]initWithFrame:CGRectMake(60, 7, 30, 16)];
	GtImage.image = [UIImage imageNamed:@"Gjump.png"];
	[GtJumpButton addSubview:GtImage];
	[GtImage release];	
	[self addSubview:GtJumpButton];

}
-(IBAction)AddJumpView
{
	[self.delegate performSelector:self.GAddJumpView];
}
-(void)dealloc
{
	[super dealloc];
}
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}


@end
