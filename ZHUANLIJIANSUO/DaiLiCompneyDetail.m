//
//  DaiLiCompneyDetail.m
//  ZHUANLIJIANSUO
//
//  Created by chenhuiguo on 12-8-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DaiLiCompneyDetail.h"
#import "DetailTableViewCell.h"
#import "GAgencyPingLunController.h"
#import "ResultPage.h"
#import "MapViewController.h"
#import "DanDuHttp.h"
#import "GNianjianVIewControl.h"
#import "GcustomToolBar.h"
@interface DaiLiCompneyDetail()
{
	DanDuHttp *mSoapHttp;
	LoadView *mLoad;
	GcustomToolBar *tab;
}
@property(assign,nonatomic)NSMutableArray *mGmutableArray;
@property(retain,nonatomic)NSDictionary *mgDic;
@property(retain,nonatomic)NSArray *mgNameArray;
@property(retain,nonatomic)UITableView *mgTableView;
@end
@implementation DaiLiCompneyDetail
@synthesize mGId,mGmutableArray,mgDic,mgNameArray,mgTableView;
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
	self.title = @"代理机构";	
	}
	return self;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
-(void)loadView
{
	UIView *tView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 460)];
	self.view = tView;
	self.view.backgroundColor = Main_Color;
	self.navigationController.navigationBarHidden = NO;
	[tView release];

	UITableView *gTAlerm = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 378) style:UITableViewStylePlain];
	gTAlerm.backgroundColor = Main_Color;
	gTAlerm.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
	gTAlerm.delegate = self;
	gTAlerm.dataSource= self;
	self.mgTableView = gTAlerm;
	[self.view addSubview:self.mgTableView];
	[gTAlerm release];
}
//申请关注得专利接口
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

-(void)addASegmentidControl
{
	tab = [[GcustomToolBar alloc]initWithFrame:CGRectMake(0, 376, 320, 40)];
	[self.view addSubview:tab];
	[tab release];
	UIBarButtonItem *gDItu = [[UIBarButtonItem alloc]initWithTitle:@"地图" style:UIBarButtonItemStyleBordered target:self action:@selector(gbuttonAction:)];
	gDItu.tag = 1;
	
	UIBarButtonItem *gEditBtn = [[UIBarButtonItem alloc]initWithTitle:@"取消关注" style:UIBarButtonItemStyleBordered target:self action:@selector(gbuttonAction:)];
	gEditBtn.width = 60;
	gEditBtn.tag = 2;
	
	UIBarButtonItem *gFinishBtn = [[UIBarButtonItem alloc]initWithTitle:@"评论" style:UIBarButtonItemStyleBordered target:self action:@selector(gbuttonAction:)];
	gFinishBtn.tag = 3;
	
	UIBarButtonItem *gDeleteAll = [[UIBarButtonItem alloc]initWithTitle:@"年检" style:UIBarButtonItemStyleBordered target:self action:@selector(gbuttonAction:)];		
	gDeleteAll.tag = 4;
	UIBarButtonItem *gPingLunBt = [[UIBarButtonItem alloc]initWithTitle:@"相关专利" style:UIBarButtonItemStyleBordered target:self action:@selector(gbuttonAction:)];
	gPingLunBt.width = 60;
	gPingLunBt.tag = 5;
	UIBarButtonItem *aSpaceItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:@selector(gbuttonAction:)];
	
	NSArray *abutArray = [[NSArray alloc]initWithObjects:gPingLunBt,aSpaceItem,gDeleteAll,gFinishBtn,gEditBtn,gDItu, nil];
	[gDItu release];
	[gEditBtn release];
	[gFinishBtn release];
	[gDeleteAll release];
	[gPingLunBt release];
	[aSpaceItem release];
	tab.items = abutArray;
	[abutArray release];
}

