//
//  GAgencySearchTableView.m
//  ZHUANLIJIANSUO
//
//  Created by chenhuiguo on 12-8-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "GAgencySearchTableView.h"
#import "GMoreTableViewHeader.h"
#import "GAgencyTableCell.h"
#import "GAgentDetailTableView.h"
#import "DanDuHttp.h"
#import "GLoadMoreTableViewCell.h"
#import "GcustomToolBar.h"
@interface GAgencySearchTableView()
{
	DanDuHttp *mSoapHttp;
	LoadView *mLoad;
	NSInteger TheRowNum;
    GcustomToolBar *toolBar;
}
@property(retain,nonatomic)NSMutableArray *GmArray;
@property(retain,nonatomic)UITableView *tableView;
@property(retain,nonatomic)UITextField *gmTextField;
@property(retain,nonatomic)NSString *gSearchName;
@property(retain,nonatomic)NSString *gTitleNmuber;
@end
@implementation GAgencySearchTableView
@synthesize GmArray,tableView,gmTextField,gSearchName,gTitleNmuber;
-(void)releaseSoap
{
	if (mSoapHttp) {
		[mSoapHttp Cancel];
		[mSoapHttp release];
		mSoapHttp = nil;
	}
}


- (id)init
{
    self = [super init];
    if (self) {
        self.title = NSLocalizedString(@"代理查询",nil);
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
- (void)loadView
{
    Vheight=[UIScreen mainScreen].bounds.size.height;
	UIView *tView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, Vheight-20)];
	tView.backgroundColor = Main_Color;
	self.view = tView;
	[tView release];
	
	UITableView *gTAlerm = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, Vheight-102) style:UITableViewStylePlain];
	gTAlerm.backgroundColor = Main_Color;
	gTAlerm.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
	self.tableView = gTAlerm;
	[gTAlerm release];
	self.tableView.delegate = self;
	self.tableView.dataSource = self;
	[self.view addSubview:self.tableView];
	
}

