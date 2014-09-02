//
//  PingLunHeaderView.h
//  ZHUANLIJIANSUO
//
//  Created by chenhuiguo on 12-8-30.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PingLunHeaderView : UIView<UIWebViewDelegate>

@property(retain,nonatomic)NSDictionary *GcontentDic;
-(void)CellAddTextLabel;

@end
