//
//  PrivateMessageControl.h
//  ZHUANLIJIANSUO
//
//  Created by chenhuiguo on 12-8-1.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "SoapHttpManager.h"
#import "MBProgressHUD.h"
@interface PrivateMessageControl : UITableViewController<MBProgressHUDDelegate>
{
    SoapHttpManager *mSoapHttp;
}
@end
