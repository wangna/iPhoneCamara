//
//  GNewDtailSearchTable.m
//  ZHUANLIJIANSUO
//
//  Created by chenhuiguo on 12-9-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "GNewDtailSearchTable.h"
#import "DetailPageCell.h"
#import "ResultPage.h"
#import "GDaiLiPingLunController.h"
#import "DetailTitleCell.h"
#import "GcustomToolBar.h"
#import "GsqrTableCell.h"
#import "GLoginViewController.h"
#import "NSString+SBJSON.h"
#import "LawViewController.h"
#import "SummaryViewController.h"
#import "ContentViewController.h"
#import "AppDelegate.h"
@interface GNewDtailSearchTable()
{
	SoapHttpManager *mSoapHttp;
	LoadView *mLoad;
	GcustomToolBar *tab;
	NSArray *aTitle;
	BOOL gSqr;
    AppDelegate *app;
}
@property(nonatomic,retain)UITableView *mgTableView;
@property(nonatomic,retain)NSMutableArray *aMutableArray;
@property(nonatomic,retain)NSDictionary *mGdiction;
@end
@implementation GNewDtailSearchTable
@synthesize mgTableView,aMutableArray,detailMess,sourceData,mGdiction,arrData,gZhuanli;
-(id)init
{
	if (self = [super init]) {
		self.title = NSLocalizedString(@"专利详情",nil);
		NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
		self.sourceData =[user objectForKey:@"strSources"];
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

-(void)gAddAlertView
{
    UIAlertView *tAlert = [[UIAlertView alloc]initWithTitle:@"" message:NSLocalizedString(@"您还未登录！请先登录",nil) delegate:self cancelButtonTitle:NSLocalizedString(@"取消",ni
                                                                                                                                                               )otherButtonTitles:NSLocalizedString(@"登录",nil), nil];
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
	self.navigationController.navigationBarHidden = NO;
	[tView release];
	
	UITableView *gTAlerm = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, Vheight-102) style:UITableViewStylePlain];
	gTAlerm.backgroundColor = Main_Color;
	gTAlerm.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
	gTAlerm.delegate = self;
	gTAlerm.dataSource= self;
	self.mgTableView = gTAlerm;
	[self.view addSubview:self.mgTableView];
	[gTAlerm release];

}
-(void)releaseTabbarButton
{
	if (tab) {
		[tab removeFromSuperview];
		tab = nil;
	}
}
-(void)gAddTabBarAllButton
{
	[self releaseTabbarButton];
	tab = [[GcustomToolBar alloc]initWithFrame:CGRectMake(0, Vheight-104, 320, 40)];
  
	[self.view addSubview:tab];
      NSLog(@"tab  ++++%d",[tab retainCount]);
	[tab release];
	UIBarButtonItem *gEditBtn = [[UIBarButtonItem alloc]initWithTitle:NSLocalizedString(@"收藏",nil) style:UIBarButtonItemStyleBordered target:self action:@selector(gEditTableView)];
    if (gZhuanli) {
        [gEditBtn setTitle:@"取消收藏"];
    }
    else [gEditBtn setTitle:@"收藏"];
//    gEditBtn.width=73;
	
	UIBarButtonItem *gLawBtn = [[UIBarButtonItem alloc]initWithTitle:NSLocalizedString(@"法律状态",nil) style:UIBarButtonItemStyleBordered target:self action:@selector(gLaw)];
   

	UIBarButtonItem *gcontentBtn=[[UIBarButtonItem alloc]initWithTitle:NSLocalizedString(@"全文",nil) style:UIBarButtonItemStyleBordered target:self action:@selector(gContent)];
    
	UIBarButtonItem *gSummaryBtn=[[UIBarButtonItem alloc]initWithTitle:NSLocalizedString(@"摘要附图",nil) style:UIBarButtonItemStyleBordered target:self action:@selector(gSummary)];
    
	UIBarButtonItem *gPingLunBt = [[UIBarButtonItem alloc]initWithTitle:NSLocalizedString(@"评论",nil) style:UIBarButtonItemStyleBordered target:self action:@selector(gPingLun)];
    gPingLunBt.width=40;
	UIBarButtonItem *aSpaceItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:@selector(Settting:)];
	if ([[[UIDevice currentDevice]systemVersion]floatValue]>=7.0) {
        [gLawBtn setTintColor:[UIColor whiteColor]];
        [gcontentBtn setTintColor:[UIColor whiteColor]];
        [gSummaryBtn setTintColor:[UIColor whiteColor]];
        [gEditBtn setTintColor:[UIColor whiteColor]];
        [gPingLunBt setTintColor:[UIColor whiteColor]];
    }
	NSArray *abutArray = [NSArray arrayWithObjects:gLawBtn,gcontentBtn,gSummaryBtn,gEditBtn,gPingLunBt,nil];
	tab.items = abutArray;
	[gEditBtn release];
    [gLawBtn release];
    [gcontentBtn release];
    [gSummaryBtn release];
	[gPingLunBt release];
	[aSpaceItem release];
	
}
//取消专利关注button
-(void)gAddTabBarAllButtonCancelZhuanLi
{
	[self releaseTabbarButton];
	tab = [[GcustomToolBar alloc]initWithFrame:CGRectMake(0, Vheight-104, 320, 40)];
	[self.view addSubview:tab];
	[tab release];
	UIBarButtonItem *gEditBtn = [[UIBarButtonItem alloc]initWithTitle:NSLocalizedString(@"取消收藏",nil) style:UIBarButtonItemStyleBordered target:self action:@selector(GCancelTheZhuanli)];
//    gEditBtn.width=73;
	
	UIBarButtonItem *gLawBtn = [[UIBarButtonItem alloc]initWithTitle:NSLocalizedString(@"法律状态",nil) style:UIBarButtonItemStyleBordered target:self action:@selector(gLaw)];
	UIBarButtonItem *gcontentBtn=[[UIBarButtonItem alloc]initWithTitle:NSLocalizedString(@"全文",nil) style:UIBarButtonItemStyleBordered target:self action:@selector(gContent)];
    
	UIBarButtonItem *gSummaryBtn=[[UIBarButtonItem alloc]initWithTitle:NSLocalizedString(@"摘要附图",nil) style:UIBarButtonItemStyleBordered target:self action:@selector(gSummary)];
    
	UIBarButtonItem *gPingLunBt = [[UIBarButtonItem alloc]initWithTitle:NSLocalizedString(@"评论",nil) style:UIBarButtonItemStyleBordered target:self action:@selector(gPingLun)];
	gPingLunBt.width=40;
	UIBarButtonItem *aSpaceItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:@selector(Settting:)];
	
	NSArray *abutArray = [NSArray arrayWithObjects:gLawBtn,gcontentBtn,gSummaryBtn,gEditBtn,gPingLunBt ,nil];
	tab.items = abutArray;
	
	[gEditBtn release];
    [gcontentBtn release];
    [gSummaryBtn release];
    [gLawBtn release];
	[gPingLunBt release];
	[aSpaceItem release];
	
}
//取消专利申请人关注button
-(void)gAddCancelSqrTaBbarButton{
	[self releaseTabbarButton];
	tab = [[GcustomToolBar alloc]initWithFrame:CGRectMake(0, Vheight-104, 320, 40)];
	[self.view addSubview:tab];
	[tab release];
	UIBarButtonItem *gEditBtn = [[UIBarButtonItem alloc]initWithTitle:@"专利关注" style:UIBarButtonItemStyleBordered target:self action:@selector(gEditTableView)];
	
//	
//	UIBarButtonItem *gFinishBtn = [[UIBarButtonItem alloc]initWithTitle:@"取消关注的申请人" style:UIBarButtonItemStyleBordered target:self action:@selector(GCancelTheSqr)];
	
	
	UIBarButtonItem *gPingLunBt = [[UIBarButtonItem alloc]initWithTitle:@"评论" style:UIBarButtonItemStyleBordered target:self action:@selector(gPingLun)];
	
	UIBarButtonItem *aSpaceItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:@selector(Settting:)];
	
	NSArray *abutArray = [[NSArray alloc]initWithObjects:gPingLunBt,aSpaceItem,gEditBtn ,nil];
	tab.items = abutArray;
	[abutArray release];
	[gEditBtn release];
