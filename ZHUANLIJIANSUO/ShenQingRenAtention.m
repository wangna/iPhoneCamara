//
//  ShenQingRenAtention.m
//  ZHUANLIJIANSUO
//
//  Created by chenhuiguo on 12-8-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ShenQingRenAtention.h"
#import "GMoreTableViewHeader.h"
#import "ResultPage.h"
@interface ShenQingRenAtention()
{
	SoapHttpManager *mSoapHttp;
	LoadView *mLoad;
}
@property(retain,nonatomic)NSMutableArray *GmArray;
@property(nonatomic,assign)NSString *gCancelSqr;
@end

@implementation ShenQingRenAtention
@synthesize GmArray,gCancelSqr;
- (id)init
{
    self = [super init];
    if (self) {
       self.title = @"申请人关注";
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
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


- (void)loadView
{
	UITableView *gTAlerm = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 374) style:UITableViewStylePlain];
	gTAlerm.backgroundColor = Main_Color;
	gTAlerm.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
	self.tableView = gTAlerm;
	[gTAlerm release];
	
}
//申请关注得申请人接口
#pragma mark - View lifecycle
-(IBAction)GPostSearchAgency
{
	[self releaseSoap];
	mSoapHttp = [[SoapHttpManager alloc]init];
	mSoapHttp.delegate = self;
	mSoapHttp.OnSoapFail = @selector(GcanetFail);
	mSoapHttp.OnSoapRespond = @selector(GgetsearchAgencyData);
	NSDictionary *JsonDIc = [[NSDictionary alloc]initWithObjectsAndKeys:@"0",@"from",@"30",@"to",LINK_PASSWORD,@"password",@"attentionToApplicants",@"a",@"interface",@"m", nil];
	NSString *tString2 = [NSString stringWithFormat:@"%@%@%@",BASE_URL,@"&a=attentionToApplicants&sid=",kkSessionID];	
	NSString *tString3 = @"";
	[mSoapHttp PostSoadMessage:JsonDIc :tString2 :tString3];
	[JsonDIc release];
	[MBProgressHUD showHUDAddedTo:self.view animated:YES];
}
//删除关注的申请人
#pragma mark - View lifecycle
-(IBAction)GPostcancelSqr
{
	[self releaseSoap];
	mSoapHttp = [[SoapHttpManager alloc]init];
	mSoapHttp.delegate = self;
	mSoapHttp.OnSoapFail = @selector(GcanetFail);
	mSoapHttp.OnSoapRespond = @selector(CancelSqrGuanzhu);
	NSDictionary *JsonDIc = [[NSDictionary alloc]initWithObjectsAndKeys:self.gCancelSqr,@"applicant",LINK_PASSWORD,@"password",@"cancelAttentionToApplicant",@"a",@"interface",@"m", nil];
	NSString *tString2 = [NSString stringWithFormat:@"%@%@%@",BASE_URL,@"&a=cancelAttentionToApplicant&sid=",kkSessionID];	
	NSString *tString3 = @"";
	[mSoapHttp PostSoadMessage:JsonDIc :tString2 :tString3];
	[JsonDIc release];
	[MBProgressHUD showHUDAddedTo:self.view animated:YES];
}
-(void)CancelSqrGuanzhu
{
	[MBProgressHUD hideHUDForView:self.view animated:YES];
}

- (void)viewDidLoad
{
	mSoapHttp = nil;
	mLoad = nil;
	self.navigationController.navigationBarHidden = NO;
    [super viewDidLoad];
	[self GPostSearchAgency];
	UIBarButtonItem *rightButnItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"Gfirst.png"] style:UIBarButtonItemStyleBordered target:self action:@selector(SelfPopToROOtViewControl)];
    self.navigationItem.rightBarButtonItem = rightButnItem;
	[rightButnItem release];
	
}
-(void)SelfPopToROOtViewControl
{
	[self.navigationController popToRootViewControllerAnimated:YES];
}

//获得关注得申请人列表数据
-(void)GgetsearchAgencyData
{
	[MBProgressHUD hideHUDForView:self.view animated:YES];
	self.GmArray = mSoapHttp.mArray;
	[self releaseSoap];
	if (self.GmArray.count>1) {
		[self.tableView reloadData];
	}
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

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
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
    return self.GmArray.count-1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    cell.textLabel.text = [[self.GmArray objectAtIndex:indexPath.row+1]objectForKey:@"pa"];
	cell.textLabel.textColor = Text_Color_Green;
	cell.textLabel.font = [UIFont systemFontOfSize:15.0];
	return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	return 30;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	GMoreTableViewHeader *GaHeader = [[[GMoreTableViewHeader alloc]initWithFrame:CGRectMake(0, 0, 320, 30)]autorelease];
	GaHeader.backgroundColor = [UIColor whiteColor];
	GaHeader.GmNum = [[self.GmArray objectAtIndex:0]objectForKey:@"total"]; 
	GaHeader.GAddJumpView = @selector(GAddJumpView);
	GaHeader.delegate = self;
	[GaHeader GaddTitleAndImage];
	return GaHeader;
	
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{    
    return YES;
}



-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
	self.gCancelSqr = [[self.GmArray objectAtIndex:indexPath.row+1]objectForKey:@"pa"];
	[self GPostcancelSqr];
	[self.GmArray removeObjectAtIndex:indexPath.row];
	[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSString *gAstr = [NSString stringWithFormat:@"%@",[[self.GmArray objectAtIndex:indexPath.row+1]objectForKey:@"pa"]];
	self.gCancelSqr = gAstr;
    NSArray *tFenHao = [gAstr componentsSeparatedByString:@";"];
    NSString *gResu;
    if (tFenHao.count>1) {
        NSMutableArray *theArray = [[NSMutableArray alloc]initWithCapacity:10];
        for (int i = 0; i<tFenHao.count; i++) {
            NSString *aStr = [NSString stringWithFormat:@"%@%@%@%@",@"申请（专利权）人=",@"'",[tFenHao objectAtIndex:i],@"'" ];
            [theArray addObject:aStr];
        }
        gResu = [theArray componentsJoinedByString:@" or "];
        [theArray release];
    }else{
        gResu = [NSString stringWithFormat:@"%@%@%@%@",@"申请（专利权）人=",@"'",gAstr,@"'" ];
    }

    ResultPage *result = [[ResultPage alloc]init];
    result.msg = gResu;
    [self.navigationController pushViewController:result animated:YES];
    [result release];
}
-(void)dealloc
{
	self.GmArray = nil;
	[super dealloc];
}

@end
