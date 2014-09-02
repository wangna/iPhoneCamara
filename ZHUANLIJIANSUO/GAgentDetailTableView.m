//
//  GAgentDetailTableView.m
//  ZHUANLIJIANSUO
//
//  Created by chenhuiguo on 12-8-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "GAgentDetailTableView.h"
#import "DetailTableViewCell.h"
#import "GAgencyPingLunController.h"
#import "ResultPage.h"
#import "MapViewController.h"
#import "DanDuHttp.h"
#import "GNianjianVIewControl.h"
#import "GcustomToolBar.h"
#import "DetailTitleCell.h"
#import "GLoginViewController.h"

@interface GAgentDetailTableView()
{
	DanDuHttp *mSoapHttp;//网络请求
	LoadView *mLoad;//加载弹出view
	GcustomToolBar *tab;//自定义的toolbar
	BOOL IfAgencyPationed;//代理机构是否被关注
    NSMutableArray *mGmutableArray;
}
//@property(assign,nonatomic)NSMutableArray *mGmutableArray;
@property(retain,nonatomic)NSDictionary *mgDic;
@property(retain,nonatomic)NSArray *mgNameArray;
@property(retain,nonatomic)UITableView *mgTableView;
@end
@implementation GAgentDetailTableView
@synthesize mGId,mgDic,mgNameArray,mgTableView,arry;
-(void)gAddAlertView:(NSString *)message
{
	UIAlertView *tAlert = [[UIAlertView alloc]initWithTitle:@"" message:message delegate:nil cancelButtonTitle:NSLocalizedString(@"确定",nil) otherButtonTitles:nil];
	[tAlert show];
	[tAlert release];
	
}

-(void)releaseSoap
{
	if (mSoapHttp) {
		[mSoapHttp Cancel];
		[mSoapHttp release];
		mSoapHttp = nil;
	}
}

-(void)releaseCustomToolbar
{
	if (tab) {
		[tab removeFromSuperview];
		tab = nil;
	}
}
-(void)gAddAlertView
{
    UIAlertView *tAlert = [[UIAlertView alloc]initWithTitle:@"" message:NSLocalizedString(@"您还未登录！请先登录",nil) delegate:self cancelButtonTitle:NSLocalizedString(@"取消",nil) otherButtonTitles:NSLocalizedString(@"登录",nil), nil];
    [tAlert show];
    [tAlert release];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==[alertView cancelButtonIndex]) {
        
    }else{
        GLoginViewController *tGlogin = [[GLoginViewController alloc]init];
        [self.navigationController pushViewController:tGlogin animated:YES];
        [tGlogin release];
    }
}