//	[gFinishBtn release];
	[gPingLunBt release];
	[aSpaceItem release];
	
}
//取消专利申请人关注button
-(void)gAddCancelSqrAndCancelZhuanLi{
	[self releaseTabbarButton];
	tab = [[GcustomToolBar alloc]initWithFrame:CGRectMake(0, Vheight-104, 320, 40)];
	[self.view addSubview:tab];
	[tab release];
	UIBarButtonItem *gEditBtn = [[UIBarButtonItem alloc]initWithTitle:NSLocalizedString(@"取消收藏",nil) style:UIBarButtonItemStyleBordered target:self action:@selector(GCancelTheZhuanli)];
	
	
//	UIBarButtonItem *gFinishBtn = [[UIBarButtonItem alloc]initWithTitle:@"取消关注的申请人" style:UIBarButtonItemStyleBordered target:self action:@selector(GCancelTheSqr)];
	
	
	UIBarButtonItem *gPingLunBt = [[UIBarButtonItem alloc]initWithTitle:NSLocalizedString(@"评论",nil) style:UIBarButtonItemStyleBordered target:self action:@selector(gPingLun)];
	
	UIBarButtonItem *aSpaceItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:@selector(Settting:)];
	
	NSArray *abutArray = [[NSArray alloc]initWithObjects:gPingLunBt,aSpaceItem,gEditBtn ,nil];
	tab.items = abutArray;
	[abutArray release];
	[gEditBtn release];
