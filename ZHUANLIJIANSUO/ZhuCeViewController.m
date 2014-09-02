//
//  ZhuCeViewController.m
//  ZHUANLIJIANSUO
//
//  Created by chenhuiguo on 12-9-5.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ZhuCeViewController.h"
@interface ZhuCeViewController()
{
	UITextField *gLoginName;
	UITextField *gPass;
	UITextField *gAgainPass;
	UITextField *gUserName;
	UITextField *gEmail;
	UITextField *gSheng;
	UITextField *gShi;
	UITextField *gLianXiRen;
	UITextField *gTel;
	SoapHttpManager *mSoapHttp;
	LoadView *mLoad;
}
@end

@implementation ZhuCeViewController
-(void)releaseSoap
{
//    logoBack Gfirst
    if (mSoapHttp) {
		[mSoapHttp Cancel];
		[mSoapHttp release];
		mSoapHttp = nil;
	}
}

-(id)init
{
	if (self = [super init]) {
		self.title = NSLocalizedString(@"注册",nil);
	}
	return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)loadView
{
    Vheight=[UIScreen mainScreen].bounds.size.height;
	UIView *gt = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, Vheight-20)];
	gt.backgroundColor = Main_Color;
	self.view = gt;
	[gt release];
}
-(void)gAddBuFenLabel
{
	NSArray *aGArray = [[NSArray alloc]initWithObjects:NSLocalizedString(@"用户名",nil),NSLocalizedString(@"密码",nil),NSLocalizedString(@"重复密码",nil),NSLocalizedString(@"昵称",nil),NSLocalizedString(@"邮箱",nil),NSLocalizedString(@"省市",nil),NSLocalizedString(@"联系人",nil),NSLocalizedString(@"电话",nil), nil];
	int a=10;
	for (int i = 0; i<5; i++) {
		UILabel *atLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, a, 125, 30)];
		atLabel.textColor = Text_Color_Green;
		atLabel.text = [aGArray objectAtIndex:i];
		atLabel.backgroundColor = [UIColor clearColor];
		atLabel.font = [UIFont systemFontOfSize:14];
		[self.view addSubview:atLabel];
		[atLabel release];
		a = a + 35;
	}
	UILabel *atLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(5, 200, 75, 30)];
	atLabel1.text = [aGArray objectAtIndex:5];
	atLabel1.textColor = Text_Color_Green;
	atLabel1.backgroundColor = [UIColor clearColor];
	atLabel1.font = [UIFont systemFontOfSize:14];
	[self.view addSubview:atLabel1];
	[atLabel1 release];
	int b = 255;
	for (int i = 6; i<8; i++) {
		UILabel *atLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(5, b, 75, 30)];
		atLabel2.text = [aGArray objectAtIndex:i];
		atLabel2.textColor = Text_Color_Green;
		atLabel2.backgroundColor = [UIColor clearColor];
		atLabel2.font = [UIFont systemFontOfSize:14];
		[self.view addSubview:atLabel2];
		[atLabel2 release];
		b = b + 35;
	}
		
}
-(void)gAddTextField
{
	gLoginName = [[UITextField alloc]initWithFrame:CGRectMake(100, 10, 215, 30)];
	gLoginName.borderStyle = UITextBorderStyleRoundedRect;
	gLoginName.placeholder = NSLocalizedString(@"只允许a-z,0-9和'_'",nil);
    gLoginName.font=[UIFont systemFontOfSize:13];
	[gLoginName addTarget:self action:@selector(resignTheKeyBord:) forControlEvents:UIControlEventEditingDidEndOnExit];
	[self.view addSubview:gLoginName];
	
	gPass = [[UITextField alloc]initWithFrame:CGRectMake(100, gLoginName.frame.origin.y+gLoginName.frame.size.height+5, 215, 30)];
	gPass.borderStyle = UITextBorderStyleRoundedRect;
	[gPass addTarget:self action:@selector(resignTheKeyBord:) forControlEvents:UIControlEventEditingDidEndOnExit];
	gPass.placeholder = NSLocalizedString(@"输入至少6位密码",nil);
    gPass.font=[UIFont systemFontOfSize:13];
	gPass.secureTextEntry = YES;
	[self.view addSubview:gPass];
	
	gAgainPass = [[UITextField alloc]initWithFrame:CGRectMake(100, gPass.frame.origin.y+gPass.frame.size.height+5, 215, 30)];
	gAgainPass.borderStyle = UITextBorderStyleRoundedRect;
	[gAgainPass addTarget:self action:@selector(resignTheKeyBord:) forControlEvents:UIControlEventEditingDidEndOnExit];
	gAgainPass.placeholder = NSLocalizedString(@"重复输入一遍密码",nil);
     gAgainPass.font=[UIFont systemFontOfSize:13];
	gAgainPass.secureTextEntry = YES;
	[self.view addSubview:gAgainPass];
	
	gUserName = [[UITextField alloc]initWithFrame:CGRectMake(100, gAgainPass.frame.origin.y+gAgainPass.frame.size.height+5, 215, 30)];
	gUserName.borderStyle = UITextBorderStyleRoundedRect;
	[gUserName addTarget:self action:@selector(resignTheKeyBord:) forControlEvents:UIControlEventEditingDidEndOnExit];
	gUserName.placeholder = NSLocalizedString(@"可以包含中文",nil);
     gUserName.font=[UIFont systemFontOfSize:13];
	[gUserName addTarget:self action:@selector(gChangeFrame:) forControlEvents:UIControlEventEditingDidBegin];
	[self.view addSubview:gUserName];
	
	gEmail = [[UITextField alloc]initWithFrame:CGRectMake(100, gUserName.frame.origin.y+gUserName.frame.size.height+5, 215, 30)];
	gEmail.borderStyle = UITextBorderStyleRoundedRect;
	[gEmail addTarget:self action:@selector(resignTheKeyBord:) forControlEvents:UIControlEventEditingDidEndOnExit];
	gEmail.placeholder = NSLocalizedString(@"以下为可选项",nil);
     gEmail.font=[UIFont systemFontOfSize:13];
	[gEmail addTarget:self action:@selector(gChangeFrame:) forControlEvents:UIControlEventEditingDidBegin];
	[self.view addSubview:gEmail];
	
	gSheng = [[UITextField alloc]initWithFrame:CGRectMake(100, gEmail.frame.origin.y+gEmail.frame.size.height+5, 215, 30)];
	gSheng.borderStyle = UITextBorderStyleRoundedRect;
	[gSheng addTarget:self action:@selector(resignTheKeyBord:) forControlEvents:UIControlEventEditingDidEndOnExit];
	gSheng.placeholder = NSLocalizedString(@"省/直辖市(例:北京,仅写名字)",nil);
     gSheng.font=[UIFont systemFontOfSize:13];
	[gSheng addTarget:self action:@selector(gChangeFrame:) forControlEvents:UIControlEventEditingDidBegin];
	[self.view addSubview:gSheng];
	
//	UILabel *atLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(180, gSheng.frame.origin.y, 140, 35)];
//	atLabel1.numberOfLines = 2;
//	atLabel1.text =@"省/直辖市(例:北京,仅写名字)";
//	atLabel1.backgroundColor = [UIColor clearColor];
//	atLabel1.font = [UIFont systemFontOfSize:14];
//	[self.view addSubview:atLabel1];
//	[atLabel1 release];
	
	gShi = [[UITextField alloc]initWithFrame:CGRectMake(100, gSheng.frame.origin.y+gSheng.frame.size.height+5, 215, 30)];
	gShi.borderStyle = UITextBorderStyleRoundedRect;
	[gShi addTarget:self action:@selector(resignTheKeyBord:) forControlEvents:UIControlEventEditingDidEndOnExit];
	gShi.placeholder = NSLocalizedString(@"市(例:朝阳,石家庄,仅写名字)",nil);
     gShi.font=[UIFont systemFontOfSize:13];
	[gShi addTarget:self action:@selector(gChangeFrame:) forControlEvents:UIControlEventEditingDidBegin];
	[self.view addSubview:gShi];
	
//	UILabel *atLabel = [[UILabel alloc]initWithFrame:CGRectMake(180, gShi.frame.origin.y, 140, 35)];
//	atLabel.numberOfLines = 2;
//	atLabel.text =@"市(例:朝阳,石家庄,仅写名字)";
//	atLabel.backgroundColor = [UIColor clearColor];
//	atLabel.font = [UIFont systemFontOfSize:14];
//	[self.view addSubview:atLabel];
//	[atLabel release];
	
	gLianXiRen = [[UITextField alloc]initWithFrame:CGRectMake(100, gShi.frame.origin.y+gShi.frame.size.height+5, 215, 30)];
	gLianXiRen.borderStyle = UITextBorderStyleRoundedRect;
	[gLianXiRen addTarget:self action:@selector(resignTheKeyBord:) forControlEvents:UIControlEventEditingDidEndOnExit];
	gLianXiRen.placeholder = @"";
	[self.view addSubview:gLianXiRen];

	gTel = [[UITextField alloc]initWithFrame:CGRectMake(100, gLianXiRen.frame.origin.y+gLianXiRen.frame.size.height+5, 215, 30)];
	gTel.borderStyle = UITextBorderStyleRoundedRect;
	[gTel addTarget:self action:@selector(resignTheKeyBord:) forControlEvents:UIControlEventEditingDidEndOnExit];
	gTel.placeholder = @"";
	[self.view addSubview:gTel];
	
	UIButton *gEnterBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	gEnterBtn.frame = CGRectMake(self.view.frame.size.width/2-30, gTel.frame.origin.y+gTel.frame.size.height+10, 60, 30);
	gEnterBtn.backgroundColor = [UIColor clearColor];
	[gEnterBtn setTitle:NSLocalizedString(@"确认",nil) forState:UIControlStateNormal];
	[gEnterBtn addTarget:self action:@selector(writeInContentJianCe) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:gEnterBtn];
	
}
-(void)resignTheKeyBord:(UITextField *)send
{
	[send resignFirstResponder];
	[self.view setFrame:CGRectMake(0, 0, 320, Vheight-20)];
    if ([[[UIDevice currentDevice]systemVersion]floatValue]>=7) {
        [self.view setFrame:CGRectMake(0, 64, 320, Vheight-20-44)];
    }
}
-(IBAction)gChangeFrame:(id)sender
{
	if (sender == gUserName) {
		self.view.center = CGPointMake(160, (Vheight-64)/2);
	}else if (sender == gEmail) {
		self.view.center = CGPointMake(160, (Vheight-64)/2-100);
	}else if (sender == gSheng) {
		self.view.center = CGPointMake(160, ((Vheight-64)/2-100)-30);
	}else if (sender == gShi) {
		self.view.center = CGPointMake(160, ((Vheight-64)/2-100)-50);
	}

}
- (void)viewDidLoad
{
    if ([[[UIDevice currentDevice]systemVersion]floatValue]>=7.0)
        self.edgesForExtendedLayout = UIRectEdgeNone;
	[self gAddBuFenLabel];
	[self gAddTextField];
    [super viewDidLoad];
	UIBarButtonItem *rightButnItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"Gfirst.png"] style:UIBarButtonItemStyleBordered target:self action:@selector(SelfPopToROOtViewControl)];
    self.navigationItem.rightBarButtonItem = rightButnItem;
	[rightButnItem release];
	
}
-(void)SelfPopToROOtViewControl
{
	[self.navigationController popToRootViewControllerAnimated:YES];
}
-(void)GaddAlertView:(NSString *)message
{
	UIAlertView *tAlert = [[UIAlertView alloc]initWithTitle:@"" message:message delegate:nil cancelButtonTitle:NSLocalizedString(@"确定",nil) otherButtonTitles:nil];
	[tAlert show];
	[tAlert release];
}
- (BOOL)isDigitalOrAlpha : (NSString *) text {
    for (int i = 0; i < text.length; i++) {
        unichar uc = [text characterAtIndex: i];
        if (!isascii(uc)) {
            return NO;
        }
    }
    return YES;
}
-(void)writeInContentJianCe
{
    if (gLoginName.text.length==0) {
		[self GaddAlertView:NSLocalizedString(@"用户名不能为空",nil)];
		return;
    }
    NSString *regex = @"^\\w+$";
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    if ([predicate evaluateWithObject:gLoginName.text] == NO||[self isDigitalOrAlpha:gLoginName.text]==NO) {
        [self GaddAlertView:NSLocalizedString(@"只允许a-z,0-9和'_'",nil)];
		return;
    }


	else if (gPass.text.length<6) {
		[self GaddAlertView:NSLocalizedString(@"密码不能小于6位数",nil)];
		return;
	}else if (![gAgainPass.text isEqualToString:gPass.text]) {
		[self GaddAlertView:NSLocalizedString(@"密码输入不一致",nil)];
		return;
	}else if (gUserName.text.length==0) {
		[self GaddAlertView:NSLocalizedString(@"昵称不能为空",nil)];
		return;
	}else
		[self GpostToServer];
}
-(IBAction)GpostToServer
{
	
	[self releaseSoap];
	mSoapHttp = [[SoapHttpManager alloc]init];
	mSoapHttp.delegate = self;
	mSoapHttp.OnSoapFail = @selector(GcanetFail);
	mSoapHttp.OnSoapRespond = @selector(GgetData);
      NSString  *name=gUserName.text;
	NSDictionary *JsonDIc = [NSDictionary dictionaryWithObjectsAndKeys:@"1",@"usertype",
                             
                             name,@"nickname",
                             gLoginName.text,@"username",
                             gPass.text,@"mypassword",
                             LINK_PASSWORD,@"password",
                             @"interface",@"m",
                             @"mobileReg",@"a",
                             gTel.text,@"linktel2",
                             gLianXiRen.text,@"linkman2",
                             gShi.text,@"country2",
                             gSheng.text,@"prov2",
                             gEmail.text,@"email2",nil];

    NSLog(@"JsonDIc==%@",JsonDIc);
	NSString *tString2 = [NSString stringWithFormat:@"%@%@",BASE_URL,@"&a=mobileReg"];
	NSString *tString3 = @"";
	[mSoapHttp PostSoadMessage:JsonDIc :tString2 :tString3];
	
	[MBProgressHUD showHUDAddedTo:self.view animated:YES];
	
}
-(void)addAlertView:(NSString *)title AndMessage:(NSString *)message
{
	UIAlertView *tAlert = [[UIAlertView alloc]initWithTitle:title message:message delegate:nil cancelButtonTitle:NSLocalizedString(@"确定",nil) otherButtonTitles: nil];
	[tAlert show];
	[tAlert release];
}

-(void)GgetData
{
	[MBProgressHUD hideHUDForView:self.view animated:YES];
	if (mSoapHttp.mArray.count>1) {
		[self addAlertView:nil AndMessage:NSLocalizedString(@"注册成功",nil)];
	}else
		[self addAlertView:nil AndMessage:NSLocalizedString([[mSoapHttp.mArray objectAtIndex:0]objectForKey:@"message"],nil)];
	[self releaseSoap];
}
-(void)GcanetFail
{
	[MBProgressHUD hideHUDForView:self.view animated:YES];
	[self addAlertView:nil AndMessage:NSLocalizedString(@"无网络连接",nil)];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
