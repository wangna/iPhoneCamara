//
//  GsqrTableCell.h
//  ZHUANLIJIANSUO
//
//  Created by chenhuiguo on 12-9-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GsqrTableCell : UITableViewCell
@property (nonatomic,retain)NSString *titleLabel;
@property (nonatomic,retain)NSString *valueLabel;
@property (nonatomic,retain)NSString *valueString;
@property (nonatomic,assign)BOOL ifLiang;
-(void)addTheDetailData;

@end
