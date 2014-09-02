//
//  GAgencyPingLunController.m
//  ZHUANLIJIANSUO
//
//  Created by chenhuiguo on 12-8-30.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "GAgencyPingLunController.h"
#import "PingLunCell.h"
#import "PingLunHeaderView.h"
#import "GLoadMoreTableViewCell.h"
#import "PingLunFootView.h"
@interface GAgencyPingLunController()
{
	SoapHttpManager *mSoapHttp;
	LoadView *mLoad;
	NSInteger TheRowNum;
	CGFloat gFloa;
	PingLunFootView *gAFooter;
	NSString *gTheTiaoStr;
}
@property (retain,nonatomic)UITableView *mGtableView;
@property (retain,nonatomic)NSMutableArray *mGmutArray;

@end
@implementation GAgencyPingLunController
@synthesize mGmutArray,mGtableView,gAgentId,gContentDic;
- (id)init
{
    self = [super init];
    if (self) {
		self.title = NSLocalizedString(@"代理机构评论",nil);
    }
    return self;
}
//释放网络请求
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
	UIView *tView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, Vheight-20)];
	self.view = tView;
	self.view.backgroundColor = Main_Color;
	[tView release];
	
	UITableView *gTAlerm = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, Vheight-64) style:UITableViewStylePlain];
	gTAlerm.backgroundColor = Main_Color;
	gTAlerm.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
	gTAlerm.delegate = self;
	gTAlerm.dataSource = self;
	self.mGtableView = gTAlerm;
	[self.view addSubview:self.mGtableView];
	[gTAlerm release];
}
//申请代理机构评论
#pragma mark - View lifecycle
-(IBAction)GPostSearchAgency:(NSString *)theTiao
{
	[self releaseSoap];
	mSoapHttp = [[SoapHttpManager alloc]init];
	mSoapHttp.delegate = self;
	mSoapHttp.OnSoapFail = @selector(GcanetFail);
	mSoapHttp.OnSoapRespond = @selector(GgetsearchAgencyData);
	NSString *TheToNum = [NSString stringWithFormat:@"%d",theTiao.intValue +10];
	NSDictionary *JsonDIc = [[NSDictionary alloc]initWithObjectsAndKeys:self.gAgentId,@"id",theTiao,@"from",TheToNum,@"to",LINK_PASSWORD,@"password",@"getCommentOfAgent",@"a",@"interface",@"m", nil];
	NSString *tString2 = [NSString stringWithFormat:@"%@%@%@",BASE_URL,@"&a=getCommentOfAgent&sid=",kkSessionID];
	NSString *tString3 = @"";
	[mSoapHttp PostSoadMessage:JsonDIc :tString2 :tString3];
	[JsonDIc release];
	[MBProgressHUD showHUDAddedTo:self.view animated:YES];
}
#pragma mark - View lifecycle
//评论代理机构兵打分
-(IBAction)GPostPingLunAgency:(NSString *)score AndInfo:(NSString *)content
{
	[self releaseSoap];
	mSoapHttp = [[SoapHttpManager alloc]init];
	mSoapHttp.delegate = self;
	mSoapHttp.OnSoapFail = @selector(GcanetFail);
	mSoapHttp.OnSoapRespond = @selector(GgetpingLunAgencyData);
	NSDictionary *JsonDIc = [[NSDictionary alloc]initWithObjectsAndKeys:self.gAgentId,@"id",content,@"info",score,@"score",LINK_PASSWORD,@"password",@"commentToAgent",@"a",@"interface",@"m", nil];
	NSString *tString2 = [NSString stringWithFormat:@"%@%@%@",BASE_URL,@"&a=commentToAgent&sid=",kkSessionID];	
	NSString *tString3 = @"";
	[mSoapHttp PostSoadMessage:JsonDIc :tString2 :tString3];
	[JsonDIc release];
	[MBProgressHUD showHUDAddedTo:self.view animated:YES];
}
-(void)gAddAlertView:(NSString *)message
{
	UIAlertView *tAlert = [[UIAlertView alloc]initWithTitle:@"" message:message delegate:nil cancelButtonTitle:NSLocalizedString(@"确定",nil) otherButtonTitles:nil];
	[tAlert show];
	[tAlert release];
	
}
- (void)viewDidLoad
{
    if ([[[UIDevice currentDevice]systemVersion]floatValue]>=7.0)
        self.edgesForExtendedLayout = UIRectEdgeNone;
	gFloa = 64;
	NSMutableArray * gA = [[NSMutableArray alloc]initWithCapacity:10];
	self.mGmutArray = gA;
	[gA release];
    [self GPostSearchAgency:@"0"];
    UIBarButtonItem *tabbar=[[UIBarButtonItem alloc]initWithTitle:NSLocalizedString(@"发送",nil) style:UIBarButtonItemStyleBordered target:self action:@selector(soap)];
	self.navigationItem.rightBarButtonItem = tabbar;
    [tabbar release];
}
-(void)soap
{
    [gAFooter soapToServer];
}
//获得关注数据
-(void)GgetsearchAgencyData
{
	[MBProgressHUD hideHUDForView:self.view animated:YES];
	if (mSoapHttp.mArray.count>1) {
		[mSoapHttp.mArray removeObjectAtIndex:0];
		[self.mGmutArray addObjectsFromArray:mSoapHttp.mArray];
		[self.mGtableView reloadData];
	}else{
//		[self gAddAlertView:[[mSoapHttp.mArray objectAtIndex:0]objectForKey:@"message"]];
	}
	
	[self releaseSoap];
}
//获得评论反馈
-(void)GgetpingLunAgencyData
{
	[MBProgressHUD hideHUDForView:self.view animated:YES];
	if (mSoapHttp.mArray.count>1) {
		[mSoapHttp.mArray removeObjectAtIndex:0];
		[self.mGmutArray addObjectsFromArray:mSoapHttp.mArray];
        [self releaseSoap];
	}else{
		NSString *aString;
		if ([[[mSoapHttp.mArray objectAtIndex:0]objectForKey:@"message"]length]==0) {
			if ([[[mSoapHttp.mArray objectAtIndex:0]objectForKey:@"status"]intValue]==0) {
				aString = NSLocalizedString(@"评论成功",nil);
			}else
				aString = NSLocalizedString(@"评论失败",nil);
		}else
			aString = [[mSoapHttp.mArray objectAtIndex:0]objectForKey:@"message"];
        [self.mGmutArray removeAllObjects];
        [self GPostSearchAgency:@"0"];
		[self gAddAlertView:aString];
        
	}
}
//tableViewDelegateMothd
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	if (self.mGmutArray.count==0) {
		return 0;
	}
	return self.mGmutArray.count%10==0?self.mGmutArray.count+1:self.mGmutArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	NSInteger row = indexPath.row;
	if (row<mGmutArray.count) {
		NSString *aString = [[self.mGmutArray objectAtIndex:row ] objectForKey:@"content"];
		CGSize size = [aString sizeWithFont:[UIFont systemFontOfSize:15.0] constrainedToSize:CGSizeMake(320, 1000) lineBreakMode:NSLineBreakByCharWrapping];
		if (size.height<20) {
			size.height = 20;
		}
		gFloa = gFloa +40+size.height;
		return 40+size.height;
	}
	
	return row==50;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSInteger row = indexPath.row;
	NSString *cellTableIdentifier = [NSString stringWithFormat:@"italicsCellTableIdentifier%d",row+TheRowNum];
	if (indexPath.row<self.mGmutArray.count) {
		PingLunCell *MACell = [tableView dequeueReusableCellWithIdentifier:cellTableIdentifier];
		if (MACell == nil) {
			MACell = [[[PingLunCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellTableIdentifier]autorelease];
			MACell.GcontentDic = [self.mGmutArray objectAtIndex:row];
			[MACell CellAddTextLabel];
		}		
		MACell.selectionStyle = UITableViewCellSelectionStyleNone;
		return MACell;
	}else{
		static NSString *cellTableIdentifier = @"italicsCellTableIdentifier";
		GLoadMoreTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellTableIdentifier];
		if (cell == nil) {
			
			cell = [[[GLoadMoreTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellTableIdentifier]autorelease];
			
		}
		cell.delegate = self;
		NSString *aStr = [NSString stringWithFormat:@"%d",indexPath.row];
		cell.mGStr = aStr;
		cell.mGLoadMore = @selector(gLoadMoreDate:);
		[cell gGetMoreFromServer];
		
		return cell;
	}

}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	return 70;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	PingLunHeaderView *GaHeader = [[[PingLunHeaderView alloc]initWithFrame:CGRectMake(0, 0, 320, 80)]autorelease];
	GaHeader.GcontentDic = self.gContentDic;
	[GaHeader CellAddTextLabel];
	return GaHeader;
	
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
	return 130;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
	gAFooter = [[[PingLunFootView alloc]initWithFrame:CGRectMake(0, 0, 320, 130)]autorelease];
	[gAFooter gAddButtonAndTextView];
	gAFooter.delegate = self;
	gAFooter.gSoapToServe = @selector(gSoapToServe:);
	gAFooter.gChangeFrame = @selector(gChangeFrame);
	return gAFooter;
}
-(void)gSoapToServe:(PingLunFootView *)aFooter
{
	self.mGtableView.center = CGPointMake(160, 230);
	[self GPostPingLunAgency:aFooter.pingFen AndInfo:aFooter.mGTextView.text];
}
//传键盘上升
-(void)gChangeFrame
{
	if (gFloa>Vheight-130-70) {
		self.mGtableView.frame =CGRectMake(0, -(Vheight-70-64), 320, Vheight);
        NSLog(@"Hei %f",gFloa);
	}else
//		self.mGtableView.center = CGPointMake(160, 208-(208-(266-gFloa)));
    {
	self.mGtableView.frame =CGRectMake(0, -(gFloa-70-64+130), 320, Vheight);
        NSLog(@"Hei LOW%f",gFloa);
    }
}
-(void)gLoadMoreDate:(GLoadMoreTableViewCell *)cell
{
	[self GPostSearchAgency:cell.mGStr];
	[self.mGtableView tableFooterView].frame = CGRectMake(110, 0, 320, 10);
}
//网络连接失败
-(void)GcanetFail
{
	[MBProgressHUD hideHUDForView:self.view animated:YES];
	[self gAddAlertView:NET_LINK_FAIL];
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
-(void)dealloc
{
	self.mGtableView = nil;
	self.mGmutArray = nil;
	self.gAgentId = nil;
	[super dealloc];
}
@end