-(id)init
{
	if (self = [super init]) {
		self.title = NSLocalizedString(@"代理机构",nil);
	}
	return self;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
-(void)loadView
{
    Vheight=[UIScreen mainScreen].bounds.size.height;
	IfAgencyPationed = NO;
	UIView *tView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, Vheight-20)];
	self.view = tView;
	self.view.backgroundColor = Main_Color;
	self.navigationController.navigationBarHidden = NO;
	[tView release];
	
	UITableView *gTAlerm = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, Vheight-102) style:UITableViewStylePlain];
    gTAlerm.backgroundView=[[[UIView alloc]init]autorelease];
   
	gTAlerm.backgroundColor = Main_Color;
	gTAlerm.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
	gTAlerm.delegate = self;
	gTAlerm.dataSource= self;
	self.mgTableView = gTAlerm;
	[self.view addSubview:self.mgTableView];
	[gTAlerm release];
}
//代理机构是否被关注
-(IBAction)gPostIfTheAgencyPation
{
	[self releaseSoap];
	mSoapHttp = [[DanDuHttp alloc]init];
	mSoapHttp.delegate = self;
	mSoapHttp.OnSoapFail = @selector(GcanetFail);
	mSoapHttp.OnSoapRespond = @selector(GgetIfPationed);
	NSDictionary *JsonDIc = [[NSDictionary alloc]initWithObjectsAndKeys:self.mGId,@"agencyId",LINK_PASSWORD,@"password",@"agencyIsAttention",@"a",@"interface",@"m", nil];
	NSString *tString2 = [NSString stringWithFormat:@"%@%@%@",BASE_URL,@"&a=agencyIsAttention&sid=",kkSessionID];
	NSString *tString3 = @"";
	[mSoapHttp PostSoadMessage:JsonDIc :tString2 :tString3];
	[JsonDIc release];
     [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}
-(void)GgetIfPationed
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
	if ([[[mSoapHttp.mArray objectAtIndex:0]objectForKey:@"status"]isEqualToString:@"0"]) {
		NSArray *tArray = [[[mSoapHttp.mArray objectAtIndex:0]objectForKey:@"message"] componentsSeparatedByString:@":"];
        NSLog(@"tArray+++%@",tArray);
		if ([[tArray objectAtIndex:1]intValue]>0) {
		IfAgencyPationed = YES;
		[self gAddCancelAtentionAgency];
		[self.mgTableView reloadData];
		}
	}
	[self releaseSoap];
}
//通过id获取代理机构信息
#pragma mark - View lifecycle
-(IBAction)GPostSearchAgency
{
	[self releaseSoap];
	mSoapHttp = [[DanDuHttp alloc]init];
	mSoapHttp.delegate = self;
	mSoapHttp.OnSoapFail = @selector(GcanetFail);
	mSoapHttp.OnSoapRespond = @selector(GgetsearchAgencyData);
	NSDictionary *JsonDIc = [[NSDictionary alloc]initWithObjectsAndKeys:self.mGId,@"id",LINK_PASSWORD,@"password",@"getAgentById",@"a",@"interface",@"m", nil];
	NSString *tString2 = [NSString stringWithFormat:@"%@%@%@",BASE_URL,@"&a=getAgentById&sid=",kkSessionID];
	NSString *tString3 = @"";
	[mSoapHttp PostSoadMessage:JsonDIc :tString2 :tString3];
	[JsonDIc release];
     [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}
//取消关注的带理机构tabbar
-(void)gAddCancelAtentionAgency
{
	[self releaseCustomToolbar];
	tab = [[GcustomToolBar alloc]initWithFrame:CGRectMake(0, Vheight-104, 320, 40)];
	[self.view addSubview:tab];
	[tab release];
	UIBarButtonItem *gDItu = [[UIBarButtonItem alloc]initWithTitle:NSLocalizedString(@"地图",nil) style:UIBarButtonItemStyleBordered target:self action:@selector(gbuttonAction:)];
	gDItu.tag = 1;
	
//	UIBarButtonItem *gEditBtn = [[UIBarButtonItem alloc]initWithTitle:@"取消关注" style:UIBarButtonItemStyleBordered target:self action:@selector(gbuttonAction:)];
//	gEditBtn.tag = 6;
	
	UIBarButtonItem *gFinishBtn = [[UIBarButtonItem alloc]initWithTitle:NSLocalizedString(@"评论",nil) style:UIBarButtonItemStyleBordered target:self action:@selector(gbuttonAction:)];
	gFinishBtn.tag = 3;
	
	UIBarButtonItem *gDeleteAll = [[UIBarButtonItem alloc]initWithTitle:NSLocalizedString(@"年检",nil) style:UIBarButtonItemStyleBordered target:self action:@selector(gbuttonAction:)];
	gDeleteAll.tag = 4;
	UIBarButtonItem *gPingLunBt = [[UIBarButtonItem alloc]initWithTitle:NSLocalizedString(@"相关专利" ,nil)style:UIBarButtonItemStyleBordered target:self action:@selector(gbuttonAction:)];
	gPingLunBt.tag = 5;
	UIBarButtonItem *aSpaceItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:@selector(gbuttonAction:)];
	
	NSArray *abutArray = [[NSArray alloc]initWithObjects:gPingLunBt,aSpaceItem,gDeleteAll,gFinishBtn,gDItu, nil];
	tab.items = abutArray;
	[abutArray release];
	[gDItu release];
//	[gEditBtn release];
	[gFinishBtn release];
	[gDeleteAll release];
	[gPingLunBt release];
	[aSpaceItem release];
}

