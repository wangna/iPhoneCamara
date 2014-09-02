//
//  LoadView.m
//  YuYeWeiBo
//
//  Created by Hepburn on 11-9-20.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LoadView.h"
#import <QuartzCore/QuartzCore.h>

@implementation LoadView
@synthesize gName;

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
	}
    return self;
}

- (void)StartAnimate {
	mBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
	mBackView.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.5];
	mBackView.layer.cornerRadius = 8;
	mBackView.layer.masksToBounds = YES;
	[self addSubview:mBackView];
	[mBackView release];
	
	mActView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
	mActView.frame = CGRectMake(10,10, 30, 30);
	[mBackView addSubview:mActView];
	[mActView release];
	
	UILabel *g_label = [[UILabel alloc]initWithFrame:CGRectMake(40, 10,self.frame.size.width-40,self.frame.size.height-20 )];
	g_label.backgroundColor = [UIColor clearColor];
	g_label.textColor = [UIColor whiteColor];
	g_label.adjustsFontSizeToFitWidth = YES;
	g_label.text = self.gName;
	[mBackView addSubview:g_label];
	[g_label release];
	[mActView startAnimating];
}

- (void)StopAnimate {
	self.hidden = YES;
	mBackView.hidden = YES;
	[mActView stopAnimating];
}

- (void)dealloc {
	self.gName = nil;
    [super dealloc];
}


@end
