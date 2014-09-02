//
//  GLoginViewController.m
//  ZHUANLIJIANSUO
//
//  Created by chenhuiguo on 12-7-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//取消关注的专利

#import "GLoginViewController.h"
#import "ZhuCeViewController.h"

@interface GLoginViewController ()
{
	BOOL ifAutoLogin;//是否自动登录
	SoapHttpManager *mSoapHttp;
	LoadView *mLoad;
	UITextField *tPass;
    UITextField *tLog;
}
@property(retain,nonatomic)UITextField *GlogField;
@property(retain,nonatomic)UITextField *GpassField;
@property(retain,nonatomic)UINavigationController *GtNav;
@property(retain,nonatomic)UIImageView *mGLogimage;
@end

@implementation GLoginViewController
@synthesize GlogField,GpassField,GtNav,mGLogimage;
-(void)willAnimateFirstHalfOfRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
	
}
-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
	
}
-(NSString *)userNamePath{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	return [documentsDirectory stringByAppendingPathComponent:@"Gu_ser_Name.plist"];
}

-(void)releaseSoap
{
	if (mSoapHttp) {
		[mSoapHttp Cancel];
		[mSoapHttp release];
		mSoapHttp = nil;
	}
}


-(id)init
{
	if (self = [super init]) {
		self.title = NSLocalizedString(@"登录",nil);
		mSoapHttp = nil;
		mLoad = nil;
        ifAutoLogin=YES;
	}
	return self;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle


- (void)loadView
{
	self.navigationController.navigationBarHidden = YES;
	UIControl *tRootControl ;
	if (UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPad) {
		tRootControl = [[UIControl alloc]initWithFrame:CGRectMake(0, 0, 320, 460)];
		}
	else {
		tRootControl = [[UIControl alloc]initWithFrame:CGRectMake(0, 0, 768, 1004)];
	}
	
	self.view = tRootControl;
	self.view.backgroundColor = [UIColor colorWithRed:211.0/255.0 green:233.0/255.0 blue:250.0/255.0 alpha:0.8];
	[tRootControl release];
	UIBarButtonItem *tResgie = [[UIBarButtonItem alloc]initWithTitle:NSLocalizedString(@"注册",nil) style:UIBarButtonItemStyleBordered target:self action:@selector(GresgieNewUser)];
	self.navigationItem.rightBarButtonItem = tResgie;
	[tResgie release];
	[self AddLogAndPassText];
}
-(void)AddLogAndPassText
{
	UILabel *tZhang = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/32, 20, self.view.frame.size.width*30/32, 20)];
	tZhang.text = NSLocalizedString(@"用户名",nil);
	tZhang.textColor = Text_Color_Green;
	tZhang.backgroundColor = [UIColor clearColor];
	[self.view addSubview:tZhang];
	[tZhang release];
	
	tLog = [[UITextField alloc]initWithFrame:CGRectMake(self.view.frame.size.width/32, 42, self.view.frame.size.width*30/32, 30)];
	tLog.borderStyle = UITextBorderStyleRoundedRect;
	[tLog addTarget:self action:@selector(resignTheKeyBord:) forControlEvents:UIControlEventEditingDidEndOnExit];
	self.GlogField = tLog;
	[self.view addSubview:self.GlogField];
	[tLog release];
	
	UILabel *tMima = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/32, 80, 100, 20)];
	tMima.text = NSLocalizedString(@"密码",nil);
	tMima.textColor = Text_Color_Green;
	tMima.backgroundColor = [UIColor clearColor];
	[self.view addSubview:tMima];
	[tMima release];
	
	tPass = [[UITextField alloc]initWithFrame:CGRectMake(self.view.frame.size.width/32, tMima.frame.origin.y+22, self.view.frame.size.width*30/32, 30)];
	tPass.borderStyle = UITextBorderStyleRoundedRect;
	[tPass addTarget:self action:@selector(resignTheKeyBord:) forControlEvents:UIControlEventEditingDidEndOnExit];
	tPass.secureTextEntry = YES;