//	[gFinishBtn release];
	[gPingLunBt release];
	[aSpaceItem release];
	
}

//申请人是否被关注
-(IBAction)ifThetGuanZhuSqr
{
	[self releaseSoap];
	mSoapHttp = [[SoapHttpManager alloc]init];
	mSoapHttp.delegate = self;
	mSoapHttp.OnSoapFail = @selector(GcanetFail);
	mSoapHttp.OnSoapRespond = @selector(GgetapplicantIsAttentionData);
	NSDictionary *JsonDIc = [[NSDictionary alloc]initWithObjectsAndKeys:[self.mGdiction objectForKey:@"pa"],@"applicant",LINK_PASSWORD,@"password",@"applicantIsAttention",@"a",@"interface",@"m", nil];
	NSString *tString2 = [NSString stringWithFormat:@"%@%@%@",BASE_URL,@"&a=applicantIsAttention&sid=",kkSessionID];	
	NSString *tString3 = @"";
	[mSoapHttp PostSoadMessage:JsonDIc :tString2 :tString3];
	[JsonDIc release];
	[MBProgressHUD showHUDAddedTo:app.window animated:YES];
	
}
-(void)GgetapplicantIsAttentionData
{
	[MBProgressHUD hideHUDForView:app.window animated:YES];
	if ([[[mSoapHttp.mArray objectAtIndex:0]objectForKey:@"status"]isEqualToString:@"0"]) {
		NSArray *tArray = [[[mSoapHttp.mArray objectAtIndex:0]objectForKey:@"message"] componentsSeparatedByString:@":"];
		if ([[tArray objectAtIndex:1]intValue]>0) {
		gSqr = YES;
		if (gZhuanli) {
			[self gAddCancelSqrAndCancelZhuanLi];
		}else
			[self gAddCancelSqrTaBbarButton];
		[self.mgTableView reloadData];
		}
	}
	[self releaseSoap];
}
//专利是否被关注
-(IBAction)ifTheGuanZhupation
{
	[self releaseSoap];
	mSoapHttp = [[SoapHttpManager alloc]init];
	mSoapHttp.delegate = self;
	mSoapHttp.OnSoapFail = @selector(GcanetFail);
	mSoapHttp.OnSoapRespond = @selector(GgetpatentIsAttentionData);
	NSString *aStr = [NSString stringWithFormat:@"%@:%@",[self.mGdiction objectForKey:@"an"],[self.mGdiction objectForKey:@"pnm"]];
	NSDictionary *JsonDIc = [[NSDictionary alloc]initWithObjectsAndKeys:aStr,@"patent",LINK_PASSWORD,@"password",@"patentIsAttention",@"a",@"interface",@"m", nil];
	NSString *tString2 = [NSString stringWithFormat:@"%@%@%@",BASE_URL,@"&a=patentIsAttention&sid=",kkSessionID];	
	NSString *tString3 = @"";
	[mSoapHttp PostSoadMessage:JsonDIc :tString2 :tString3];
	[JsonDIc release];
	[MBProgressHUD showHUDAddedTo:app.window animated:YES];
	
}
-(void)GgetpatentIsAttentionData
{
	[MBProgressHUD hideHUDForView:app.window animated:YES];
	if ([[[mSoapHttp.mArray objectAtIndex:0]objectForKey:@"status"]isEqualToString:@"0"]) {
		NSArray *tArray = [[[mSoapHttp.mArray objectAtIndex:0]objectForKey:@"message"] componentsSeparatedByString:@":"];
		if ([[tArray objectAtIndex:2]intValue]>0) {
		gZhuanli = YES;	
		if (gSqr) {
			[self gAddCancelSqrAndCancelZhuanLi];
		}else
			[self gAddTabBarAllButtonCancelZhuanLi];
		[self.mgTableView reloadData];
		}
	}
	[self releaseSoap];
	[self ifThetGuanZhuSqr];
}

#pragma mark-Server

//请求专利搜索接口
-(void)GpostToServer
{
	[self releaseSoap];
    mSoapHttp = [[SoapHttpManager alloc]init];
    mSoapHttp.delegate = self;
    mSoapHttp.OnSoapFail = @selector(GcanetFail);
    mSoapHttp.OnSoapRespond = @selector(GgetData);
	if (self.sourceData==nil) {
		self.sourceData = @"FMZL,SYXX,WGZL";
	}
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    NSString *DID=[user objectForKey:@"DID"];
    NSDictionary *JsonDIc = [[NSDictionary alloc]initWithObjectsAndKeys:self.detailMess,@"strWhere",@"",@"strSortMethod",@"2",@"iOption",@"0",@"recordCursor",@"",@"strSynonymous",self.sourceData,@"strSources",DID,@"strImei", nil];
	NSString *tString2 = [NSString stringWithFormat:@"http://59.151.99.154:8080/pss-mp/pds"];
	NSString *tString3 = @"";
	[mSoapHttp PostSoadMessage:JsonDIc :tString2 :tString3];
	[JsonDIc release];
	[MBProgressHUD showHUDAddedTo:app.window animated:YES];
}