#pragma mark - View lifecycle
-(IBAction)GPostSearchAgency:(NSString *)aStr AndIndex:(NSString *)index
{
	[self releaseSoap];
	mSoapHttp = [[DanDuHttp alloc]init];
	mSoapHttp.delegate = self;
	mSoapHttp.OnSoapFail = @selector(GcanetFail);
	mSoapHttp.OnSoapRespond = @selector(GgetsearchAgencyData);
	NSString *ToStr = [NSString stringWithFormat:@"%d",index.intValue+10];
	NSDictionary *JsonDIc = [[NSDictionary alloc]initWithObjectsAndKeys:aStr,@"name",index,@"from",ToStr,@"to",LINK_PASSWORD,@"password",@"getAgentList",@"a",@"interface",@"m", nil];
	NSString *tString2 = [NSString stringWithFormat:@"%@%@%@",BASE_URL,@"&a=getAgentList&sid=",kkSessionID];
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

-(void)gAddSeachFieldAndButton
{
	toolBar = [[GcustomToolBar alloc]initWithFrame:CGRectMake(0, self.tableView.frame.size.height, 768, 50)];
	
	UITextField *aText = [[UITextField alloc]initWithFrame:CGRectMake(13, 5, 230, 30)];
	aText.tag = 1001;
	aText.delegate = self;
	aText.borderStyle = UITextBorderStyleRoundedRect;
	aText.placeholder = NSLocalizedString(@"请输入搜索条件",nil);
	
	self.gmTextField = aText;
	[aText release];
	[toolBar addSubview:self.gmTextField];
	
	UIButton *tBt = [UIButton buttonWithType:UIButtonTypeCustom];
	tBt.frame = CGRectMake(243,3, 70, 32);
	[tBt setImage:[UIImage imageNamed:@"diButton.png"] forState:UIControlStateNormal];
	[tBt addTarget:self action:@selector(gsearchWithUserInput) forControlEvents:UIControlEventTouchUpInside];
	[toolBar addSubview:tBt];
    [aText addTarget:self action:@selector(changEframe) forControlEvents:UIControlEventEditingDidBegin];
	[aText addTarget:self action:@selector(resignTheFirst:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [self.view addSubview:toolBar];
	[toolBar release];

}
- (void)keyboardWillShow:(NSNotification *)notification {
    
    
    NSDictionary *userInfo = [notification userInfo];
    
    // Get the origin of the keyboard when it's displayed.
    NSValue* aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    
    CGRect keyboardRect = [aValue CGRectValue];
    
    UITextField *textField = (UITextField *)[self.view viewWithTag:1001];
    if (textField.editing) {

//        UIToolbar *toolbar = (UIToolbar *)[self.view viewWithTag:TOOLBARTAG];
       toolBar.frame = CGRectMake(0, Vheight-(keyboardRect.size.height)-104, 320, 40);
//        toolbar.frame = CGRectMake(0.0f, tableView.frame.size.height+tableView.frame.origin.y, TABLE_WIDTH, 44.0f);    
    }
//    NSLog(@"%f", keyboardRect.size.width);
}

- (void)viewDidLoad
{
    if ([[[UIDevice currentDevice]systemVersion]floatValue]>=7.0)
        self.edgesForExtendedLayout = UIRectEdgeNone;
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardDidShowNotification object:nil];
	mSoapHttp = nil;
	mLoad = nil;
	TheRowNum = 0;
	NSMutableArray *gtArray = [[NSMutableArray alloc]initWithCapacity:10];
	self.GmArray = gtArray;
	[gtArray release];
	self.navigationController.navigationBarHidden = NO;
    [super viewDidLoad];
	self.gSearchName = @"%25";
	[self GPostSearchAgency:self.gSearchName AndIndex:@"0"];
	[self gAddSeachFieldAndButton];
	UIBarButtonItem *rightButnItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"Gfirst.png"] style:UIBarButtonItemStyleBordered target:self action:@selector(SelfPopToROOtViewControl)];
    self.navigationItem.rightBarButtonItem = rightButnItem;
	[rightButnItem release];
	
}
-(void)SelfPopToROOtViewControl
{
	[self.navigationController popToRootViewControllerAnimated:YES];
}