//加载关注带理机构tabbar
-(void)addASegmentidControl
{	
	[self releaseCustomToolbar];
	tab = [[GcustomToolBar alloc]initWithFrame:CGRectMake(0, Vheight-104, 320, 40)];
	[self.view addSubview:tab];
	[tab release];
	UIBarButtonItem *gDItu = [[UIBarButtonItem alloc]initWithTitle:NSLocalizedString(@"地图",nil) style:UIBarButtonItemStyleBordered target:self action:@selector(gbuttonAction:)];
	gDItu.tag = 1;
	
//	UIBarButtonItem *gEditBtn = [[UIBarButtonItem alloc]initWithTitle:@"关注代理机构" style:UIBarButtonItemStyleBordered target:self action:@selector(gbuttonAction:)];
//	gEditBtn.tag = 2;
	
	UIBarButtonItem *gFinishBtn = [[UIBarButtonItem alloc]initWithTitle:NSLocalizedString(@"评论",nil) style:UIBarButtonItemStyleBordered target:self action:@selector(gbuttonAction:)];
	gFinishBtn.tag = 3;
	
	UIBarButtonItem *gDeleteAll = [[UIBarButtonItem alloc]initWithTitle:NSLocalizedString(@"年检",nil)style:UIBarButtonItemStyleBordered target:self action:@selector(gbuttonAction:)];
	gDeleteAll.tag = 4;
	UIBarButtonItem *gPingLunBt = [[UIBarButtonItem alloc]initWithTitle:NSLocalizedString(@"相关专利" ,nil)style:UIBarButtonItemStyleBordered target:self action:@selector(gbuttonAction:)];
	gPingLunBt.tag = 5;
	UIBarButtonItem *aSpaceItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:@selector(gbuttonAction:)];
	if ([[[UIDevice currentDevice]systemVersion]floatValue]>=7.0)
    {
        [gDItu setTintColor:[UIColor whiteColor]];
        [gFinishBtn setTintColor:[UIColor whiteColor]];
        [gDeleteAll setTintColor:[UIColor whiteColor]];
        [gPingLunBt setTintColor:[UIColor whiteColor]];
    }
	NSArray *abutArray = [[NSArray alloc]initWithObjects:gPingLunBt,aSpaceItem,gDeleteAll,gFinishBtn,gDItu, nil];
	tab.items = abutArray;
	[abutArray release];
	[gDItu release];
//	[gEditBtn release];
	[gFinishBtn release];
	[gDeleteAll release];
	[gPingLunBt release];
	[aSpaceItem release];
}

