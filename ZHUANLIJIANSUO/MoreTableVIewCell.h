//
//  MoreTableVIewCell.h
//  ZHUANLIJIANSUO
//
//  Created by chenhuiguo on 12-8-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoreTableVIewCell : UITableViewCell
{
	
}
@property(retain,nonatomic)NSString *GtitleName;
@property(retain,nonatomic)UIImage *GStarImage;
@property(retain,nonatomic)NSDictionary *GcontentDic;
@property(assign,nonatomic)CGFloat gScore;
-(void)CellAddTextLabel;

@end