-(IBAction)GgetData
{
	[MBProgressHUD hideHUDForView:app.window animated:YES];
	if (mSoapHttp.mArray.count>1) {
		self.mGdiction = [mSoapHttp.mArray objectAtIndex:1];
        NSLog(@"self.mGdiction+++%@",self.mGdiction);
		
		NSMutableArray *aMutabe = [[NSMutableArray alloc]initWithObjects:[self.mGdiction objectForKey:@"name"],[self.mGdiction objectForKey:@"an"],[self.mGdiction objectForKey:@"ad"],[self.mGdiction objectForKey:@"pnm"],[self.mGdiction objectForKey:@"pd"],[self.mGdiction objectForKey:@"pr"],[self.mGdiction objectForKey:@"pa"],[self.mGdiction objectForKey:@"ar"],[self.mGdiction objectForKey:@"pin"],[self.mGdiction objectForKey:@"agc"],[self.mGdiction objectForKey:@"agt"],[self.mGdiction objectForKey:@"sic"],[self.mGdiction objectForKey:@"pic"],[self.mGdiction objectForKey:@"co"],[self.mGdiction objectForKey:@"ab"],[self.mGdiction objectForKey:@"cl"], nil];
		self.aMutableArray = aMutabe ;
        NSLog(@"aMutableArray++%@",self.aMutableArray);
		[aMutabe release];
		[self.mgTableView reloadData];
	}
   
}


