//
//  GAlermHeaderView.h
//  ZHUANLIJIANSUO
//
//  Created by chenhuiguo on 12-9-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GAlermHeaderView : UIView
{
	
}
@property(nonatomic,retain)UILabel *gDateLabel;
@property(nonatomic,assign)UIButton *IfSelectBtn;
@property(nonatomic,assign)id delegate;
@property(nonatomic,assign)SEL IfDelete;
@end
