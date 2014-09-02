//
//  GAgentDetailTableView.h
//  ZHUANLIJIANSUO
//
//  Created by chenhuiguo on 12-8-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GAgentDetailTableView : UIViewController
<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>
{
    float Vheight;
}
@property(retain,nonatomic)NSString *mGId;
@property(retain,nonatomic)NSArray *arry;

@end