- (void)viewDidLoad
{
    if ([[[UIDevice currentDevice]systemVersion]floatValue]>=7.0)
        self.edgesForExtendedLayout = UIRectEdgeNone;
	tab = nil;
	gSqr = NO;
//	aTitle = [[NSArray alloc]initWithObjects:@"名称",@"申请号",@"公开（公告）日",@"主分类号",@"公开（公告）号",@"申请（专利权）人",@"申请日",@"地址",@"分类号",@"优先权",@"国省代码",@"代理机构",@"代理人",@"摘要",@"主权项",nil ];
    aTitle = [[NSArray alloc]initWithObjects:@"名称",@"申请号",@"申请日",@"公开（公告）号",@"公开（公告）日",@"优先权",@"申请（专利权）人",@"地址",@"发明（设计）人",@"专利代理机构",@"代理人",@"分类号",@"主分类号",@"国省代码",@"摘要",@"主权项",nil ];
	mSoapHttp = nil;
	mLoad = nil;
    app=(AppDelegate *)[UIApplication sharedApplication].delegate;
	[self GpostToServer];
	[self gAddTabBarAllButton];
    [super viewDidLoad];
	UIBarButtonItem *rightButnItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"Gfirst.png"] style:UIBarButtonItemStyleBordered target:self action:@selector(SelfPopToROOtViewControl)];
    self.navigationItem.rightBarButtonItem = rightButnItem;
	[rightButnItem release];
	
}
-(void)SelfPopToROOtViewControl
{
	[self.navigationController popToRootViewControllerAnimated:YES];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.aMutableArray.count==0) {
        return 0;
    }
    return self.aMutableArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (indexPath.row==0) {
		CGSize size = [[self.aMutableArray objectAtIndex:indexPath.row] sizeWithFont:[UIFont systemFontOfSize:16.4] constrainedToSize:CGSizeMake(275, 1000) lineBreakMode:NSLineBreakByCharWrapping];
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
		return 25+size.height;
	}
	
    CGSize detailSize =  [[self.aMutableArray objectAtIndex:indexPath.row] sizeWithFont:[UIFont boldSystemFontOfSize:14] constrainedToSize:CGSizeMake(305, 4000) lineBreakMode:NSLineBreakByCharWrapping];
    if (indexPath.row>13) {
        return detailSize.height+45;
    }
    return detailSize.height+30;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *m= [NSString stringWithFormat:@"aDetailsearch%d",indexPath.row];
	
	if (indexPath.row==0) {
		DetailTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:m];
		cell.selected=NO;
		if (cell == nil) {
			cell = [[DetailTitleCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:m];
			cell.gTitle = [self.aMutableArray objectAtIndex:indexPath.row];
			cell.gScore = [[self.mGdiction objectForKey:@"gpa"]floatValue];
            [cell setBackgroundColor:Main_Color];
			[cell gAddTitleLabel];
            

		}
		if (gZhuanli) {
			cell.ifLiang.image = [UIImage imageNamed:@"ziXing.png"];
		}else
			cell.ifLiang.image = [UIImage imageNamed:@"wuL.png"];
		
			cell.selectionStyle = UITableViewCellSelectionStyleNone;
		
		return cell;
//	}else if (indexPath.row>0&&indexPath.row!=5) {
    }else if(indexPath.row>0){
		DetailPageCell *cell = [tableView dequeueReusableCellWithIdentifier:m];
		
		
		if (cell == nil) {
			cell = [[[DetailPageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:m]autorelease];
			cell.valueString = [self.aMutableArray objectAtIndex:indexPath.row];
			cell.titleLabel = NSLocalizedString([aTitle objectAtIndex:indexPath.row],nil);
			cell.valueLabel = [self.aMutableArray objectAtIndex:indexPath.row];
			[cell addTheDetailData];
		}
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
		if(indexPath.row<14){
			cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
		}
		
		return cell;
	}
//申请人一行，申请人可收藏，带星
//			GsqrTableCell *cell = [tableView dequeueReusableCellWithIdentifier:m];
//			if (cell == nil) {
//				cell = [[GsqrTableCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:m];
//			}
//		cell.valueString = [self.aMutableArray objectAtIndex:indexPath.row];
//		cell.titleLabel = NSLocalizedString([aTitle objectAtIndex:indexPath.row],nil);
//		cell.valueLabel = [self.aMutableArray objectAtIndex:indexPath.row];
//		cell.ifLiang = gSqr;
//		[cell addTheDetailData];
//    if (indexPath.row!=0) {
//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//		cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    }
//		
//		return cell;
		
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (indexPath.row>13||indexPath.row==0) {
		return;
	}
	if (indexPath.row==1||indexPath.row==3||indexPath.row==11||indexPath.row==12) {
		NSString *mes0 = [aTitle objectAtIndex:indexPath.row];
		NSArray *strArray = [[self.aMutableArray objectAtIndex:indexPath.row]componentsSeparatedByString:@";"];
		NSString *gLinshi;
        NSMutableArray *tArray = [[NSMutableArray alloc]initWithCapacity:10];
		if (strArray&&strArray.count>0) {
            for (int i = 0; i<strArray.count; i++) {
                NSString *aTs = [NSString stringWithFormat:@"%@%@%@%@%@%@",mes0,@"=",@"'",@"%25",[strArray objectAtIndex:i],@"'"] ;
                [tArray addObject:aTs];
            }
			gLinshi = [tArray componentsJoinedByString:@" or "];
		}else
			gLinshi = [NSString stringWithFormat:@"%@%@%@%@%@%@",mes0,@"=",@"'",@"%25",[self.aMutableArray objectAtIndex:indexPath.row],@"'"];
        
//        NSArray *tAr1 = [gLinshi componentsSeparatedByString:@"("];
//        if (tAr1.count>1) {
//            NSString *astr1 = [tAr1 objectAtIndex:1];
//            NSArray *tAr2 = [astr1 componentsSeparatedByString:@")"];
//            gLinshi = [NSString stringWithFormat:@"%@%@%@",@"%28",[tAr2 objectAtIndex:0],@"%29"];
//        }
//		NSString *mes1 = [NSString stringWithFormat:@"%@",gLinshi];
//		
//		NSString *mess2 = [[mes0 stringByAppendingString:@"%3D%25"] stringByAppendingString:gLinshi];
//
//        ///////
//        NSString *mess2 = [NSString stringWithFormat:@"%@%@%@%@%@",mes0,@"%3D",@"%",mes1,@"%"];
        ///////
		[self.mgTableView deselectRowAtIndexPath:indexPath animated:YES];
		ResultPage *result = [[ResultPage alloc]init];
		result.msg = gLinshi;
        [tArray release];
		[self.navigationController pushViewController:result animated:YES];
		[result release];
		return;
	}
	
    NSString *mes0 = [aTitle objectAtIndex:indexPath.row];
	NSArray *strArray = [[self.aMutableArray objectAtIndex:indexPath.row]componentsSeparatedByString:@";"];
	NSString *gLinshi;
    NSMutableArray *tArray = [[NSMutableArray alloc]initWithCapacity:10];
    if (strArray&&strArray.count>0) {
        for (int i = 0; i<strArray.count; i++) {
            NSString *aTs = [NSString stringWithFormat:@"%@%@%@%@%@",mes0,@"=",@"'",[strArray objectAtIndex:i],@"'"] ;
            [tArray addObject:aTs];
        }
        gLinshi = [tArray componentsJoinedByString:@" or "];
    }else
        gLinshi = [NSString stringWithFormat:@"%@%@%@%@%@",mes0,@"=",@"'",[self.aMutableArray objectAtIndex:indexPath.row],@"'"];
//	if (strArray&&strArray.count>0) {
//		gLinshi = [strArray objectAtIndex:0];
//	}else
//		gLinshi = [self.aMutableArray objectAtIndex:indexPath.row];
//
//    NSArray *tAr1 = [gLinshi componentsSeparatedByString:@"("];
//    if (tAr1.count>1) {
//        NSString *astr1 = [tAr1 objectAtIndex:1];
//        NSArray *tAr2 = [astr1 componentsSeparatedByString:@")"];
//        gLinshi = [NSString stringWithFormat:@"%@%@%@",@"%28",[tAr2 objectAtIndex:0],@"%29"];
//    }
//
//    
////    NSString *mes1 = [self.aMutableArray objectAtIndex:indexPath.row];
//	
////	NSString *mess2 = [[mes0 stringByAppendingString:@"%3D"] stringByAppendingString:gLinshi];
//    
//    //////////
//    NSString *mess2 = [NSString stringWithFormat:@"%@%@%@",mes0,@"%3D",gLinshi];
    //////////
    
    [self.mgTableView deselectRowAtIndexPath:indexPath animated:YES];
    ResultPage *result = [[ResultPage alloc]init];
    result.msg = gLinshi;
    [self.navigationController pushViewController:result animated:YES];
    [tArray release];
    [result release];
}

