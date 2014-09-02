//
//  GFanKuiVIewControl.m
//  ZHUANLIJIANSUO
//
//  Created by chenhuiguo on 12-9-5.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "GFanKuiVIewControl.h"
@interface GFanKuiVIewControl()
{
	SoapHttpManager *mSoapHttp;
	LoadView *mLoad;
    UILabel *textLabel;

}
@property(retain,nonatomic)UITextView *gTextView;
@end
@implementation GFanKuiVIewControl
@synthesize gTextView;
-(id)init
{
	if (self = [super init]) {
		self.title = NSLocalizedString(@"信息反馈",nil);
	}
	return self;
}
-(void)releaseSoap
{
	if (mSoapHttp) {
		[mSoapHttp Cancel];
		[mSoapHttp release];
		mSoapHttp = nil;
	}
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
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

- (void)viewDidLoad
{
    if ([[[UIDevice currentDevice]systemVersion]floatValue]>=7.0)
        self.edgesForExtendedLayout = UIRectEdgeNone;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardShow) name:UIKeyboardDidShowNotification object:nil];

	UITextView *aTextView = [[UITextView alloc]initWithFrame:CGRectMake(5, 10, self.view.frame.size.width-10, 160+Vheight-482)];
	aTextView.layer.borderWidth = 1;
	aTextView.layer.borderColor = [[UIColor blackColor]CGColor];
	aTextView.layer.cornerRadius = 5;
	self.gTextView = aTextView;
    gTextView.delegate=self;
	[aTextView release];
	self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc]initWithTitle:NSLocalizedString(@"发送",nil) style:UIBarButtonItemStyleBordered target:self action:@selector(GPostSearchAgency)]autorelease];;
	[self.view addSubview:self.gTextView];
    textLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, gTextView.frame.size.width,45)];
    [textLabel setBackgroundColor:[UIColor clearColor]];
    textLabel.numberOfLines=0;
    [textLabel setText:@"请留下您的宝贵意见或直接联系QQ：170631644 邮箱：sunwei@cnipr.com"];
    textLabel.textColor=[UIColor grayColor];
    [gTextView addSubview:textLabel];
    textLabel.hidden=NO;

    [super viewDidLoad];
}
-(void)keyboardShow
{
    textLabel.hidden=YES;
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        if (textView==gTextView) {
            [gTextView resignFirstResponder];
        }
        
        return NO;
    }
    return YES;
}
//-(void)viewDidAppear:(BOOL)animated
//{
//	[self.gTextView becomeFirstResponder];
//}
-(IBAction)GPostSearchAgency
{
    if (gTextView.text.length) {
        [self releaseSoap];
        mSoapHttp = [[SoapHttpManager alloc]init];
        mSoapHttp.delegate = self;
        mSoapHttp.OnSoapFail = @selector(GcanetFail);
        mSoapHttp.OnSoapRespond = @selector(GgetsearchAgencyData);
        NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
        NSString *userId=[user objectForKey:@"DID"];
        NSString *contextSend=[NSString stringWithFormat:@"%@ 专利行政执法 1.0.8 iPhone %@",self.gTextView.text,userId];

        NSDictionary *JsonDIc = [[NSDictionary alloc]initWithObjectsAndKeys:kkemail,@"email",contextSend,@"content",LINK_PASSWORD,@"password",@"suggestion",@"a",@"interface",@"m", nil];
        NSString *tString2 = [NSString stringWithFormat:@"%@%@%@",BASE_URL,@"&a=suggestion&sid=",kkSessionID];
        NSString *tString3 = @"";
        [mSoapHttp PostSoadMessage:JsonDIc :tString2 :tString3];
        [JsonDIc release];
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    }

    else
    {
        UIAlertView *kong=[[UIAlertView alloc]initWithTitle:NSLocalizedString(@"输入为空",nil) message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [kong show];
        [kong release];
    }
	
}
-(void)addAlertView:(NSString *)title AndMessage:(NSString *)message
{
	UIAlertView *tAlert = [[UIAlertView alloc]initWithTitle:title message:message delegate:nil cancelButtonTitle:NSLocalizedString(@"确定",nil) otherButtonTitles: nil];
	[tAlert show];
	[tAlert release];
}

//获得关注得申请人列表数据
-(void)GgetsearchAgencyData
{
	[MBProgressHUD hideHUDForView:self.view animated:YES];
	[self addAlertView:nil AndMessage:[[mSoapHttp.mArray objectAtIndex:0]objectForKey:@"message"]];
	
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
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
-(void)dealloc
{
	self.gTextView = nil;
	[super dealloc];
}
@end
