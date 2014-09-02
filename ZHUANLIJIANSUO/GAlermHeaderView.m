//
//  GAlermHeaderView.m
//  ZHUANLIJIANSUO
//
//  Created by chenhuiguo on 12-9-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "GAlermHeaderView.h"
@interface GAlermHeaderView()
{
	NSMutableArray *GDeleteArray;
}
@end
@implementation GAlermHeaderView
@synthesize gDateLabel,IfSelectBtn,delegate,IfDelete;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
		UILabel *aLabel = [[UILabel alloc]initWithFrame:CGRectMake(42, 0, 320-42, 30)];
		aLabel.backgroundColor = [UIColor clearColor];
		aLabel.font = [UIFont systemFontOfSize:15.0];
		self.gDateLabel = aLabel;
        [aLabel release];
		[self addSubview:self.gDateLabel];
		
		UIButton *tButn = [UIButton buttonWithType:UIButtonTypeCustom];
		tButn.frame = CGRectMake(20, 5, 20, 20);
		[tButn addTarget:self action:@selector(GifDelete) forControlEvents:UIControlEventTouchUpInside];
		[self addSubview:tButn];
		self.IfSelectBtn = tButn;
		[self.IfSelectBtn setImage:[UIImage imageNamed:@"02.png"] forState:UIControlStateNormal];
		[self.IfSelectBtn setImage:[UIImage imageNamed:@"01.png"] forState:UIControlStateSelected];
    }
		self.backgroundColor = [UIColor whiteColor];
    return self;
}
-(void)GifDelete
{
	self.IfSelectBtn.selected = !self.IfSelectBtn.selected;
	[self.delegate performSelector:self.IfDelete withObject:self];
	
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
	[self GifDelete];
}

-(void)dealloc
{
	self.gDateLabel = nil;
	[super dealloc];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
