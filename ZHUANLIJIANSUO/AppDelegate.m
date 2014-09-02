//
//  AppDelegate.m
//  ZHUANLIJIANSUO
//
//  Created by chenhuiguo on 12-7-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeButtonViewController.h"
#import "OpenUDID.h"
#import "system.h"
#import "UserInfoManager.h"
#import "MobClick.h"
@implementation AppDelegate
@synthesize nav,limitDay;
- (void)dealloc
{
	[_window release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [WeiboSDK enableDebugMode:NO];
    [WeiboSDK registerApp:kAppKey];
    
    [MobClick startWithAppkey:@"51a3061256240b850902dcce"];
    NSString *deviceID=[[OpenUDID value]stringByAppendingString:@"z"];
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    [user setObject:deviceID forKey:@"DID"];
    //是否激活,到期
    [self releaseSoap];
    mSoapHttp = [[SoapHttpManager alloc]init];
    mSoapHttp.delegate = self;
    mSoapHttp.OnSoapFail = @selector(GcanetFail);
    mSoapHttp.OnSoapRespond = @selector(GgetisActivated);
    
    NSDictionary *JsonDIc = [[NSDictionary alloc]initWithObjectsAndKeys:deviceID,@"username",LINK_PASSWORD,@"password",@"interface",@"m",@"isActivated",@"a", nil];
    NSString *tString2 = [NSString stringWithFormat:@"%@%@",BASE_URL,@"&a=isActivated"];
      NSLog(@"JsonDIc==%@",JsonDIc);
    NSString *tString3 = @"";
    [mSoapHttp PostSoadMessage:JsonDIc :tString2 :tString3];
    [JsonDIc release];
    
    
    
    
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    self.window.backgroundColor = [UIColor whiteColor];
    self.viewController=[[[HomeButtonViewController alloc]init]autorelease];
    self.nav=[[[GcustomNavigtionController alloc]initWithRootViewController:self.viewController]autorelease];
    
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
    return YES;
}

-(void)probation:(NSString *)Days
{
    //激活，延期
    NSLog(@"激活延期+++%@",Days);
    [self releaseSoap];
    mSoapHttp = [[SoapHttpManager alloc]init];
    mSoapHttp.delegate = self;
    mSoapHttp.OnSoapFail = @selector(GcanetFail);
    mSoapHttp.OnSoapRespond = @selector(GgetData);
    NSString *deviceID=[[OpenUDID value]stringByAppendingString:@"z"];
    NSDictionary *JsonDIc = [[NSDictionary alloc]initWithObjectsAndKeys:deviceID,@"from",Days,@"activetime",LINK_PASSWORD,@"password",@"interface",@"m",@"probation",@"a", nil];
    NSString *tString2 = [NSString stringWithFormat:@"%@%@",BASE_URL,@"&a=probation"];
      NSLog(@"JsonDIc==%@",JsonDIc);
    NSString *tString3 = @"";
    [mSoapHttp PostSoadMessage:JsonDIc :tString2 :tString3];
    [JsonDIc release];
//    NSMutableString *useID=[[NSMutableString alloc]init];
//    [useID setString:[[[UIDevice currentDevice] uniqueGlobalDeviceIdentifier]stringByReplacingCharactersInRange:range withString:@"zf"]];
//    for (int i=0; i<7; i++) {
//        NSInteger num=4+i*5;
//        [useID insertString:@" " atIndex:num];
//    }
//    NSString *ID=[NSString stringWithFormat:@"序列号：%@",useID] ;
//    [useID release];
//    alert2=[[UIAlertView alloc]initWithTitle:@"使用时间不足30天，是否激活,激活请联系客服010-82000860转8502或8208" message:ID delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil,nil];
//    [alert2 show];
//    [alert2 release];
    


    
}
-(void)GgetisActivated
{
    NSInteger status=[[[mSoapHttp.mArray objectAtIndex:0]objectForKey:@"status"] intValue];
    status36=status;
    self.limitDay=[[mSoapHttp.mArray objectAtIndex:0]objectForKey:@"limitday"];
    NSInteger limitday=[limitDay intValue];
    NSLog(@"limi===%d",limitday);
    self.viewController.tmpDay=limitDay;
    NSLog(@"limitDay=====%@",limitDay);
    switch (status36) {
            //正常使用
        case 0:
            if (limitday<5) {
                NSMutableString *useID=[[NSMutableString alloc]init];
                [useID setString:[[OpenUDID value]stringByAppendingString:@"z"]];
                for (int i=0; i<10; i++) {
                    NSInteger num=4+i*5;
                    [useID insertString:@" " atIndex:num];
                }
                
                
                NSString *ID=[NSString stringWithFormat:@"序列号：%@",useID] ;
                [useID release];
                alert2=[[UIAlertView alloc]initWithTitle:@"使用时间不足5天，是否激活,激活请联系客服010-82000860转8502或8208" message:ID delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil];
                [alert2 show];
                [alert2 release];
            }
            break;
            //修改 未激活,激活1天
        case -1:
            [self probation:@"30"];
            break;
            //过期
        case -2:
            if (alert2==nil) {
                [self.nav popToRootViewControllerAnimated:NO];
                [self showView];
                
            }
            
            break;
        default:
            break;
    }
    
    
}
-(void)GgetData
{
    NSLog(@"DATA");
    NSString *message=[[mSoapHttp.mArray objectAtIndex:0]objectForKey:@"message"];
    NSLog(@"arr+++%@",message);
}
//网络连接失败
-(void)GcanetFail
{
    [self gAddAlertView:NET_LINK_FAIL];
}
-(void)gAddAlertView:(NSString *)message
{
	UIAlertView *tAlert = [[UIAlertView alloc]initWithTitle:@"" message:message delegate:nil cancelButtonTitle:NSLocalizedString(@"确定",nil) otherButtonTitles:nil];
	[tAlert show];
	[tAlert release];
	
}

-(void)showView
{
    NSMutableString *useID=[[NSMutableString alloc]init];
    [useID setString:[[OpenUDID value]stringByAppendingString:@"z"]];
    for (int i=0; i<10; i++) {
        NSInteger num=4+i*5;
        [useID insertString:@" " atIndex:num];
    }
    NSString *ID=[NSString stringWithFormat:@"序列号：%@",useID] ;
    [useID release];
    alert2=[[UIAlertView alloc]initWithTitle:@"使用期限到期，不能检索专利，请联系客服010-82000860转8502或8208激活" message:ID delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert2 show];
    [alert2 release];
    self.viewController.gTSerchBt.userInteractionEnabled=NO;
    self.viewController.mGSearchField.userInteractionEnabled=NO;
    [self.viewController.view viewWithTag:1000].userInteractionEnabled=NO;
    [self.viewController.view viewWithTag:1001].userInteractionEnabled=NO;
    [self.viewController.view viewWithTag:1002].userInteractionEnabled=NO;
    [self.viewController.view viewWithTag:1003].userInteractionEnabled=NO;
    [self.viewController.view viewWithTag:1004].userInteractionEnabled=NO;
    
    
    
}
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    
  
    
    if (alert2!=nil) {
        [alert2 dismissWithClickedButtonIndex:0 animated:NO];
        alert2=nil;
    }
    NSLog(@"NO");
   

    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    NSLog(@"viewWillAppear");
    //是否激活,到期
    [self releaseSoap];
    mSoapHttp = [[SoapHttpManager alloc]init];
    mSoapHttp.delegate = self;
    mSoapHttp.OnSoapFail = @selector(GcanetFail);
    mSoapHttp.OnSoapRespond = @selector(GgetisActivated);
    NSString *deviceID=[[OpenUDID value]stringByAppendingString:@"z"];
    NSDictionary *JsonDIc = [[NSDictionary alloc]initWithObjectsAndKeys:deviceID,@"username",LINK_PASSWORD,@"password",@"interface",@"m",@"isActivated",@"a", nil];
    NSString *tString2 = [NSString stringWithFormat:@"%@%@",BASE_URL,@"&a=isActivated"];
    NSString *tString3 = @"";
    [mSoapHttp PostSoadMessage:JsonDIc :tString2 :tString3];
    [JsonDIc release];
    
    NSInteger num=[self.nav.viewControllers count];
    NSLog(@"num+++%d",num);
    }
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    alert2=nil;

}
- (void)applicationDidBecomeActive:(UIApplication *)application
{
    
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    //    [hud removeFromSuperview];
    self.window.userInteractionEnabled=NO;
    
    
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
-(void)releaseSoap
{
	if (mSoapHttp) {
		[mSoapHttp Cancel];
		[mSoapHttp release];
		mSoapHttp = nil;
	}
}
- (void)didReceiveWeiboRequest:(WBBaseRequest *)request
{
    
}

- (void)didReceiveWeiboResponse:(WBBaseResponse *)response
{
    
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [WeiboSDK handleOpenURL:url delegate:self];
}

@end
