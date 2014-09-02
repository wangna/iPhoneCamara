//
//  DetailAlermTableView.h
//  ZHUANLIJIANSUO
//
//  Created by chenhuiguo on 12-8-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailAlermTableView : UITableViewController
{
	
}
@property(retain,nonatomic)NSString *gAlermDate;
@property(retain,nonatomic)NSString *gAlermType;
- (id)initWithStyle:(UITableViewStyle)style withTitle:(NSString *)title;
@end
