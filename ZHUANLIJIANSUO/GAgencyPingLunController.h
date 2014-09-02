//
//  GAgencyPingLunController.h
//  ZHUANLIJIANSUO
//
//  Created by chenhuiguo on 12-8-30.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GAgencyPingLunController : UIViewController
<UITableViewDelegate,UITableViewDataSource>
{
    float Vheight;
}
@property(retain,nonatomic)NSDictionary *gContentDic;
@property(retain,nonatomic)NSString *gAgentId;
@end