//关注专利
-(IBAction)GPostGuanZhuZhuanli
{
	[self releaseSoap];
	mSoapHttp = [[SoapHttpManager alloc]init];
	mSoapHttp.delegate = self;
    mSoapHttp.view=app.window;
	NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    NSString *nameID=[user objectForKey:@"DID"];
    NSDictionary *JsonDic;
    NSString *tString2;
    //取消收藏专利
    if (gZhuanli) {
        gZhuanli=NO;
        mSoapHttp.OnSoapFail = @selector(GcanetFail);
        mSoapHttp.OnSoapRespond = @selector(GgetguanzhuData);
        JsonDic=[NSDictionary dictionaryWithObjectsAndKeys:nameID,@"userid",[self.mGdiction objectForKey:@"an"],@"an",nil];
        tString2=[NSString stringWithFormat: @"%@",@"http://59.151.99.154:8080/dsqb/ccps"];    }
    //收藏专利
    else
    {
        gZhuanli=YES;
        mSoapHttp.OnSoapFail = @selector(GcanetFail);
        mSoapHttp.OnSoapRespond = @selector(GgetguanzhuData);
        NSArray *arr=[[self.mGdiction objectForKey:@"pnm"] componentsSeparatedByString:@"("];
        NSString *name=[[[self.mGdiction objectForKey:@"name"]componentsSeparatedByString:@" ～lt;"]objectAtIndex:0];
        NSString *nameSource=[NSString stringWithFormat:@"%@source等于%@",name,self.sourceData];
        JsonDic=[NSDictionary dictionaryWithObjectsAndKeys:nameID,@"userid",[self.mGdiction objectForKey:@"an"],@"an",nameSource,@"name",[arr objectAtIndex:0],@"pnm",[self.mGdiction objectForKey:@"pa"],@"applicant",@"tags",@"tags",nil];
        tString2 = [NSString stringWithFormat:@"http://59.151.99.154:8080/dsqb/cpse"];
        
    }
	NSString *tString3 = @"";
	[mSoapHttp PostSoadMessage:JsonDic :tString2 :tString3];
	[MBProgressHUD showHUDAddedTo:app.window animated:YES];}
