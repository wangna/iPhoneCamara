//
//  gKuTableHeaderView.h
//  ZHUANLIJIANSUO
//
//  Created by chenhuiguo on 12-9-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface gKuTableHeaderView : UIView

@property(retain,nonatomic)NSString *GmNum;
@property(assign,nonatomic)SEL GAddJumpView;
@property(assign,nonatomic)SEL GAddKuTableView;
@property(assign,nonatomic)id delegate;
-(void)GaddTitleAndImage;
-(void)GaddJumpButton;

@end
