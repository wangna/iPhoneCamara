//
//  DetailAlermTableView.m
//  ZHUANLIJIANSUO
//
//  Created by chenhuiguo on 12-8-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DetailAlermTableView.h"
#import "GAlermDetailTableCell.h"
@interface DetailAlermTableView(){
	SoapHttpManager *mSoapHttp;
	LoadView *mLoad;
}
@property(retain,nonatomic)NSMutableArray *GmArray;
@end
@implementation DetailAlermTableView
@synthesize GmArray,gAlermDate,gAlermType;
-(void)releaseSoap
{
	if (mSoapHttp) {
		[mSoapHttp Cancel];
		[mSoapHttp release];
		mSoapHttp = nil;
	}
}

- (id)initWithStyle:(UITableViewStyle)style withTitle:(NSString *)title
{
    self = [super initWithStyle:style];
    if (self) {
		self.title = title;
    }
    return self;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
	[self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)loadView
{
	UITableView *gTAlerm = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 374) style:UITableViewStylePlain];
	gTAlerm.backgroundColor = Main_Color;
	gTAlerm.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
	self.tableView = gTAlerm;
	[gTAlerm release];
	
}
//申请关注得专利接口
#pragma mark - View lifecycle
-(IBAction)GPostSearchAgency
{
	[self releaseSoap];
	mSoapHttp = [[SoapHttpManager alloc]init];
	mSoapHttp.delegate = self;
	mSoapHttp.OnSoapFail = @selector(GcanetFail);
	mSoapHttp.OnSoapRespond = @selector(GgetsearchAgencyData);
	NSDictionary *JsonDIc = [[NSDictionary alloc]initWithObjectsAndKeys:self.gAlermType,@"alarmtype",self.gAlermDate,@"time",@"0",@"from",@"10",@"to",LINK_PASSWORD,@"password",@"getDateAlarm",@"a",@"interface",@"m", nil];
	NSString *tString2 = [NSString stringWithFormat:@"%@%@%@",BASE_URL,@"&a=getDateAlarm&sid=",kkSessionID];
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
//获得关注得代理列表数据
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
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	
    return self.GmArray.count-1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	CGSize aSize = [[NSString stringWithFormat:@"%@",[[self.GmArray objectAtIndex:indexPath.row+1]objectForKey:@"name"]]sizeWithFont:[UIFont systemFontOfSize:12.0] constrainedToSize:CGSizeMake(320, 1000) lineBreakMode:NSLineBreakByCharWrapping]; 
	CGSize twoSize = [[NSString stringWithFormat:@"%@",[[self.GmArray objectAtIndex:indexPath.row+1]objectForKey:@"address"]]sizeWithFont:[UIFont systemFontOfSize:12.0] constrainedToSize:CGSizeMake(255, 1000) lineBreakMode:NSLineBreakByCharWrapping]; 
	if (aSize.height<20) {
		aSize.height = 20;
	}
	if (twoSize.height<20) {
		twoSize.height=20;
	}
	NSLog(@"%f",aSize.height);
	NSLog(@"%f",aSize.height);
	return aSize.height+twoSize.height+80;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSInteger row = indexPath.row;
	NSString *CellIdentifier = [NSString stringWithFormat:@"Cell%d",row];
    
    GAlermDetailTableCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[GAlermDetailTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
		NSString *aStr = [[self.GmArray objectAtIndex:indexPath.row+1]objectForKey:@"message"];
		NSArray *gArray = [aStr componentsSeparatedByString:@";"];
		cell.gArray = gArray;
		[cell gAddTextLabel];
    }    
    return cell;
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
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{	[self GrequestHttpDeleateAlerm:[self.GmArray  objectAtIndex:indexPath.row+1]Alarmtype:self.gAlermType];
	[self.GmArray removeObjectAtIndex:indexPath.row+1];	
	[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
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

@end