-(void)GgetguanzhuData
{
	
	[MBProgressHUD hideHUDForView:app.window animated:YES];
    NSInteger success=[[[mSoapHttp.jsonStr JSONValue]objectForKey:@"bool"]integerValue];
	
    
    [self gAddTabBarAllButton];
    [self.mgTableView reloadData];
}
//关注申请人
-(IBAction)GPostGuanZhuSqr
{
	[self releaseSoap];
	mSoapHttp = [[SoapHttpManager alloc]init];
	mSoapHttp.delegate = self;
	mSoapHttp.OnSoapFail = @selector(GcanetFail);
	mSoapHttp.OnSoapRespond = @selector(GgetshenqingrenData);
	NSDictionary *JsonDIc = [[NSDictionary alloc]initWithObjectsAndKeys:[self.mGdiction objectForKey:@"pa"],@"applicant",LINK_PASSWORD,@"password",@"payAttentionToApplicant",@"a",@"interface",@"m", nil];
	NSString *tString2 = [NSString stringWithFormat:@"%@%@%@",BASE_URL,@"&a=payAttentionToApplicant&sid=",kkSessionID];	
	NSString *tString3 = @"";
	[mSoapHttp PostSoadMessage:JsonDIc :tString2 :tString3];
	[JsonDIc release];
	[MBProgressHUD showHUDAddedTo:app.window animated:YES];
}
-(void)GgetshenqingrenData
{
	[MBProgressHUD hideHUDForView:app.window animated:YES];
	if ([[[mSoapHttp.mArray objectAtIndex:0]objectForKey:@"status"]isEqualToString:@"0"]) {
		gSqr = YES;	
		if (gZhuanli) {
			[self gAddCancelSqrAndCancelZhuanLi];
		}else
			[self gAddCancelSqrTaBbarButton];
		[self.mgTableView reloadData];
	}else{
		UIAlertView *tAlert = [[UIAlertView alloc]initWithTitle:@"" message:@"您已经关注过改申请人" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
		[tAlert show];
		[tAlert release];
	}
}
-(IBAction)GcanetFail
{
	[MBProgressHUD hideHUDForView:app.window animated:YES];
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:NSLocalizedString(@"网络连接失败！",nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"确定",nil) otherButtonTitles:nil];
    [alert show];
    [alert release];
}
#pragma mark-action
-(void)gLaw
{
    
        NSString *paNum=[self.aMutableArray objectAtIndex:1];
        paNum=[paNum stringByReplacingOccurrencesOfString:@"CN" withString:@""];
        NSArray *arrBefore=[paNum componentsSeparatedByString:@"."];
        paNum=[NSString stringWithFormat:@"%@%@%@",@"%25",[arrBefore objectAtIndex:0],@"%25"];
        NSString *lawMess=[NSString stringWithFormat:@"%@=%@",[aTitle objectAtIndex:1],paNum];
        NSLog(@"Law++%@=%@",[aTitle objectAtIndex:1],[self.aMutableArray objectAtIndex:1]);
        [self releaseSoap];
        mSoapHttp = [[SoapHttpManager alloc]init];
        mSoapHttp.delegate = self;
         mSoapHttp.view=app.window;
        mSoapHttp.OnSoapFail = @selector(GcanetFail);
        mSoapHttp.OnSoapRespond = @selector(GgetJson);
        if (self.sourceData==nil) {
            self.sourceData = @"FMZL,SYXX,WGZL";
        }
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    NSString *DID=[user objectForKey:@"DID"];
        NSDictionary *JsonDIc = [[NSDictionary alloc]initWithObjectsAndKeys:lawMess,@"strWhere",DID,@"strImei",nil];
        NSString *tString2 = [NSString stringWithFormat:@"http://59.151.99.154:8080/pss-mp/getLegalStatus"];
        NSString *tString3 = @"";
        [mSoapHttp PostSoadMessage:JsonDIc :tString2 :tString3];
        [JsonDIc release];
        [MBProgressHUD showHUDAddedTo:app.window animated:YES];
 
}
-(void)GgetJson
{
    [MBProgressHUD hideHUDForView:app.window animated:YES];
    self.arrData=[mSoapHttp.jsonStr JSONValue];
    NSLog(@"arrdata++%@",arrData);
    LawViewController *lawView=[[LawViewController alloc]init];
    [lawView add];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"LAW" object:self.arrData];
    [self.navigationController pushViewController:lawView animated:YES];
    [lawView release];
}
-(void)gEditTableView
{
    [self GPostGuanZhuZhuanli];

}
-(void)gFinishEditTableView
{
    if (kkSessionID.length>0) {
        [self GPostGuanZhuSqr];
    }else{
        [self gAddAlertView];
    }
	
}
-(void)gPingLun
{
   
        if (kkSessionID.length>0) {
            GDaiLiPingLunController *aZhuanliPingLun = [[GDaiLiPingLunController alloc]init];
            aZhuanliPingLun.gContentDic = self.mGdiction;
            aZhuanliPingLun.gAgentId = [self.mGdiction objectForKey:@"id"];
            [self.navigationController pushViewController:aZhuanliPingLun animated:YES];
            [aZhuanliPingLun release];
        }else{
            [self gAddAlertView];
        }
   
}
-(void)gContent
{
   
        //获取专利全文
        //    app = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [MBProgressHUD showHUDAddedTo:app.window animated:YES];
        
        //[MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [self action];
   


}
-(void)action
{
    [NSThread detachNewThreadSelector:@selector(downTmp) toTarget:self withObject:nil];
    [self performSelector:@selector(content) withObject:nil afterDelay:2];
}
-(void)content
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // Do time-consuming task in background thread
        // Return back to main thread to update UI
        dispatch_sync(dispatch_get_main_queue(), ^{
        NSString *pages=[self.mGdiction objectForKey:@"pages"];
        ContentViewController *contentView=[[[ContentViewController alloc]init]autorelease];
            contentView.appID=[self.mGdiction objectForKey:@"an"];
            contentView.pageCount=[pages integerValue];
        //   [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self.navigationController pushViewController:contentView animated:YES];
        });
    });
}
-(void)downTmp
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // Do time-consuming task in background thread
        // Return back to main thread to update UI
        dispatch_sync(dispatch_get_main_queue(), ^{
            NSString *pages=[self.mGdiction objectForKey:@"pages"];
            NSString *content=[self.mGdiction objectForKey:@"pngPath"];
            NSString *appAN=[self.mGdiction objectForKey:@"an"];
            for (int i=0; i<[pages integerValue]; i++) {
                NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                NSString *documentsDirectory=[paths objectAtIndex:0];
                NSString *path=@"";
                
                path=[NSString stringWithFormat:@"%@/%06d.PNG",content,i+1];
                
                NSLog(@"path++%@",path);
                NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:path]];
                
                UIImage *image= [UIImage imageWithData:imageData];
                [UIImagePNGRepresentation(image) writeToFile:[documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"/%@_%d.PNG",appAN,i+1]] atomically:YES];
                
            }
        });
    });
}
-(void)gSummary
{
   
        //获取摘要附图
        NSLog(@"button");
        [MBProgressHUD showHUDAddedTo:app.window animated:YES];
        [self performSelector:@selector(Sum) withObject:nil afterDelay:0.5];
  
    
}
-(void)Sum
{
    NSString *strPng=[self.mGdiction objectForKey:@"abpicpath"];
    SummaryViewController *sumView=[[[SummaryViewController alloc]init]autorelease];
    [sumView add];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"PNG" object:strPng];
    [self.navigationController pushViewController:sumView animated:YES];
}
//取消关注申请人
//-(IBAction)GCancelTheSqr
//{
//	[self releaseSoap];
//	mSoapHttp = [[SoapHttpManager alloc]init];
//	mSoapHttp.delegate = self;
//	mSoapHttp.OnSoapFail = @selector(GcanetFail);
//	mSoapHttp.OnSoapRespond = @selector(GgetCanceshenqingrenData);
//	NSDictionary *JsonDIc = [[NSDictionary alloc]initWithObjectsAndKeys:[self.mGdiction objectForKey:@"pa"],@"applicant",LINK_PASSWORD,@"password",@"cancelAttentionToApplicant",@"a",@"interface",@"m", nil];
//	NSString *tString2 = [NSString stringWithFormat:@"%@%@%@",BASE_URL,@"&a=cancelAttentionToApplicant&sid=",kkSessionID];	
//	NSString *tString3 = @"";
//	[mSoapHttp PostSoadMessage:JsonDIc :tString2 :tString3];
//	[JsonDIc release];
//	[MBProgressHUD showHUDAddedTo:self.view animated:YES];
//}
//-(void)GgetCanceshenqingrenData
//{
//	[MBProgressHUD hideHUDForView:self.view animated:YES];
//	if ([[[mSoapHttp.mArray objectAtIndex:0]objectForKey:@"status"]isEqualToString:@"0"]) {
//		gSqr = NO;	
//		if (!gZhuanli) {
//			[self gAddTabBarAllButton];
//		}else
//			[self gAddTabBarAllButtonCancelZhuanLi];
//		[self.mgTableView reloadData];
//	}
//
//}
//取消关注的专利
-(IBAction)GCancelTheZhuanli
{
	[self releaseSoap];
	mSoapHttp = [[SoapHttpManager alloc]init];
	mSoapHttp.delegate = self;
	mSoapHttp.OnSoapFail = @selector(GcanetFail);
	mSoapHttp.OnSoapRespond = @selector(GgetCancelZhuanLiData);
	NSString *aStr = [NSString stringWithFormat:@"%@:%@",[self.mGdiction objectForKey:@"an"],[self.mGdiction objectForKey:@"pnm"]];
	NSDictionary *JsonDIc = [[NSDictionary alloc]initWithObjectsAndKeys:aStr,@"patent",LINK_PASSWORD,@"password",@"cancelAttentionToPatent",@"a",@"interface",@"m", nil];
	NSString *tString2 = [NSString stringWithFormat:@"%@%@%@",BASE_URL,@"&a=cancelAttentionToPatent&sid=",kkSessionID];	
	NSString *tString3 = @"";
	[mSoapHttp PostSoadMessage:JsonDIc :tString2 :tString3];
	[JsonDIc release];
	[MBProgressHUD showHUDAddedTo:app.window animated:YES];
}
-(void)GgetCancelZhuanLiData
{
	[MBProgressHUD hideHUDForView:app.window animated:YES];
	if ([[[mSoapHttp.mArray objectAtIndex:0]objectForKey:@"status"]isEqualToString:@"0"]) {
		gZhuanli = NO;	
		if (!gSqr) {
			[self gAddTabBarAllButton];
		}else
			[self gAddCancelSqrTaBbarButton];
		[self.mgTableView reloadData];
	}

}
-(void)viewWillDisappear:(BOOL)animated
{
//    [MBProgressHUD hideHUDForView:app.window animated:YES];
    
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
	[self releaseSoap];
	[super dealloc];
}
@end
