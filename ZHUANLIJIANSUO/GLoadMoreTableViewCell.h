//
//  GLoadMoreTableViewCell.h
//  ZHUANLIJIANSUO
//
//  Created by chenhuiguo on 12-8-30.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GLoadMoreTableViewCell : UITableViewCell
@property(assign,nonatomic)SEL mGLoadMore;
@property(assign,nonatomic)id delegate;
@property(nonatomic,retain)NSString *mGStr;
-(void)gGetMoreFromServer;

@end
