//
//  PingLunFootView.m
//  ZHUANLIJIANSUO
//
//  Created by chenhuiguo on 12-8-31.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "PingLunFootView.h"
@interface PingLunFootView()
{
	UIButton *gBut1;
	UIButton *gBut2;
	UIButton *gBut3;
	UIButton *gBut4;
	UIButton *gBut5;
	UILabel *gLabel;
}
@end
@implementation PingLunFootView
@synthesize mGTextView,delegate,gChangeFrame,gSoapToServe,pingFen;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = Main_Color;
		self.pingFen = @"2.5";

    }
    return self;
}
-(void)gAddButtonAndTextView
{
	gBut1 = [UIButton buttonWithType:UIButtonTypeCustom];
	gBut1.frame = CGRectMake(5, 0, 40, 40);
	[gBut1 setBackgroundImage:[UIImage imageNamed:@"daQuan.png"] forState:UIControlStateNormal];
	[gBut1 addTarget:self action:@selector(button1Action) forControlEvents:UIControlEventTouchUpInside];
	[self addSubview:gBut1];
	
	gBut2 = [UIButton buttonWithType:UIButtonTypeCustom];
	gBut2.frame = CGRectMake(57, 0, 40, 40);
	[gBut2 setBackgroundImage:[UIImage imageNamed:@"daQuan.png"] forState:UIControlStateNormal];
	[gBut2 addTarget:self action:@selector(button2Action) forControlEvents:UIControlEventTouchUpInside];
	[self addSubview:gBut2];
	
	gBut3 = [UIButton buttonWithType:UIButtonTypeCustom];
	gBut3.frame = CGRectMake(109, 0, 40, 40);
	[gBut3 setBackgroundImage:[UIImage imageNamed:@"daBan.png"] forState:UIControlStateNormal];
	[gBut3 addTarget:self action:@selector(button3Action) forControlEvents:UIControlEventTouchUpInside];
	[self addSubview:gBut3];
	
//	gBut4 = [UIButton buttonWithType:UIButtonTypeCustom];
//	gBut4.frame = CGRectMake(161, 5, 50, 50);
//	[gBut4 setBackgroundImage:[UIImage imageNamed:@"daWuL.png"] forState:UIControlStateNormal];
//	[gBut4 setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
//	[gBut4 addTarget:self action:@selector(button4Action) forControlEvents:UIControlEventTouchUpInside];
//	[self addSubview:gBut4];
//	
//	gBut5 = [UIButton buttonWithType:UIButtonTypeCustom];
//	gBut5.frame = CGRectMake(213, 5, 50, 50);
//	[gBut5 setBackgroundImage:[UIImage imageNamed:@"daWuL.png"] forState:UIControlStateNormal];
//	[gBut5 setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
//	[gBut5 addTarget:self action:@selector(button5Action) forControlEvents:UIControlEventTouchUpInside];
//	[self addSubview:gBut5];
	
	gLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 20)];
	gLabel.backgroundColor = [UIColor clearColor];
	gLabel.text = NSLocalizedString(@"请输入评论",nil);
    NSLog(@"font++%@",gLabel.font);
	UITextView *aTextView = [[UITextView alloc]initWithFrame:CGRectMake(5, 45, 310, 80)];
	aTextView.delegate = self;
	[aTextView addSubview:gLabel];
	aTextView.layer.borderWidth = 1;
	aTextView.layer.borderColor = [[UIColor blackColor]CGColor];
	aTextView.layer.cornerRadius = 5;
	self.mGTextView = aTextView;
	self.mGTextView.delegate = self;
	[self addSubview:self.mGTextView];
	[aTextView release];
	
