//
//  DetailTitleCell.h
//  ZHUANLIJIANSUO
//
//  Created by chenhuiguo on 12-9-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailTitleCell : UITableViewCell<UIWebViewDelegate>
{
	UIView *tView;
}
@property(nonatomic,retain)NSString *gTitle;
@property(nonatomic,assign)CGFloat gScore;
@property(nonatomic,assign)UIImageView *ifLiang;
-(void)gAddTitleLabel;
@end
