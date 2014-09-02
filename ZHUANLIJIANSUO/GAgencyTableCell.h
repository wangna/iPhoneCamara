//
//  GAgencyTableCell.h
//  ZHUANLIJIANSUO
//
//  Created by chenhuiguo on 12-8-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GAgencyTableCell : UITableViewCell
{
	
}
@property(retain,nonatomic)NSString *GtitleName;
@property(retain,nonatomic)UIImage *GStarImage;
@property(retain,nonatomic)NSDictionary *GcontentDic;
@property(assign,nonatomic)CGFloat gScore;
-(void)CellAddTextLabel;
@end
