//
//  GAmendPrivateMessage.m
//  ZHUANLIJIANSUO
//
//  Created by chenhuiguo on 12-8-3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "GAmendPrivateMessage.h"
@interface GAmendPrivateMessage()
{
	UITextField *gmTextFiled;
	SoapHttpManager *mSoapHttp;
	LoadView *mLoad;
}
@property(retain,nonatomic)NSString *GmString;
@end

@implementation GAmendPrivateMessage
@synthesize GmString;


-(void)releaseSoap
{
	if (mSoapHttp) {
		[mSoapHttp Cancel];
		[mSoapHttp release];
		mSoapHttp = nil;
	}
}


-(id)initWithString:(NSString *)aString
{
	if (self = [super init]) {
        if ([aString isEqualToString:@"nickname"]) {
            self.title = NSLocalizedString(@"设置－昵称",nil);
		}else if([aString isEqualToString:@"linktel"]){
            self.title = NSLocalizedString(@"设置－电话",nil);
		}else if([aString isEqualToString:@"email"]){
			self.title = NSLocalizedString(@"设置－email",nil);
		}else if([aString isEqualToString:@"linkman"]){
			self.title = NSLocalizedString(@"设置－姓名",nil);
		}

		self.GmString = aString;
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
	UIView *Gtview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 460)];
	Gtview.backgroundColor = Main_Color;
	self.view = Gtview;
	[Gtview release];
}
-(void)GaddLabelAndTextFiled
{
	UILabel *GtLable = [[UILabel alloc]initWithFrame:CGRectMake(10, 30, 320, 30)];
	GtLable.backgroundColor = [UIColor clearColor];
	GtLable.textColor =	Text_Color_Green;
	if ([self.GmString isEqualToString:@"nickname"]) {
		GtLable.text = NSLocalizedString(@"昵称",nil);
	}else if([self.GmString isEqualToString:@"linktel"]){
		GtLable.text = NSLocalizedString(@"电话",nil);
	}else if([self.GmString isEqualToString:@"linkman"]){
		GtLable.text = NSLocalizedString(@"姓名",nil);
	}else{
		GtLable.text = @"email";
	}
	[self.view addSubview:GtLable];
	[GtLable release];
	gmTextFiled = [[UITextField alloc]initWithFrame:CGRectMake(10, 61, 300, 30)];
	[gmTextFiled addTarget:self action:@selector(resignTheKeyBord:) forControlEvents:UIControlEventEditingDidEndOnExit];
	gmTextFiled.borderStyle = UITextBorderStyleRoundedRect;
	[self.view addSubview:gmTextFiled];
	
	UIButton *GtEnterBt = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	GtEnterBt.frame = CGRectMake(10, 100, 60, 25);
	[GtEnterBt setTitle:NSLocalizedString(@"确定",nil) forState:UIControlStateNormal];
	[GtEnterBt addTarget:self action:@selector(GrequestHttp) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:GtEnterBt];
	
}
-(void)resignTheKeyBord:(UITextField *)send
{
	[send resignFirstResponder];
}
- (void)viewDidLoad
{
    if ([[[UIDevice currentDevice]systemVersion]floatValue]>=7.0)
        self.edgesForExtendedLayout = UIRectEdgeNone;
	[self GaddLabelAndTextFiled];
    [super viewDidLoad];
	UIBarButtonItem *rightButnItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"Gfirst.png"] style:UIBarButtonItemStyleBordered target:self action:@selector(SelfPopToROOtViewControl)];
    self.navigationItem.rightBarButtonItem = rightButnItem;
	[rightButnItem release];
	
}
-(void)SelfPopToROOtViewControl
{
	[self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)GrequestHttp
{
	if (gmTextFiled.text.length) {
        [self releaseSoap];
        mSoapHttp = [[SoapHttpManager alloc]init];
        mSoapHttp.delegate = self;
        mSoapHttp.OnSoapFail = @selector(GcanetFail);
        mSoapHttp.OnSoapRespond = @selector(GgetData);
        NSDictionary *JsonDIc = [[NSDictionary alloc]initWithObjectsAndKeys:gmTextFiled.text,self.GmString,LINK_PASSWORD,@"password",@"interface",@"m",kkSessionID,@"sid",@"editUser",@"a", nil];
        NSString *tString2 = [NSString stringWithFormat:@"%@%@%@",BASE_URL,@"&a=editUser&sid=",kkSessionID];
        NSString *tString3 = @"";
        [mSoapHttp PostSoadMessage:JsonDIc :tString2 :tString3];
        [JsonDIc release];
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    }
    else
    {
        UIAlertView *kong=[[UIAlertView alloc]initWithTitle:@"输入为空" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
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

//获得数据
-(void)GgetData
{
	[MBProgressHUD hideHUDForView:self.view animated:YES];
	if (mSoapHttp.mArray.count>0) {
		if ([[mSoapHttp.mArray objectAtIndex:0]isKindOfClass:[NSDictionary class]]) {
			NSDictionary *GtDic = [mSoapHttp.mArray objectAtIndex:0];
			if ([[GtDic objectForKey:@"status"]isEqualToString:@"0"]) {
				if ([self.GmString isEqualToString:@"nickname"]) {
					kkUserName = gmTextFiled.text;
                    [[NSNotificationCenter defaultCenter]postNotificationName:@"RL" object:kkUserName];

				}else if([self.GmString isEqualToString:@"linktel"]){
					kkmobilePhone = gmTextFiled.text;
				}else{
					kkemail = gmTextFiled.text;
				}
				[self.navigationController popViewControllerAnimated:YES];
			}else{
				UIAlertView *GtAlert = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"提示",nil) message:[GtDic objectForKey:@"message"] delegate:nil cancelButtonTitle:NSLocalizedString(@"确定",nil) otherButtonTitles: nil];
				[GtAlert show];
				[GtAlert release];
			}
		}
	}
	[self releaseSoap];
}
- (void)viewDidUnload
{
	self.GmString = nil;
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
-(void)dealloc
{
	[self releaseSoap];
	[super dealloc];
}

@end
