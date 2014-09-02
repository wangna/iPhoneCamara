//
//  AppDelegate.h
//  ZHUANLIJIANSUO
//
//  Created by chenhuiguo on 12-7-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GcustomNavigtionController.h"
#import "SoapHttpManager.h"
@class HomeButtonViewController;
@interface AppDelegate : UIResponder <UIApplicationDelegate,UIAlertViewDelegate,WeiboSDKDelegate>
{
    NSInteger status36;
    NSString *days;
    UIAlertView *alert2;
    SoapHttpManager *mSoapHttp;
    BOOL DeviceID;
}
@property (strong, nonatomic) UIWindow *window;
@property (retain,nonatomic) HomeButtonViewController *viewController;
@property(nonatomic,retain)GcustomNavigtionController *nav;
@property(nonatomic,retain)NSString *limitDay;

@end
