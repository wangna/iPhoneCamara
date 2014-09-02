//
//  GLoadMoreTableViewCell.m
//  ZHUANLIJIANSUO
//
//  Created by chenhuiguo on 12-8-30.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "GLoadMoreTableViewCell.h"

@implementation GLoadMoreTableViewCell
@synthesize mGLoadMore,delegate,mGStr;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
		UIActivityIndicatorView *mActView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
		mActView.frame = CGRectMake(70,10, 30, 30);
		[self addSubview:mActView];
		[mActView release];
		[mActView startAnimating];
		
		UILabel *gTLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, 10, 280, 30)];
        gTLabel.textAlignment=NSTextAlignmentCenter;
		gTLabel.backgroundColor = [UIColor clearColor];
		gTLabel.text = NSLocalizedString(@"加载更多...",nil);
		[self addSubview:gTLabel];
		[gTLabel release];

    }
    return self;
}
-(void)gGetMoreFromServer
{
	[self.delegate performSelector:self.mGLoadMore withObject:self];

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)dealloc
{
	[super dealloc];
}
@end
