//
//  GPatentAtentionTable.m
//  ZHUANLIJIANSUO
//
//  Created by chenhuiguo on 12-8-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "GPatentAtentionTable.h"
#import "MoreTableVIewCell.h"
#import "GMoreTableViewHeader.h"
#import "GNewDtailSearchTable.h"
#import "GLoadMoreTableViewCell.h"
#import "NSString+SBJSON.h"
#import "AppDelegate.h"
@interface GPatentAtentionTable()
{
	SoapHttpManager *mSoapHttp;
	LoadView *mLoad;
	UITextField *mGSearchField;
	NSInteger TheRowNum;
    NSInteger Tcount;
    NSArray *newarr;
    AppDelegate *app;
}
@end
@implementation GPatentAtentionTable
@synthesize mGAtentionArray;

- (id)init
{
    self = [super init];
    if (self) {
       self.title = NSLocalizedString(@"我的收藏",nil);
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
	UITableView *gTAlerm = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 412) style:UITableViewStylePlain];
	gTAlerm.backgroundColor = Main_Color;
	gTAlerm.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
	self.tableView = gTAlerm;
	[gTAlerm release];

}
//请求专利关注接口
-(IBAction)GPostSearchHistor:(NSString *)aFrom
{
	[self releaseSoap];
	mSoapHttp = [[SoapHttpManager alloc]init];
	mSoapHttp.delegate = self;
    mSoapHttp.view=app.window;
	mSoapHttp.OnSoapFail = @selector(GcanetFail);
	mSoapHttp.OnSoapRespond = @selector(GgetData);
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    NSString *name=[user objectForKey:@"DID"];
	NSString *aTo = [NSString stringWithFormat:@"%d",[aFrom intValue]+9];
	NSDictionary *JsonDIc = [[NSDictionary alloc]initWithObjectsAndKeys:aFrom,@"startindex",aTo,@"endindex",name,@"userid",nil];
	NSString *tString2 = [NSString stringWithFormat:@"http://59.151.99.154:8080/dsqb/mcts"];
	NSString *tString3 = @"";
	[mSoapHttp PostSoadMessage:JsonDIc :tString2 :tString3];
	[JsonDIc release];
	[MBProgressHUD showHUDAddedTo:self.view animated:YES];
}
//获得关注数据
-(void)GgetData
{
	[MBProgressHUD hideHUDForView:self.view animated:YES];
	[self.mGAtentionArray removeAllObjects];
    newarr=nil;
	newarr = [[mSoapHttp.jsonStr JSONValue]objectForKey:@"mycollectinfos"];
    [self.mGAtentionArray addObjectsFromArray:newarr];
    if (newarr.count==0) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:NSLocalizedString(@"没有查询结果",nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"确定",nil) otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
    }

	[self.tableView reloadData];
	[self releaseSoap];
}
//网络连接失败
-(void)GcanetFail
{
	[MBProgressHUD hideHUDForView:self.view animated:YES];
	UIAlertView *tAlert = [[UIAlertView alloc]initWithTitle:@"" message:NSLocalizedString(@"网络连接失败!",nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"确定",nil) otherButtonTitles:nil];
	[tAlert show];
	[tAlert release];
}
- (void)viewDidLoad
{
    if ([[[UIDevice currentDevice]systemVersion]floatValue]>=7.0)
        self.edgesForExtendedLayout = UIRectEdgeNone;
	TheRowNum = 0;
    Tcount=self.mGAtentionArray.count;
    newarr=self.mGAtentionArray;
	self.navigationController.navigationBarHidden = NO;
    app=(AppDelegate *)[UIApplication sharedApplication].delegate;

	mSoapHttp = nil;
	mLoad = nil;
    [super viewDidLoad];
	UIBarButtonItem *rightButnItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"Gfirst.png"] style:UIBarButtonItemStyleBordered target:self action:@selector(SelfPopToROOtViewControl)];
    self.navigationItem.rightBarButtonItem = rightButnItem;
	[rightButnItem release];
	
}
-(void)SelfPopToROOtViewControl
{
	[self.navigationController popToRootViewControllerAnimated:YES];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	if (newarr.count==0) {
		return self.mGAtentionArray.count;
	}
	return newarr.count<10?mGAtentionArray.count:mGAtentionArray.count+1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{	
	if (indexPath.row==self.mGAtentionArray.count) {
		return 50;
	}else{
	NSString *GheitStr = [[[[self.mGAtentionArray objectAtIndex:indexPath.row]objectForKey:@"pname"]componentsSeparatedByString:@"source等于"]objectAtIndex:0];
	CGSize gSize = [GheitStr sizeWithFont:[UIFont systemFontOfSize:15.0] constrainedToSize:CGSizeMake(300, 1000)lineBreakMode:NSLineBreakByCharWrapping];
        NSLog(@"size.height==%f",gSize.height);
	return gSize.height>20?gSize.height+80:100;
	}
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSInteger row = [indexPath row];
	NSString *cellTableIdentifier = [NSString stringWithFormat:@"italicsCellTableIdentifier%d",row+TheRowNum];
	if (indexPath.row<self.mGAtentionArray.count) {
	MoreTableVIewCell *MACell = [tableView dequeueReusableCellWithIdentifier:cellTableIdentifier];
	if (MACell == nil) {
		MACell = [[[MoreTableVIewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellTableIdentifier]autorelease];
		MACell.GcontentDic = [self.mGAtentionArray objectAtIndex:row];
		NSString *title=[[[[self.mGAtentionArray objectAtIndex:row]objectForKey:@"pname"]componentsSeparatedByString:@"source等于"]objectAtIndex:0];
		NSString *aString = [NSString stringWithFormat:@"%d%@%@",TheRowNum+row+1,@". ",title];

        aString=[aString stringByReplacingOccurrencesOfString:@"～lt;" withString:@""];
        aString=[aString stringByReplacingOccurrencesOfString:@"sub～gt;" withString:@""];
        NSLog(@"aString___%@",aString);
		MACell.GtitleName = aString;
//		MACell.gScore = [[[self.mGAtentionArray objectAtIndex:row+1]objectForKey:@"gpa"]floatValue];
		[MACell CellAddTextLabel];
	}
	
	MACell.selectionStyle = UITableViewCellSelectionStyleNone;
	return MACell;
	}else{
		static NSString *cellTableIdentifier = @"italicsCellTableIdentifier";
		GLoadMoreTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellTableIdentifier];
        if (cell == nil) {
			
			cell = [[[GLoadMoreTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellTableIdentifier]autorelease];
            [cell setBackgroundColor:Main_Color];
		}
        NSString *aStr = [NSString stringWithFormat:@"%d",indexPath.row+ TheRowNum+1];
		cell.mGStr = aStr;
     
		
		cell.delegate = self;
	

		cell.mGLoadMore = @selector(gLoadMoreDate:);
		[cell gGetMoreFromServer];

		return cell;
	}
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	return 30;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	GMoreTableViewHeader *GaHeader = [[[GMoreTableViewHeader alloc]initWithFrame:CGRectMake(0, 0, 320, 30)]autorelease];
	GaHeader.backgroundColor = [UIColor whiteColor];
	GaHeader.GmNum = [NSString stringWithFormat:@"%d",self.mGAtentionArray.count];
	GaHeader.GAddJumpView = @selector(GAddJumpView);
	GaHeader.delegate = self;
	[GaHeader GaddTitleAndImage];
	[GaHeader GaddJumpButton];
	return GaHeader;
	
}
//请求下10条专利关注接口
-(IBAction)GPostSearchMoreHistor:(NSString *)aFrom
{
	[self releaseSoap];
	mSoapHttp = [[SoapHttpManager alloc]init];
	mSoapHttp.delegate = self;
    mSoapHttp.view=app.window;
	mSoapHttp.OnSoapFail = @selector(GcanetFail);
	mSoapHttp.OnSoapRespond = @selector(GgetMoreData);
	NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    NSString *name=[user objectForKey:@"DID"];
	NSString *aTo = [NSString stringWithFormat:@"%d",[aFrom intValue]+9];
	NSDictionary *JsonDIc = [[NSDictionary alloc]initWithObjectsAndKeys:aFrom,@"startindex",aTo,@"endindex",name,@"userid",nil];
	NSString *tString2 = [NSString stringWithFormat:@"http://59.151.99.154:8080/dsqb/mcts"];
	NSString *tString3 = @"";
	[mSoapHttp PostSoadMessage:JsonDIc :tString2 :tString3];
	[JsonDIc release];
	[MBProgressHUD showHUDAddedTo:self.view animated:YES];

}
//获得下10条关注数据
-(void)GgetMoreData
{
	[MBProgressHUD hideHUDForView:self.view animated:YES];
	newarr=nil;
    newarr=[[mSoapHttp.jsonStr JSONValue]objectForKey:@"mycollectinfos"];
	if (newarr.count) {
		for (int i=0; i<newarr.count; i++) {
			[self.mGAtentionArray addObject:[newarr objectAtIndex:i]];
            Tcount=self.mGAtentionArray.count;
		}
        [self.tableView reloadData];
	}
	
	[self releaseSoap];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	if (indexPath.row<self.mGAtentionArray.count) {
		NSString *tms1=@"";
		NSString *tms2=@"";
		NSString *tms=@"";
		GNewDtailSearchTable *detailController = [[GNewDtailSearchTable alloc]init];
		NSDictionary *aDic = [self.mGAtentionArray objectAtIndex:indexPath.row];
		for (NSString *astr in  aDic.allKeys) {
			if ([astr isEqualToString:@"pan"]) {
				tms1 = [@"an%3D" stringByAppendingString:[NSString stringWithFormat:@"'%@'",[aDic objectForKey:@"pan"]]];
//				tms1 = [tms1 stringByAppendingString:@" and "];
//			}else if([astr isEqualToString:@"pnm"]){
//				tms2 = [@"pnm%3D" stringByAppendingString:[aDic objectForKey:@"pnm"]];
			}
		}
		tms = [tms1 stringByAppendingString:tms2];
		detailController.detailMess = tms;
          NSArray *arrtemp=[[[self.mGAtentionArray objectAtIndex:indexPath.row]objectForKey:@"pname"]componentsSeparatedByString:@"source等于"];
        if (arrtemp.count>1) {
            detailController.sourceData=[arrtemp objectAtIndex:1];
        }
        else
        detailController.sourceData=@"FMZL,FMSQ,SYXX,WGZL,HKPATENT,TWZL,WGSX,FMSX,XXSX,EPPATENT,WOPATENT,GBPATENT,DEPATENT,FRPATENT,CHPATENT,KRPATENT,RUPATENT,JPPATENT,ASPATENT,GCPATENT,USPATENT,APPATENT,ATPATENT,AUPATENT,CAPATENT,ESPATENT,ITPATENT,SEPATENT,OTHERPATENT";
      
        detailController.gZhuanli=YES;
		[self.navigationController pushViewController:detailController animated:YES];
		[detailController release];   
	}else if (indexPath.row==self.mGAtentionArray.count) {
		NSString *aStr = [NSString stringWithFormat:@"%d",indexPath.row+ TheRowNum];
		[self GPostSearchMoreHistor:aStr];
	}
}
//跳转得输入框
-(void)GAddJumpView
{
	UIAlertView *alert = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"请输入要跳转的序号：",nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"取消",nil) otherButtonTitles:NSLocalizedString(@"确定",nil), nil];
	alert.alertViewStyle = UIAlertViewStylePlainTextInput;
	[alert show];
	[alert release];
}
//代理方法
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if (buttonIndex) {
		if ([[alertView textFieldAtIndex:0].text length]>0) {
            NSInteger inputNum=[[alertView textFieldAtIndex:0].text integerValue];
            if (inputNum&&inputNum<Tcount+1&&inputNum>0)
            {
                NSString *astr = [NSString stringWithFormat:@"%d",[[alertView textFieldAtIndex:0].text intValue]];
                [self GPostSearchHistor:astr];
                TheRowNum = [[alertView textFieldAtIndex:0].text intValue]-1;
            }
            else
            {
                {
                    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:NSLocalizedString(@"请输入有效的序号",nil) message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [alert show];
                    [alert release];
                }
            }
		}
	}
	
}
-(void)gLoadMoreDate:(GLoadMoreTableViewCell *)cell
{
	[self GPostSearchMoreHistor:cell.mGStr];
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
	self.mGAtentionArray = nil;
	[super dealloc];
}
@end
