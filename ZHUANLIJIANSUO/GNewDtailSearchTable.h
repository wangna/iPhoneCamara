//
//  GNewDtailSearchTable.h
//  ZHUANLIJIANSUO
//
//  Created by chenhuiguo on 12-9-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//专利详情

#import <UIKit/UIKit.h>

@interface GNewDtailSearchTable : UIViewController
<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>
{
    float Vheight;
}
@property(nonatomic,retain)NSArray *arrData;
@property (nonatomic,retain)NSString *detailMess;
@property (nonatomic,retain)NSString *sourceData;
@property(nonatomic,assign)BOOL gZhuanli;

@end