- (void)viewDidLoad
{
    if ([[[UIDevice currentDevice]systemVersion]floatValue]>=7.0)
        self.edgesForExtendedLayout = UIRectEdgeNone;
	tab = nil;
    mGmutableArray=[[NSMutableArray alloc]initWithCapacity:0];

	[self GPostSearchAgency];
    [super viewDidLoad];
	NSArray *tgA = [[NSArray alloc]initWithObjects:@"",@"负责人",@"合伙人",@"代理专利汇总",@"介绍",@"地址",@"电话",@"成立日期", nil];
	self.mgNameArray = tgA;
	[tgA release];
	[self addASegmentidControl];
	UIBarButtonItem *rightButnItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"Gfirst.png"] style:UIBarButtonItemStyleBordered target:self action:@selector(SelfPopToROOtViewControl)];
    self.navigationItem.rightBarButtonItem = rightButnItem;
	[rightButnItem release];
	
}
-(void)SelfPopToROOtViewControl
{
	[self.navigationController popToRootViewControllerAnimated:YES];
}
//请求网络
-(void)GgetsearchAgencyData
{
	[MBProgressHUD hideHUDForView:self.view animated:YES];

	if ([[[mSoapHttp.mArray objectAtIndex:0]objectForKey:@"status"]intValue]==0) {
		self.mgDic = [mSoapHttp.mArray objectAtIndex:1];
		[mGmutableArray addObject:[self.mgDic objectForKey:@"name"]];
		[mGmutableArray addObject:[self.mgDic objectForKey:@"leader"]];
		[mGmutableArray addObject:[self.mgDic objectForKey:@"agentName"]];
		[mGmutableArray addObject:[self.mgDic objectForKey:@"patent_gather"]];
		[mGmutableArray addObject:[self.mgDic objectForKey:@"descrip"]];
		[mGmutableArray addObject:[self.mgDic objectForKey:@"address"]];
		[mGmutableArray addObject:[self.mgDic objectForKey:@"tel"]];
		[mGmutableArray addObject:[self.mgDic objectForKey:@"date_of_founded"]];
		[mgTableView reloadData];
		[self gPostIfTheAgencyPation];
	}else{
		UIAlertView *tAlert = [[UIAlertView alloc]initWithTitle:nil message:[[mSoapHttp.mArray objectAtIndex:0]objectForKey:@"message"] delegate:nil cancelButtonTitle:NSLocalizedString(@"确定",nil) otherButtonTitles: nil];
		[tAlert show];
		[tAlert release];
	}
}
//关注代理机构
-(void)gPostToDaiLiAtention
{
	[self releaseSoap];
	mSoapHttp = [[DanDuHttp alloc]init];
	mSoapHttp.delegate = self;
	mSoapHttp.OnSoapFail = @selector(GcanetFail);
	mSoapHttp.OnSoapRespond = @selector(gGetSQRAtention);
	NSDictionary *JsonDIc = [[NSDictionary alloc]initWithObjectsAndKeys:[self.mgDic objectForKey:@"id"],@"agentId",LINK_PASSWORD,@"password",@"payAttentionToAgent",@"a",@"interface",@"m", nil];
	NSString *tString2 = [NSString stringWithFormat:@"%@%@%@",BASE_URL,@"&a=payAttentionToAgent&sid=",kkSessionID];
	NSString *tString3 = @"";
	[mSoapHttp PostSoadMessage:JsonDIc :tString2 :tString3];
	[JsonDIc release];
     [MBProgressHUD showHUDAddedTo:self.view animated:YES];

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
//取消代理
-(void)gCancelAtentionAgency
{
	[self releaseSoap];
	mSoapHttp = [[DanDuHttp alloc]init];
	mSoapHttp.delegate = self;
	mSoapHttp.OnSoapFail = @selector(GcanetFail);
	mSoapHttp.OnSoapRespond = @selector(gCancelDaiLi);
	NSDictionary *JsonDIc = [[NSDictionary alloc]initWithObjectsAndKeys:[self.mgDic objectForKey:@"id"],@"id",LINK_PASSWORD,@"password",@"cancelAttentionToAgent",@"a",@"interface",@"m", nil];
	NSString *tString2 = [NSString stringWithFormat:@"%@%@%@",BASE_URL,@"&a=cancelAttentionToAgent&sid=",kkSessionID];
	NSString *tString3 = @"";
	[mSoapHttp PostSoadMessage:JsonDIc :tString2 :tString3];
	[JsonDIc release];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];

}
-(void)gCancelDaiLi
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
	if ([[[mSoapHttp.mArray objectAtIndex:0]objectForKey:@"status"]isEqualToString:@"0"]) {
		IfAgencyPationed = NO;
		[self addASegmentidControl];
		[self.mgTableView reloadData];
	}
	[self releaseSoap];
}


