//
//  GMoreTableViewHeader.h
//  ZHUANLIJIANSUO
//
//  Created by chenhuiguo on 12-8-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GMoreTableViewHeader : UIView
{
	
}
@property(retain,nonatomic)NSString *GmNum;
@property(assign,nonatomic)SEL GAddJumpView;
@property(assign,nonatomic)id delegate;
-(void)GaddTitleAndImage;
-(void)GaddJumpButton;
@end
