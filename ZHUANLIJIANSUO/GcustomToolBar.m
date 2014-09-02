//
//  GcustomToolBar.m
//  ZHUANLIJIANSUO
//
//  Created by chenhuiguo on 12-9-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "GcustomToolBar.h"

@implementation GcustomToolBar

-(id)initWithFrame:(CGRect)frame
{
	if (self =[super initWithFrame:frame]) {
		float version = [[[UIDevice currentDevice] systemVersion] floatValue];
		if (version >= 5.0)
		{
			/* ios5/xcode4.2 以下不支持次方法 */
		[self setBackgroundImage:[UIImage imageNamed: @"nav_bar_bg.png"] forToolbarPosition:UIToolbarPositionAny barMetrics:UIBarMetricsDefault];
//			 setBackgroundImage: [UIImage imageNamed: @"nav_bar_bg.png"] forBarMetrics: UIBarMetricsDefault];
			/********************/
			
			self.tintColor = NavgaitonBar_Color;
		}	
	}
	return self;
}
- (void)drawRect:(CGRect)rect
{
    UIImage *image = [UIImage imageNamed: @"nav_bar_bg.png"];
    [image drawInRect:CGRectMake(0, 0, self.frame.size.width,self.frame.size.height)];
    self.tintColor = NavgaitonBar_Color;
}
-(void)dealloc
{
	[super dealloc];
}
@end
