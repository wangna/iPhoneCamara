//
//  GDaiLiPingLunController.h
//  ZHUANLIJIANSUO
//
//  Created by chenhuiguo on 12-8-31.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GDaiLiPingLunController : UIViewController
<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate>
{
    float Vheight;
}
@property(retain,nonatomic)NSDictionary *gContentDic;
@property(retain,nonatomic)NSString *gAgentId;
@end
