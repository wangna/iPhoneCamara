//
//  GAmendPassViewControl.m
//  ZHUANLIJIANSUO
//
//  Created by chenhuiguo on 12-8-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "GAmendPassViewControl.h"
@interface GAmendPassViewControl()
{
	SoapHttpManager *mSoapHttp;
	LoadView *mLoad;
    UITextField *GtenterText;
    UITextField *tPass;
}
@property(retain,nonatomic)UITextField *GlogField;
@property(retain,nonatomic)UITextField *GpassField;
@end

@implementation GAmendPassViewControl
@synthesize GlogField,GpassField;

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
		self.title =NSLocalizedString(@"更改密码",nil);
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
	UIView *gTAlerm = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 460)];
	gTAlerm.backgroundColor = Main_Color;
	self.view = gTAlerm;
	[gTAlerm release];
	
}
-(void)AddLogAndPassText
{
	UILabel *tZhang = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 100, 20)];
	tZhang.text = NSLocalizedString(@"用户名",nil);
	tZhang.textColor = Text_Color_Green;
	tZhang.backgroundColor = [UIColor clearColor];
	[self.view addSubview:tZhang];
	[tZhang release];
	
	UILabel *tLog = [[UILabel alloc]initWithFrame:CGRectMake(10, 32, 240, 20)];
	tLog.backgroundColor = [UIColor clearColor];
	tLog.text = kkloginName;
	[self.view addSubview:tLog];
	[tLog release];
	
	UILabel *tMima = [[UILabel alloc]initWithFrame:CGRectMake(10, 60, 100, 20)];
	tMima.text = NSLocalizedString(@"密码",nil);
	tMima.textColor = Text_Color_Green;;
	tMima.backgroundColor = [UIColor clearColor];
	[self.view addSubview:tMima];
	[tMima release];
	
	tPass = [[UITextField alloc]initWithFrame:CGRectMake(10, tMima.frame.origin.y+22, 300, 30)];
	tPass.borderStyle = UITextBorderStyleRoundedRect;
	[tPass addTarget:self action:@selector(resignTheKeyBord:) forControlEvents:UIControlEventEditingDidEndOnExit];
	tPass.secureTextEntry = YES;
	self.GpassField = tPass;
	[self.view addSubview:self.GpassField];
	[tPass release];
	
	UILabel *GenterPass = [[UILabel alloc]initWithFrame:CGRectMake(10, tPass.frame.origin.y+40, 300, 20)];
	GenterPass.text = NSLocalizedString(@"重复输入一遍密码",nil);
	GenterPass.textColor = Text_Color_Green;
	GenterPass.backgroundColor = [UIColor clearColor];
	[self.view addSubview:GenterPass];
	[GenterPass release];
	
	GtenterText = [[UITextField alloc]initWithFrame:CGRectMake(10, GenterPass.frame.origin.y+22, 300, 30)];
	GtenterText.borderStyle = UITextBorderStyleRoundedRect;
	[GtenterText addTarget:self action:@selector(resignTheKeyBord:) forControlEvents:UIControlEventEditingDidEndOnExit];
	GtenterText.secureTextEntry = YES;
	self.GlogField = GtenterText;
	[self.view addSubview:self.GlogField];
	[GtenterText release];
	
	UIButton *tLogBt = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	[tLogBt setTitle:NSLocalizedString(@"确认",nil) forState:UIControlStateNormal];
	tLogBt.frame = CGRectMake(tPass.frame.origin.x+tPass.frame.size.width-60, GtenterText.frame.origin.y+40, 60, 25);
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
	if (kkloginName.length==0) {
		UIAlertView *tAlert = [[UIAlertView alloc]initWithTitle:@"" message:NSLocalizedString(@"您还未登录!请先登录",nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"确定",nil) otherButtonTitles: nil];
		[tAlert show];
		[tAlert release];
	}
	self.navigationController.navigationBarHidden = NO;
    [super viewDidLoad];
	[self AddLogAndPassText];
	UIBarButtonItem *rightButnItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"Gfirst.png"] style:UIBarButtonItemStyleBordered target:self action:@selector(SelfPopToROOtViewControl)];
    self.navigationItem.rightBarButtonItem = rightButnItem;
	[rightButnItem release];
	
}
-(void)SelfPopToROOtViewControl
{
	[self.navigationController popToRootViewControllerAnimated:YES];
}

//修改密码
-(IBAction)GpostToServer
{
	if (tPass.text.length>5&&[GtenterText.text isEqualToString:tPass.text]) {
        [self releaseSoap];
        mSoapHttp = [[SoapHttpManager alloc]init];
        mSoapHttp.delegate = self;
        mSoapHttp.OnSoapFail = @selector(GcanetFail);
        mSoapHttp.OnSoapRespond = @selector(GgetData);
        NSDictionary *JsonDIc = [[NSDictionary alloc]initWithObjectsAndKeys:self.GlogField.text,@"mypassword",LINK_PASSWORD,@"password",@"interface",@"m",kkSessionID,@"sid",@"editUser",@"a", nil];
        NSString *tString2 = [NSString stringWithFormat:@"%@%@%@",BASE_URL,@"&a=editUser&sid=",kkSessionID];
        NSString *tString3 = @"";
        [mSoapHttp PostSoadMessage:JsonDIc :tString2 :tString3];
        [JsonDIc release];
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
    }
    if (tPass.text.length<6) {
        UIAlertView *Kong=[[UIAlertView alloc]initWithTitle:NSLocalizedString(@"密码不能小于6位数", nil) message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [Kong show];
        [Kong release];
    }
    else if(![GtenterText.text isEqualToString:tPass.text])
    {
        UIAlertView *error=[[UIAlertView alloc]initWithTitle:NSLocalizedString(@"密码输入不一致",nil) message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [error show];
        [error release];
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
//			kkSessionID = [[mSoapHttp.mArray objectAtIndex:0]objectForKey:@"SessionID"];
//			if ([[mSoapHttp.mArray objectAtIndex:1]objectForKey:@"name"]) {
//				kkUserName = [[mSoapHttp.mArray objectAtIndex:1]objectForKey:@"name"];
//			}
//			if ([[mSoapHttp.mArray objectAtIndex:1]objectForKey:@"mobilePhone"]) {
//				kkmobilePhone = [[mSoapHttp.mArray objectAtIndex:1]objectForKey:@"mobilePhone"];
//			}
//			if ([[mSoapHttp.mArray objectAtIndex:1]objectForKey:@"email"]) {
//				kkemail = [[mSoapHttp.mArray objectAtIndex:1]objectForKey:@"email"];
//			}
//			if ([[mSoapHttp.mArray objectAtIndex:1]objectForKey:@"loginname"]) {
//				kkloginName = [[mSoapHttp.mArray objectAtIndex:1]objectForKey:@"loginname"];
//			}
			
		}else{
			UIAlertView *tAlert = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"修改成功",nil) message:[[mSoapHttp.mArray objectAtIndex:0]objectForKey:@"message"] delegate:nil cancelButtonTitle:NSLocalizedString(@"确定",nil) otherButtonTitles: nil];
			[tAlert show];
			[tAlert release];
		}
	}
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