- (void)viewDidLoad
{
    if ([[[UIDevice currentDevice]systemVersion]floatValue]>=7.0)
        self.edgesForExtendedLayout = UIRectEdgeNone;
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

-(void)GgetsearchAgencyData
{
	[MBProgressHUD hideHUDForView:self.view animated:YES];
    NSMutableArray *arr=[[NSMutableArray alloc]initWithCapacity:10];
	self.mGmutableArray = arr;
	if ([[[mSoapHttp.mArray objectAtIndex:0]objectForKey:@"status"]intValue]==0) {
		self.mgDic = [mSoapHttp.mArray objectAtIndex:1];
		[self.mGmutableArray addObject:[[mSoapHttp.mArray objectAtIndex:1] objectForKey:@"name"]];
		[self.mGmutableArray addObject:[[mSoapHttp.mArray objectAtIndex:1] objectForKey:@"leader"]];
		[self.mGmutableArray addObject:[[mSoapHttp.mArray objectAtIndex:1] objectForKey:@"agentName"]];
		[self.mGmutableArray addObject:[[mSoapHttp.mArray objectAtIndex:1] objectForKey:@"patent_gather"]];
		[self.mGmutableArray addObject:[[mSoapHttp.mArray objectAtIndex:1] objectForKey:@"descrip"]];
		[self.mGmutableArray addObject:[[mSoapHttp.mArray objectAtIndex:1] objectForKey:@"address"]];
		[self.mGmutableArray addObject:[[mSoapHttp.mArray objectAtIndex:1] objectForKey:@"tel"]];
		[self.mGmutableArray addObject:[[mSoapHttp.mArray objectAtIndex:1] objectForKey:@"date_of_founded"]];
		[self.mgTableView reloadData];
		[self.mgTableView reloadData];
	}else{
		UIAlertView *tAlert = [[UIAlertView alloc]initWithTitle:nil message:[[mSoapHttp.mArray objectAtIndex:0]objectForKey:@"message"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
		[tAlert show];
		[tAlert release];
	}
    [arr release];
	[self releaseSoap];
}
//无网络连接
-(void)GcanetFail
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
	UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
														message:@"网络连接失败！" 
													   delegate:nil 
											  cancelButtonTitle:@"确定" otherButtonTitles:nil] ;
	[alertView show];
	[alertView release];
	
}

//取消代理
-(void)gPostToDaiLiAtention
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
	UIAlertView *tAlert = [[UIAlertView alloc]initWithTitle:@"" message:[[mSoapHttp.mArray objectAtIndex:0]objectForKey:@"message"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
	[tAlert show];
	[tAlert release];
}
-(IBAction)gbuttonAction:(UIBarButtonItem *)sender
{
	switch (sender.tag) {
		case 5:
		{
			NSString *gAstr = [NSString stringWithFormat:@"%@",[self.mgDic objectForKey:@"name"]];
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
			GAgencyPingLunController *tAgency = [[GAgencyPingLunController alloc]init];
			tAgency.gAgentId = [self.mgDic objectForKey:@"id"];
			tAgency.gContentDic = self.mgDic;
			[self.navigationController pushViewController:tAgency animated:YES];
			[tAgency release];
		}
			break;
		case 2:
		{
			[self gPostToDaiLiAtention];
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
    return self.mGmutableArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSString *gS = [NSString stringWithFormat:@"%@",[self.mGmutableArray objectAtIndex:indexPath.row]];
	CGSize gSize = [gS sizeWithFont:[UIFont systemFontOfSize:15.0] constrainedToSize:CGSizeMake(320, 10000)lineBreakMode:NSLineBreakByClipping];
	NSLog(@"%f",gSize.height);
	return 30+gSize.height;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSString *CellIdentifier = [NSString stringWithFormat:@"Cell%d",indexPath.row];
    DetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[DetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
	if (indexPath.row==0) {
		cell.mGtitle = [self.mGmutableArray objectAtIndex:indexPath.row];
		cell.gScore = [[self.mgDic objectForKey:@"Score"]floatValue];
	}else{
		cell.mGtitle = [self.mgNameArray objectAtIndex:indexPath.row];
		cell.mGdetail = [self.mGmutableArray objectAtIndex:indexPath.row];
		cell.gScore = -1;
	}
    [cell AddTitleAndDetailText];
    return cell;
}



#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

@end