//	UIButton *gBut6 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//	gBut6.frame = CGRectMake(aTextView.frame.origin.x+aTextView.frame.size.width-60, aTextView.frame.origin.y+aTextView.frame.size.height+5, 60, 30);
//	[gBut6 setTitle:@"确定" forState:UIControlStateNormal];
//	[gBut6 addTarget:self action:@selector(soapToServer) forControlEvents:UIControlEventTouchUpInside];
//	[self addSubview:gBut6];
	
}
-(void)soapToServer
{
	[self.mGTextView resignFirstResponder];
	[self.delegate performSelector:self.gSoapToServe withObject:self];
}
-(void)textViewDidBeginEditing:(UITextView *)textView
{
	[self.delegate performSelector:self.gChangeFrame];
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
	if (gLabel) {
		[gLabel removeFromSuperview];
		gLabel = nil;
	}
	if ([text isEqualToString:@"\n"]) {
        if (textView==mGTextView) {
            [mGTextView resignFirstResponder];
            self.superview.frame=CGRectMake(0, 0, 320, 416);
        }
        
        return NO;
    }

	return YES;
}

-(void)button1Action
{
	gBut1.selected = !gBut1.selected;
	if (gBut1.selected) {
		self.pingFen = @"1";
	[gBut1 setBackgroundImage:[UIImage imageNamed:@"daQuan.png"] forState:UIControlStateNormal];
	[gBut2 setBackgroundImage:[UIImage imageNamed:@"daWuL.png"] forState:UIControlStateNormal];
	[gBut3 setBackgroundImage:[UIImage imageNamed:@"daWuL.png"] forState:UIControlStateNormal];
	[gBut4 setBackgroundImage:[UIImage imageNamed:@"daWuL.png"] forState:UIControlStateNormal];
	[gBut5 setBackgroundImage:[UIImage imageNamed:@"daWuL.png"] forState:UIControlStateNormal];
	}else{
		self.pingFen = @"0.5";
	[gBut1 setBackgroundImage:[UIImage imageNamed:@"daBan.png"] forState:UIControlStateNormal];
	[gBut2 setBackgroundImage:[UIImage imageNamed:@"daWuL.png"] forState:UIControlStateNormal];
	[gBut3 setBackgroundImage:[UIImage imageNamed:@"daWuL.png"] forState:UIControlStateNormal];
	[gBut4 setBackgroundImage:[UIImage imageNamed:@"daWuL.png"] forState:UIControlStateNormal];
	[gBut5 setBackgroundImage:[UIImage imageNamed:@"daWuL.png"] forState:UIControlStateNormal];
	}
}
-(void)button2Action
{
	gBut2.selected = !gBut2.selected;
	if (gBut2.selected) {
		self.pingFen = @"2";
		[gBut1 setBackgroundImage:[UIImage imageNamed:@"daQuan.png"] forState:UIControlStateNormal];
		[gBut2 setBackgroundImage:[UIImage imageNamed:@"daQuan.png"] forState:UIControlStateNormal];
		[gBut3 setBackgroundImage:[UIImage imageNamed:@"daWuL.png"] forState:UIControlStateNormal];
		[gBut4 setBackgroundImage:[UIImage imageNamed:@"daWuL.png"] forState:UIControlStateNormal];
		[gBut5 setBackgroundImage:[UIImage imageNamed:@"daWuL.png"] forState:UIControlStateNormal];
	}else{
		self.pingFen = @"1.5";
		[gBut1 setBackgroundImage:[UIImage imageNamed:@"daQuan.png"] forState:UIControlStateNormal];
		[gBut2 setBackgroundImage:[UIImage imageNamed:@"daBan.png"] forState:UIControlStateNormal];
		[gBut3 setBackgroundImage:[UIImage imageNamed:@"daWuL.png"] forState:UIControlStateNormal];
		[gBut4 setBackgroundImage:[UIImage imageNamed:@"daWuL.png"] forState:UIControlStateNormal];
		[gBut5 setBackgroundImage:[UIImage imageNamed:@"daWuL.png"] forState:UIControlStateNormal];
	}
}
-(void)button3Action
{
	gBut3.selected = !gBut3.selected;
	if (gBut3.selected) {
		self.pingFen = @"3";
		[gBut1 setBackgroundImage:[UIImage imageNamed:@"daQuan.png"] forState:UIControlStateNormal];
		[gBut2 setBackgroundImage:[UIImage imageNamed:@"daQuan.png"] forState:UIControlStateNormal];
		[gBut3 setBackgroundImage:[UIImage imageNamed:@"daQuan.png"] forState:UIControlStateNormal];
		[gBut4 setBackgroundImage:[UIImage imageNamed:@"daWuL.png"] forState:UIControlStateNormal];
		[gBut5 setBackgroundImage:[UIImage imageNamed:@"daWuL.png"] forState:UIControlStateNormal];
	}else{
		self.pingFen = @"2.5";
		[gBut1 setBackgroundImage:[UIImage imageNamed:@"daQuan.png"] forState:UIControlStateNormal];
		[gBut2 setBackgroundImage:[UIImage imageNamed:@"daQuan.png"] forState:UIControlStateNormal];
		[gBut3 setBackgroundImage:[UIImage imageNamed:@"daBan.png"] forState:UIControlStateNormal];
		[gBut4 setBackgroundImage:[UIImage imageNamed:@"daWuL.png"] forState:UIControlStateNormal];
		[gBut5 setBackgroundImage:[UIImage imageNamed:@"daWuL.png"] forState:UIControlStateNormal];
	}
}
-(void)button4Action
{
	gBut4.selected = !gBut4.selected;
	if (gBut4.selected) {
		self.pingFen = @"4";
		[gBut1 setBackgroundImage:[UIImage imageNamed:@"daQuan.png"] forState:UIControlStateNormal];
		[gBut2 setBackgroundImage:[UIImage imageNamed:@"daQuan.png"] forState:UIControlStateNormal];
		[gBut3 setBackgroundImage:[UIImage imageNamed:@"daQuan.png"] forState:UIControlStateNormal];
		[gBut4 setBackgroundImage:[UIImage imageNamed:@"daQuan.png"] forState:UIControlStateNormal];
		[gBut5 setBackgroundImage:[UIImage imageNamed:@"daWuL.png"] forState:UIControlStateNormal];
	}else{
		self.pingFen = @"3.5";
		[gBut1 setBackgroundImage:[UIImage imageNamed:@"daQuan.png"] forState:UIControlStateNormal];
		[gBut2 setBackgroundImage:[UIImage imageNamed:@"daQuan.png"] forState:UIControlStateNormal];
		[gBut3 setBackgroundImage:[UIImage imageNamed:@"daQuan.png"] forState:UIControlStateNormal];
		[gBut4 setBackgroundImage:[UIImage imageNamed:@"daBan.png"] forState:UIControlStateNormal];
		[gBut5 setBackgroundImage:[UIImage imageNamed:@"daWuL.png"] forState:UIControlStateNormal];
	}

}
-(void)button5Action
{
	gBut5.selected = !gBut5.selected;
	if (gBut5.selected) {
		self.pingFen = @"5";
		[gBut1 setBackgroundImage:[UIImage imageNamed:@"daQuan.png"] forState:UIControlStateNormal];
		[gBut2 setBackgroundImage:[UIImage imageNamed:@"daQuan.png"] forState:UIControlStateNormal];
		[gBut3 setBackgroundImage:[UIImage imageNamed:@"daQuan.png"] forState:UIControlStateNormal];
		[gBut4 setBackgroundImage:[UIImage imageNamed:@"daQuan.png"] forState:UIControlStateNormal];
		[gBut5 setBackgroundImage:[UIImage imageNamed:@"daQuan.png"] forState:UIControlStateNormal];
	}else{
		self.pingFen = @"4.5";
		[gBut1 setBackgroundImage:[UIImage imageNamed:@"daQuan.png"] forState:UIControlStateNormal];
		[gBut2 setBackgroundImage:[UIImage imageNamed:@"daQuan.png"] forState:UIControlStateNormal];
		[gBut3 setBackgroundImage:[UIImage imageNamed:@"daQuan.png"] forState:UIControlStateNormal];
		[gBut4 setBackgroundImage:[UIImage imageNamed:@"daQuan.png"] forState:UIControlStateNormal];
		[gBut5 setBackgroundImage:[UIImage imageNamed:@"daBan.png"] forState:UIControlStateNormal];
	}

}
-(void)dealloc
{
	self.pingFen = nil;
	[gLabel release];
	self.mGTextView = nil;
	[super dealloc];
}

@end
