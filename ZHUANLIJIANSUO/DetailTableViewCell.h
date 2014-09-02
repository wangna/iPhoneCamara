//
//  DetailTableViewCell.h
//  ZHUANLIJIANSUO
//
//  Created by chenhuiguo on 12-8-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailTableViewCell : UITableViewCell
{
	
}
@property (retain,nonatomic)NSString *mGtitle;
@property (retain,nonatomic)NSString *mGdetail;
@property (assign,nonatomic)CGFloat gScore;
-(void)AddTitleAndDetailText;

@end
