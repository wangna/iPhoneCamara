//
//  GAlermTableCell.h
//  ZHUANLIJIANSUO
//
//  Created by chenhuiguo on 12-8-27.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GAlermTableCell : UITableViewCell
@property(retain,nonatomic)NSString *gImageName;
@property(retain,nonatomic)NSString *gLabelText;
-(void)gAddImageAndText;
@end