//取消第一相应者
-(void)resignTheFirst:(UITextField *)sender
{
	[toolBar setFrame:CGRectMake(0, Vheight-64-40, 320, 40)];
}
//改变坐标
-(void)changEframe
{
	//self.view.center = CGPointMake(160, -46);
}
//用户输入搜索
-(void)gsearchWithUserInput
{
	self.gSearchName = self.gmTextField.text;
	[self GPostSearchAgency:self.gSearchName AndIndex:@"0"];
	[self.GmArray removeAllObjects];
	TheRowNum = 0;
	[self.tableView reloadData];
	self.tableView = nil;
	UITableView *gTAlerm = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, Vheight-102) style:UITableViewStylePlain];
	gTAlerm.backgroundColor = Main_Color;
	gTAlerm.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
	self.tableView = gTAlerm;
	[gTAlerm release];
	self.tableView.delegate = self;
	self.tableView.dataSource = self;
	[self.view addSubview:self.tableView];
}
-(void)GgetsearchAgencyData
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
	[self.gmTextField resignFirstResponder];
	self.gTitleNmuber = [[mSoapHttp.mArray objectAtIndex:0]objectForKey:@"total"];
	if (mSoapHttp.mArray.count>1) {
		[mSoapHttp.mArray removeObjectAtIndex:0];
		[self.GmArray addObjectsFromArray:mSoapHttp.mArray];
		[self.tableView reloadData];
	}else{
		UIAlertView *tAlert = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"提示",nil) message:[[mSoapHttp.mArray objectAtIndex:0]objectForKey:@"message"] delegate:nil cancelButtonTitle:NSLocalizedString(@"确定",nil) otherButtonTitles:nil];
		[tAlert show];
		[tAlert release];
        [self.tableView reloadData];
	}
	[self releaseSoap];
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	if (self.GmArray.count==0) {
		return 0;
	}
	return (self.GmArray.count)%10==0?self.GmArray.count+1 :self.GmArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (indexPath.row==self.GmArray.count) {
		return 50;
	}
	CGSize aSize = [[NSString stringWithFormat:@"%@",[[self.GmArray objectAtIndex:indexPath.row]objectForKey:@"name"]]sizeWithFont:[UIFont systemFontOfSize:14.0] constrainedToSize:CGSizeMake(320, 1000) lineBreakMode:NSLineBreakByCharWrapping]; 
	CGSize twoSize = [[NSString stringWithFormat:@"%@",[[self.GmArray objectAtIndex:indexPath.row]objectForKey:@"address"]]sizeWithFont:[UIFont systemFontOfSize:14.0] constrainedToSize:CGSizeMake(255, 1000) lineBreakMode:NSLineBreakByCharWrapping]; 
	if (aSize.height<20) {
		aSize.height = 20;
	}
	if (twoSize.height<20) {
		twoSize.height=20;
	}
	return aSize.height+twoSize.height+70;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSInteger row = indexPath.row;
     NSString *CellIdentifier = [NSString stringWithFormat:@"Cell%d%d",row,TheRowNum];
    if (indexPath.row<self.GmArray.count) {

    GAgencyTableCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[GAgencyTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
		cell.GcontentDic = [self.GmArray objectAtIndex:row];
		NSString *aString = [NSString stringWithFormat:@"%d%@%@",TheRowNum+row+1,@". ",[[self.GmArray objectAtIndex:row]objectForKey:@"name"]];
		cell.GtitleName =aString;
		cell.gScore = [[[self.GmArray objectAtIndex:row]objectForKey:@"Score"]floatValue];
		[cell CellAddTextLabel];
    }    
    return cell;
	}
	static NSString *cellTableIdentifier = @"italicsCellTableIdentifier";
	GLoadMoreTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellTableIdentifier];
	if (cell == nil) {
		
		cell = [[[GLoadMoreTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellTableIdentifier]autorelease];
        [cell setBackgroundColor:Main_Color];
		
	}
	cell.delegate = self;
	NSString *aStr = [NSString stringWithFormat:@"%d",indexPath.row+ TheRowNum];
	cell.mGStr = aStr;
	cell.mGLoadMore = @selector(gLoadMoreDate:);
	[cell gGetMoreFromServer];
	
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
	GaHeader.GmNum = self.gTitleNmuber; 
	GaHeader.GAddJumpView = @selector(GAddJumpView);
	GaHeader.delegate = self;
	[GaHeader GaddTitleAndImage];
	[GaHeader GaddJumpButton];
	return GaHeader;
	
}
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
            NSInteger sumNum=[self.gTitleNmuber integerValue]+1;
            if (inputNum&&inputNum<sumNum&&inputNum>0)
            {
                NSString *astr = [NSString stringWithFormat:@"%d",[[alertView textFieldAtIndex:0].text intValue]-1];
                [self GPostSearchAgency:self.gSearchName AndIndex:astr];
                TheRowNum = [[alertView textFieldAtIndex:0].text intValue]-1;
                [self.GmArray removeAllObjects];
            }
            else
            {
                
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:NSLocalizedString(@"请输入有效的序号",nil) message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                [alert release];
                
            }
            
		}
	}

	
}
#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	GAgentDetailTableView *tGdetail = [[GAgentDetailTableView alloc]init];
	tGdetail.mGId = [[self.GmArray objectAtIndex:indexPath.row]objectForKey:@"id"];
	[self.navigationController pushViewController:tGdetail animated:YES];
	[tGdetail release];
}
//请求更多
-(void)gLoadMoreDate:(GLoadMoreTableViewCell *)cell
{
	[self GPostSearchAgency:self.gSearchName AndIndex:cell.mGStr];
}
-(void)dealloc
{
	[[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
	[self releaseSoap];
	[super dealloc];
}
@end