-(IBAction)gbuttonAction:(UIBarButtonItem *)sender
{
	switch (sender.tag) {
		case 6:
		{
			[self gCancelAtentionAgency];
		}
			break;

		case 5:
		{
			NSString *gAstr = [NSString stringWithFormat:@"%@",[self.mgDic objectForKey:@"name"]];
            NSArray *tFenHao = [gAstr componentsSeparatedByString:@";"];
            if (tFenHao.count>1) {
                gAstr = [tFenHao objectAtIndex:0];
            }
            NSArray *tAr1 = [gAstr componentsSeparatedByString:@"("];
            if (tAr1.count>1) {
                NSString *astr1 = [tAr1 objectAtIndex:1];
                NSArray *tAr2 = [astr1 componentsSeparatedByString:@")"];
                gAstr = [NSString stringWithFormat:@"%@%@%@",@"%28",[tAr2 objectAtIndex:0],@"%29"];
            }
			NSString *gResu = [@"专利代理机构%3D%25" stringByAppendingString:gAstr];
			ResultPage *result = [[ResultPage alloc]init];
			result.msg = gResu;
			[self.navigationController pushViewController:result animated:YES];
			[result release];
		}
			break;
		case 4:
		{
			GNianjianVIewControl *aNianJian = [[GNianjianVIewControl alloc]init];
			aNianJian.GmArray = [self.mgDic objectForKey:@"nianjian"];
			aNianJian.aString = [self.mgDic objectForKey:@"vertifyUrl"];
			aNianJian.aDIc = self.mgDic;
			[self.navigationController pushViewController:aNianJian animated:YES];
			[aNianJian release];
		}
			break;
		case 3:
		{
            if (kkSessionID.length>0) {
                GAgencyPingLunController *tAgency = [[GAgencyPingLunController alloc]init];
                tAgency.gAgentId = [self.mgDic objectForKey:@"id"];
                tAgency.gContentDic = self.mgDic;
                [self.navigationController pushViewController:tAgency animated:YES];
                [tAgency release];

            }else{
                [self gAddAlertView];
            }

					}
			break;
		case 2:
		{
            if (kkSessionID.length>0) {
                [self gPostToDaiLiAtention];
            }else{
                [self gAddAlertView];
            }
			
		}
			break;
		case 1:
		{
			MapViewController *gAmap = [[MapViewController alloc]init];
			gAmap.ifSoap = NO;
			NSMutableArray *aRRay = [[NSMutableArray alloc]initWithObjects:self.mgDic, nil];
			gAmap.gAllData = aRRay;
			[aRRay release];
			[self.navigationController pushViewController:gAmap animated:YES];
			[gAmap release];

		}
			break;
	}
}
-(void)gGetSQRAtention
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
	if ([[[mSoapHttp.mArray objectAtIndex:0]objectForKey:@"status"]isEqualToString:@"0"]) {
		IfAgencyPationed = YES;
		[self gAddCancelAtentionAgency];
		[self.mgTableView reloadData];
	}
	[self releaseSoap];
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//	NSLog(@"%d",self.mGmutableArray.count);
    return mGmutableArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
		CGSize size = [[mGmutableArray objectAtIndex:indexPath.row] sizeWithFont:[UIFont systemFontOfSize:16.4] constrainedToSize:CGSizeMake(275, 1000) lineBreakMode:NSLineBreakByCharWrapping];
		NSLog(@"%f",size.height);
		if (size.height<=21) {
			size.height = 30;
		}else if (size.height>21&&size.height<43) {
			size.height = 60;
		}else if (size.height>42&&size.height<64) {
			size.height = 80;
		}else if (size.height>63) {
			size.height=105;
		}
		return 20+size.height;
	}

	NSString *gS = [NSString stringWithFormat:@"%@",[mGmutableArray objectAtIndex:indexPath.row]];
	CGSize gSize = [gS sizeWithFont:[UIFont systemFontOfSize:15.0] constrainedToSize:CGSizeMake(320, 10000)lineBreakMode:NSLineBreakByClipping];
	NSLog(@"%f",gSize.height);
	return 30+gSize.height;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSString *CellIdentifier = [NSString stringWithFormat:@"Cell%d",indexPath.row];
	if (indexPath.row==0) {
		DetailTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
		if (cell==nil) {
			cell = [[[DetailTitleCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier]autorelease];
			cell.gTitle = [mGmutableArray objectAtIndex:indexPath.row];
			cell.gScore = [[self.mgDic objectForKey:@"Score"]floatValue];
			[cell gAddTitleLabel];
            cell.backgroundColor=Main_Color;
		}
	
		if (IfAgencyPationed) {
			cell.ifLiang.image = [UIImage imageNamed:@"ziXing.png"];
		}else
			cell.ifLiang.image = [UIImage imageNamed:@"wuL.png"];
        cell.selectionStyle=UITableViewCellAccessoryNone;
		return cell;
	}
    DetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[DetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        [cell setBackgroundColor:Main_Color];
    }
	if (indexPath.row==0) {
		cell.mGtitle = [mGmutableArray objectAtIndex:indexPath.row];
		cell.gScore = [[self.mgDic objectForKey:@"Score"]floatValue];
	}else{
		cell.mGtitle = NSLocalizedString([self.mgNameArray objectAtIndex:indexPath.row],nil);
		cell.mGdetail = [mGmutableArray objectAtIndex:indexPath.row];
		cell.gScore = -1;
	}
    [cell AddTitleAndDetailText];
    cell.selectionStyle=UITableViewCellAccessoryNone;

    return cell;
}
-(void)dealloc{
    [mGmutableArray release];
    [super dealloc];
}
@end