//	tPass.layer.cornerRadius = 0;
//	tPass.layer.borderWidth = 1;
//	tPass.layer.borderColor = [[UIColor colorWithRed:101.0/255.0 green:101.0/255.0 blue:101.0/255.0 alpha:1.0]CGColor];
//
	self.GpassField = tPass;
	[self.view addSubview:self.GpassField];
	[tPass release];
	
	UILabel *tRemeber = [[UILabel alloc]initWithFrame:CGRectMake(22, 0, 160, 20)];
	tRemeber.text = NSLocalizedString(@"自动登录",nil);
	tRemeber.backgroundColor = [UIColor clearColor];
	UIButton *tAutoLog = [UIButton buttonWithType:UIButtonTypeCustom];
	tAutoLog.frame = CGRectMake(self.view.frame.size.width/32, tPass.frame.origin.y+40, 150, 20);
	tAutoLog.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
	[tAutoLog setImage:[UIImage imageNamed:@"01.png"] forState:UIControlStateNormal];
	[tAutoLog setImage:[UIImage imageNamed:@"02.png"] forState:UIControlStateSelected];
	[tAutoLog addTarget:self action:@selector(GautoLogin:) forControlEvents:UIControlEventTouchUpInside];
	[tAutoLog addSubview:tRemeber];
	[tRemeber release];
	[self.view addSubview:tAutoLog];
	
	UIButton *tLogBt = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	[tLogBt setTitle:NSLocalizedString(@"登录",nil) forState:UIControlStateNormal];
	tLogBt.frame = CGRectMake(tPass.frame.origin.x+tPass.frame.size.width-60, tPass.frame.origin.y+40, 60, 25);
	[tLogBt addTarget:self action:@selector(GpostToServer) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:tLogBt];
}
-(void)resignTheKeyBord:(UITextField *)send
{
	[send resignFirstResponder];
}
- (void)viewDidLoad
{
    if ([[[UIDevice currentDevice]systemVersion]floatValue]>=7.0)
        self.edgesForExtendedLayout = UIRectEdgeNone;
	self.navigationController.navigationBarHidden = NO;
	mSoapHttp = nil;
	mLoad = nil;
}
-(void)viewDidAppear:(BOOL)animated
{
	ifAutoLogin = YES;
}
-(void)GremoveImageview
{
	[mGLogimage removeFromSuperview];
	self.navigationController.navigationBarHidden = NO;
}
//自动登录按钮
-(IBAction)GautoLogin:(UIButton *)sender
{
	ifAutoLogin = !ifAutoLogin;
	sender.selected = ifAutoLogin;
}
//注册按钮方法
-(IBAction)GresgieNewUser
{
	ZhuCeViewController *aTZhuce = [[ZhuCeViewController alloc]init];
	[self.navigationController pushViewController:aTZhuce animated:YES];
	[aTZhuce release];
}
//登录按钮方法
-(IBAction)GpostToServer
{
	if (tLog.text.length&&tPass.text.length) {
        [self releaseSoap];
        mSoapHttp = [[SoapHttpManager alloc]init];
        mSoapHttp.delegate = self;
        mSoapHttp.OnSoapFail = @selector(GcanetFail);
        mSoapHttp.OnSoapRespond = @selector(GgetData);
        NSDictionary *JsonDIc = [NSDictionary dictionaryWithObjectsAndKeys:self.GlogField.text,@"username",self.GpassField.text,@"mypassword",LINK_PASSWORD,@"password",@"interface",@"m",@"userlogin",@"a",nil];
        NSString *tString2 = MEMBER_URL;
        NSString *tString3 = @"";
        
        [mSoapHttp PostSoadMessage:JsonDIc :tString2 :tString3];
        //	[JsonDIc release];
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    }
    else
    {
        NSString *strAlert=nil;
        if (tLog.text.length) {
            strAlert=@"密码为空";
        }
        else if(tPass.text.length)
        {
            strAlert=@"用户名为空";
        }
        else
            strAlert=@"用户名和密码为空";
        UIAlertView *kong=[[UIAlertView alloc]initWithTitle:NSLocalizedString(strAlert, nil) message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [kong show];
        [kong release];
    }


}
//无网络连接
-(void)GcanetFail
{
	[MBProgressHUD hideHUDForView:self.view animated:YES];
	UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"提示",nil)
														message:NSLocalizedString(@"网络连接失败！",nil)
													   delegate:nil 
											  cancelButtonTitle:NSLocalizedString(@"确定",nil) otherButtonTitles:nil] ;
	[alertView show];
	[alertView release];
	
}
//获得返回数据
-(void)GgetData
{
	[MBProgressHUD hideHUDForView:self.view animated:YES];
	if ([mSoapHttp.mArray count]>0) {
        if ([mSoapHttp.mArray count]>1) {
            kkSessionID = [[mSoapHttp.mArray objectAtIndex:0]objectForKey:@"SessionID"];
            if ([[mSoapHttp.mArray objectAtIndex:1]objectForKey:@"nickname"]) {
                kkUserName = [[mSoapHttp.mArray objectAtIndex:1]objectForKey:@"nickname"];
            }
            if ([[mSoapHttp.mArray objectAtIndex:1]objectForKey:@"linktel"]) {
                kkmobilePhone = [[mSoapHttp.mArray objectAtIndex:1]objectForKey:@"linktel"];
            }
            if ([[mSoapHttp.mArray objectAtIndex:1]objectForKey:@"email"]) {
                kkemail = [[mSoapHttp.mArray objectAtIndex:1]objectForKey:@"email"];
            }
            if ([[mSoapHttp.mArray objectAtIndex:1]objectForKey:@"username"]) {
                kkloginName = [[mSoapHttp.mArray objectAtIndex:1]objectForKey:@"username"];
            }
            if ([[mSoapHttp.mArray objectAtIndex:1]objectForKey:@"linkman"]) {
                kkLinkman = [[mSoapHttp.mArray objectAtIndex:1]objectForKey:@"linkman"];
            }
			kkPassWord = self.GpassField.text;
            if (ifAutoLogin) {
                NSDictionary *GwriteDic = [[NSDictionary alloc]initWithObjectsAndKeys:self.GlogField.text,@"userName",self.GpassField.text,@"passWord",nil];
                [GwriteDic writeToFile:[self userNamePath] atomically:YES];
                [GwriteDic release];
            }
            NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
            [user setValue:tLog.text forKey:@"name"];
            [user setValue:tPass.text forKey:@"word"];
            [user synchronize];
            [self.navigationController popViewControllerAnimated:YES];
            
        }else{
            UIAlertView *tAlert = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"提示",nil) message:[[mSoapHttp.mArray objectAtIndex:0]objectForKey:@"message"] delegate:nil cancelButtonTitle:NSLocalizedString(@"确定",nil) otherButtonTitles: nil];
            [tAlert show];
            [tAlert release];
        }
	}
	[self releaseSoap];
}
- (void)viewDidUnload
{
    [super viewDidUnload];
}
-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
	return YES;
}
- (BOOL) shouldAutorotate {
    return YES;
}
-(void)dealloc
{
	self.GlogField = nil;
	self.GpassField = nil;
	[super dealloc];
}
@end
