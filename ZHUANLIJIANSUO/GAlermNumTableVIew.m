//
//  GAlermNumTableVIew.m
//  ZHUANLIJIANSUO
//
//  Created by chenhuiguo on 12-8-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "GAlermNumTableVIew.h"
#import "DetailAlermTableView.h"
#import "GAlermTableCell.h"
#import "GcustomToolBar.h"
#import "GAlermHeaderView.h"
#import "GLoadMoreTableViewCell.h"
@interface GAlermNumTableVIew()
{
	LoadView *mLoad;
	SoapHttpManager *mSoapHttp;
	GcustomToolBar *tab;
	UIButton *GallSelected;
	NSMutableArray *GDeleteArray;

}
@property(retain,nonatomic)UITableView *mgTableView;
@property(retain,nonatomic)NSMutableArray *mGAlermArray;
@property(retain,nonatomic)NSMutableArray *mGTableDisplay;
@end

@implementation GAlermNumTableVIew
@synthesize mgTableView,mGAlermArray,mGTableDisplay;
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
		self.title = @"预警列表";
		
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
	UIView *gt = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 460)];
	gt.backgroundColor = Main_Color;
	self.view = gt;
	[gt release];
	
	UITableView *gTAlerm = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 378) style:UITableViewStylePlain];
	gTAlerm.backgroundColor = Main_Color;
	gTAlerm.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
	gTAlerm.delegate = self;
	gTAlerm.dataSource= self;
	self.mgTableView = gTAlerm;
	[self.view addSubview:self.mgTableView];
	[gTAlerm release];
}
//请求预警信息接口
-(void)GrequestHttp:(NSString *)theStart
{
	[self releaseSoap];
	mSoapHttp = [[SoapHttpManager alloc]init];
	mSoapHttp.delegate = self;
	mSoapHttp.OnSoapFail = @selector(GcanetFail);
	mSoapHttp.OnSoapRespond = @selector(GgetData);
	NSString *theToNum = [NSString stringWithFormat:@"%d",theStart.intValue + 10];
	NSDictionary *JsonDIc = [[NSDictionary alloc]initWithObjectsAndKeys:theStart,@"from",theToNum,@"to",@"allalarm",@"alarmtype",LINK_PASSWORD,@"password",@"interface",@"m",@"getAlarmCount", @"a",nil];
	NSString *tString2 = [NSString stringWithFormat:@"%@%@%@",BASE_URL,@"&a=getAlarmCount&sid=",kkSessionID];
	NSString *tString3 = @"";
	[mSoapHttp PostSoadMessage:JsonDIc :tString2 :tString3];
	[JsonDIc release];
	[MBProgressHUD showHUDAddedTo:self.view animated:YES];
	
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

//获得数据
-(void)GgetData
{
	[MBProgressHUD hideHUDForView:self.view animated:YES];
	if (mSoapHttp.mArray.count==1) {
		if ([[mSoapHttp.mArray objectAtIndex:0]isKindOfClass:[NSDictionary class]]) {
			NSDictionary *GtDic = [mSoapHttp.mArray objectAtIndex:0];
			if ([[GtDic objectForKey:@"status"]isEqualToString:@"0"]) {
							}else{
				UIAlertView *GtAlert = [[UIAlertView alloc]initWithTitle:@"提示" message:[GtDic objectForKey:@"message"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
				[GtAlert show];
				[GtAlert release];
			}
		}
	}else if(mSoapHttp.mArray.count>1){
		[mSoapHttp.mArray removeObjectAtIndex:0];
		[self.mGAlermArray addObjectsFromArray:mSoapHttp.mArray];
		for (int i = 0; i<self.mGAlermArray.count; i++) {
			NSDictionary *aDic = [self.mGAlermArray objectAtIndex:i];
			
			NSMutableArray *aMutab = [[NSMutableArray alloc]initWithCapacity:3];
			NSString *aArraystr = [aDic objectForKey:@"isnew"];
			NSArray *gIfNewArray = [aArraystr componentsSeparatedByString:@"$"];
			if ([[aDic objectForKey:@"flzt"]intValue]>0) {
				NSDictionary *aLinDic = [[NSDictionary alloc]initWithObjectsAndKeys:[aDic objectForKey:@"flzt"],@"flzt",[gIfNewArray objectAtIndex:0],@"ifRead", nil];
				[aMutab addObject:aLinDic];
				[aLinDic release];
			}
			if ([[aDic objectForKey:@"jfxx"]intValue]>0) {
				NSDictionary *aLinDic = [[NSDictionary alloc]initWithObjectsAndKeys:[aDic objectForKey:@"jfxx"],@"jfxx",[gIfNewArray objectAtIndex:1],@"ifRead", nil];
				[aMutab addObject:aLinDic];
				[aLinDic release];

			}
			if ([[aDic objectForKey:@"sqr"]intValue]>0) {
				NSDictionary *aLinDic = [[NSDictionary alloc]initWithObjectsAndKeys:[aDic objectForKey:@"sqr"],@"sqr",[gIfNewArray objectAtIndex:2],@"ifRead", nil];
				[aMutab addObject:aLinDic];
				[aLinDic release];
			}

			[self.mGTableDisplay addObject:aMutab];
			[aMutab release];
		}
		[self.mgTableView reloadData];
	}
	[self releaseSoap];
}
//加载下遍按钮
-(void)gAddAllButton
{
	tab = [[GcustomToolBar alloc]initWithFrame:CGRectMake(0, 376, 320, 40)];
	[self.view addSubview:tab];
	[tab release];
	GallSelected = [UIButton buttonWithType:UIButtonTypeCustom];
	GallSelected.frame = CGRectMake(5, 10, 20, 20);
	[GallSelected addTarget:self action:@selector(gtAllSelected) forControlEvents:UIControlEventTouchUpInside];
	[GallSelected setImage:[UIImage imageNamed:@"02.png"] forState:UIControlStateNormal];
	[GallSelected setImage:[UIImage imageNamed:@"01.png"] forState:UIControlStateSelected];
	[tab addSubview:GallSelected];
	
	UIButton *gLabelButn = [UIButton buttonWithType:UIButtonTypeCustom];
	gLabelButn.frame = CGRectMake(25, 10, 60, 20);
	[gLabelButn addTarget:self action:@selector(gtAllSelected) forControlEvents:UIControlEventTouchUpInside];
	[gLabelButn setTitle:@"全选" forState:UIControlStateNormal];
	[tab addSubview:gLabelButn];
	
	UIBarButtonItem *gEditBtn = [[UIBarButtonItem alloc]initWithTitle:@"删除" style:UIBarButtonItemStyleBordered target:self action:@selector(gEditTableView)];
	gEditBtn.width = 60;
	
	UIBarButtonItem *aSpaceItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:@selector(Settting:)];
	
	NSArray *abutArray = [[NSArray alloc]initWithObjects:aSpaceItem,gEditBtn ,nil];
	[gEditBtn release];
	[aSpaceItem release];
	tab.items = abutArray;
	[abutArray release];

}

//选中全部
-(void)gtAllSelected
{
	GallSelected.selected = !GallSelected.selected;
	[self.mgTableView reloadData];
	if (GallSelected.selected) {
		for (NSDictionary *aDIc in  self.mGAlermArray) {
			[GDeleteArray addObject:[aDIc objectForKey:@"id"]];
		}
	}else{
		[GDeleteArray removeAllObjects];
	}
	
}
//单个选中
-(void)gtOneSelected:(GAlermHeaderView *)alermHeader
{
	if (alermHeader.IfSelectBtn.selected) {
		[GDeleteArray addObject:[[self.mGAlermArray objectAtIndex:alermHeader.tag]objectForKey:@"id"]];
	}else{
		[GDeleteArray removeObject:[[self.mGAlermArray objectAtIndex:alermHeader.tag]objectForKey:@"id"]];
	}
}
-(void)gEditTableView
{
	if (GDeleteArray.count>0) {
	UIAlertView *tAlert = [[UIAlertView alloc]initWithTitle:@""
													message:@"预警删除不可恢复！" 
												   delegate:self 
										  cancelButtonTitle:@"确定" 
										  otherButtonTitles:@"取消",nil];
	[tAlert show];
	[tAlert release];
	}
//	UIBarButtonItem *gFinishBtn = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleBordered target:self action:@selector(gFinishEditTableView)];
//	
//	UIBarButtonItem *gDeleteAll = [[UIBarButtonItem alloc]initWithTitle:@"清除" style:UIBarButtonItemStyleBordered target:self action:@selector(gDeleteTableView)];	
//	
//	UIBarButtonItem *aSpaceItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
//	
//	NSArray *abutArray = [[NSArray alloc]initWithObjects:gDeleteAll,aSpaceItem,gFinishBtn ,nil];
//	[gEditBtn release];
//	[aSpaceItem release];
//	tab.items = abutArray;
//	[abutArray release];
//	self.mgTableView.editing = YES;
}

-(void)gFinishEditTableView
{
	UIBarButtonItem *gEditBtn = [[UIBarButtonItem alloc]initWithTitle:@"编辑" style:UIBarButtonItemStyleBordered target:self action:@selector(gEditTableView)];
	
	UIBarButtonItem *aSpaceItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:@selector(Settting:)];
	
	NSArray *abutArray = [[NSArray alloc]initWithObjects:aSpaceItem,gEditBtn ,nil];
	tab.items = abutArray;
	[abutArray release];
	[gEditBtn release];
	[aSpaceItem release];
	self.mgTableView.editing = NO ;
}
-(void)gDeleteTableView
{
	[self.mGAlermArray removeAllObjects];
	[self.mGTableDisplay removeAllObjects];
	[self.mgTableView reloadData];
}
- (void)viewDidLoad
{
	GDeleteArray = [[NSMutableArray alloc]initWithCapacity:10];
	self.navigationController.navigationBarHidden = NO;
	NSMutableArray *aMutableArray = [[NSMutableArray alloc]initWithCapacity:10];
	self.mGAlermArray = aMutableArray;
	[aMutableArray release];
	NSMutableArray *gAmut = [[NSMutableArray alloc]initWithCapacity:10];
	self.mGTableDisplay = gAmut;
	[gAmut release];
    [super viewDidLoad];
	[self GrequestHttp:@"0"];
	[self gAddAllButton];
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
	if (self.mGTableDisplay.count==0) {
		return 0;
	}
	return self.mGTableDisplay.count%10==0?self.mGTableDisplay.count+1:self.mGTableDisplay.count;	
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	if (section==self.mGTableDisplay.count) {
		return 1;
	}
	return [[self.mGTableDisplay objectAtIndex:section] count];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	if (section==self.mGTableDisplay.count) {
		return 10;
	}
	return 30;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	if (section==self.mGTableDisplay.count) {
		return nil;
	}
	NSDictionary *gAdic = [self.mGAlermArray objectAtIndex:section];
	NSString *aSt = [gAdic objectForKey:@"alarmtime"];
	NSArray *aArray = [aSt componentsSeparatedByString:@"-"];
	NSString *aReturnStr = [NSString stringWithFormat:@"%@年%d月%d日发布",[aArray objectAtIndex:0],[[aArray objectAtIndex:1]intValue],[[aArray objectAtIndex:2]intValue]];
	GAlermHeaderView *aTview = [[[GAlermHeaderView alloc]initWithFrame:CGRectMake(0, 0, 320, 30)]autorelease];
	aTview.tag = section;
	aTview.delegate = self;
	aTview.IfSelectBtn.selected = GallSelected.selected;
	aTview.gDateLabel.text = aReturnStr;
	aTview.IfDelete = @selector(gtOneSelected:);
	return aTview;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	
	NSString *gBiaoji = [NSString stringWithFormat:@"gch%d%d",indexPath.section,indexPath.row];
	if (indexPath.section==self.mGTableDisplay.count) {
		GLoadMoreTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:gBiaoji];
		if (cell == nil) {
			
			cell = [[[GLoadMoreTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:gBiaoji]autorelease];
			
		}
		cell.delegate = self;
		NSString *aStr = [NSString stringWithFormat:@"%d",indexPath.section];
		cell.mGStr = aStr;
		cell.mGLoadMore = @selector(gLoadMoreDate:);
		[cell gGetMoreFromServer];
		
		return cell;
	}
	GAlermTableCell *cell = [tableView dequeueReusableCellWithIdentifier:gBiaoji];
	if (cell == nil) {
		cell = [[[GAlermTableCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:gBiaoji]autorelease];
	NSDictionary *gAdic = [[self.mGTableDisplay objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
		if ([gAdic objectForKey:@"flzt"]) {
			if ([[gAdic objectForKey:@"ifRead"]isEqualToString:@"1"]) {
					cell.gImageName = @"xinfeng.png";
				}
			cell.gLabelText = [NSString stringWithFormat:@"法律状态预警(%@)",[gAdic objectForKey:@"flzt"]];

		}else if ([gAdic objectForKey:@"jfxx"]) {
			if ([[gAdic objectForKey:@"ifRead"]isEqualToString:@"1"]) {
				cell.gImageName = @"xinfeng.png";
			}
			cell.gLabelText = [NSString stringWithFormat:@"缴费预警(%@)",[gAdic objectForKey:@"jfxx"]];
			
		}else if ([gAdic objectForKey:@"sqr"]) {
			NSLog(@"%@",[gAdic objectForKey:@"ifRead"]);
			if ([[gAdic objectForKey:@"ifRead"]isEqualToString:@"1"]) {
				cell.gImageName = @"xinfeng.png";
			}
			cell.gLabelText = [NSString stringWithFormat:@"申请人预警(%@)",[gAdic objectForKey:@"sqr"]];
			
		}

	[cell gAddImageAndText];
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	}
	return cell;

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	NSDictionary *gAdic = [[self.mGTableDisplay objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
	if ([gAdic objectForKey:@"flzt"]) {
		NSString *aStr = [NSString stringWithFormat:@"%@ 法律状态预警缴费预警",[[self.mGAlermArray objectAtIndex:indexPath.section]objectForKey:@"alarmtime"]];
		DetailAlermTableView *aDetai = [[DetailAlermTableView alloc]initWithStyle:UITableViewStylePlain withTitle:aStr];
		aDetai.gAlermDate = [[self.mGAlermArray objectAtIndex:indexPath.section]objectForKey:@"alarmtime"];
		aDetai.gAlermType = @"flzt";
		[self.navigationController pushViewController:aDetai animated:YES];
		[aDetai release];		
	}else if ([gAdic objectForKey:@"jfxx"]) {
		NSString *aStr = [NSString stringWithFormat:@"%@ 缴费预警",[[self.mGAlermArray objectAtIndex:indexPath.section]objectForKey:@"alarmtime"]];
		DetailAlermTableView *aDetai = [[DetailAlermTableView alloc]initWithStyle:UITableViewStylePlain withTitle:aStr];
		aDetai.gAlermDate = [[self.mGAlermArray objectAtIndex:indexPath.section]objectForKey:@"alarmtime"];
		aDetai.gAlermType = @"jfxx";
		[self.navigationController pushViewController:aDetai animated:YES];
		[aDetai release];
	}else if ([gAdic objectForKey:@"sqr"]) {
		NSString *aStr = [NSString stringWithFormat:@"%@ 申请人预警",[[self.mGAlermArray objectAtIndex:indexPath.section]objectForKey:@"alarmtime"]];
		DetailAlermTableView *aDetai = [[DetailAlermTableView alloc]initWithStyle:UITableViewStylePlain withTitle:aStr];
		aDetai.gAlermDate = [[self.mGAlermArray objectAtIndex:indexPath.section]objectForKey:@"alarmtime"];
		aDetai.gAlermType = @"sqr";
		[self.navigationController pushViewController:aDetai animated:YES];
		[aDetai release];

	}	
	
}
//获取更多
-(void)gLoadMoreDate:(GLoadMoreTableViewCell *)cell
{
	[self GrequestHttp:cell.mGStr];
}
//预警消息删除接口
-(void)GrequestHttpDeleateAlerm:(NSString *)alarmId Alarmtype:(NSString *)alarmtype
{
	[self releaseSoap];
	mSoapHttp = [[SoapHttpManager alloc]init];
	mSoapHttp.delegate = self;
	mSoapHttp.OnSoapFail = @selector(GcanetFail);
	mSoapHttp.OnSoapRespond = @selector(GgetDeleteData);
	NSDictionary *JsonDIc = [[NSDictionary alloc]initWithObjectsAndKeys:alarmId,@"alarmId",alarmtype,@"alarmtype",LINK_PASSWORD,@"password",@"interface",@"m",@"statusDel", @"a",nil];
	NSString *tString2 = [NSString stringWithFormat:@"%@%@%@",BASE_URL,@"&a=statusDel&sid=",kkSessionID];
	NSString *tString3 = @"";
	[mSoapHttp PostSoadMessage:JsonDIc :tString2 :tString3];
	[JsonDIc release];
	[MBProgressHUD showHUDAddedTo:self.view animated:YES];
	
}
//
-(void)GgetDeleteData
{
	[MBProgressHUD hideHUDForView:self.view animated:YES];
	if ([[[mSoapHttp.mArray objectAtIndex:0]objectForKey:@"status"]intValue]==0) {
		[self GrequestHttp:@"0"];
	}else
		[self releaseSoap];
}
//tableview删除方法
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSDictionary *gAdic = [[self.mGTableDisplay objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
	if ([gAdic objectForKey:@"flzt"]) {
		[self GrequestHttpDeleateAlerm:[[self.mGAlermArray objectAtIndex:indexPath.section]objectForKey:@"id"] Alarmtype:@"flzt"];		
	}else if ([gAdic objectForKey:@"jfxx"]) {
		[self GrequestHttpDeleateAlerm:[[self.mGAlermArray objectAtIndex:indexPath.section]objectForKey:@"id"] Alarmtype:@"jfxx"];
	}else if ([gAdic objectForKey:@"sqr"]) {
		[self GrequestHttpDeleateAlerm:[[self.mGAlermArray objectAtIndex:indexPath.section]objectForKey:@"id"] Alarmtype:@"sqr"];
	}	
	NSMutableArray *aArray = [[self.mGTableDisplay objectAtIndex:indexPath.section]retain];
	[self.mGTableDisplay removeObjectAtIndex:indexPath.section];
	[aArray removeObjectAtIndex:indexPath.row];
	[self.mGTableDisplay insertObject:aArray atIndex:indexPath.section];
	[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    [aArray release];
}
//删除AlertView代理方法
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if (buttonIndex == [alertView cancelButtonIndex]) {
		NSString *aString = [GDeleteArray componentsJoinedByString:@";"];
		[self GrequestHttpDeleateAlerm:aString Alarmtype:@"allalarm"];
	}
}
- (void)viewDidUnload
{
    [super viewDidUnload];

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
-(void)dealloc
{
	[GDeleteArray release];
	[self releaseSoap];
	[super dealloc];
}

@end
