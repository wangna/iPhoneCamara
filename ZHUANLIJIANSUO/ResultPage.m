//
//  ResultPage.m
//  PatentSearch
//
//  Created by wei on 12-8-23.
//  Copyright (c) 2012年 wei. All rights reserved.
//

#import "ResultPage.h"
#import "ResultCell.h"
#import "SmallViewPage.h"
#import "gKuTableHeaderView.h"
#import "GLoadMoreTableViewCell.h"
#import "GKuTableView.h"
#import "GcustomToolBar.h"
#import "GNewDtailSearchTable.h"
#import "AppDelegate.h"
@interface ResultPage ()
{
	LoadView *mLoad;
	NSInteger TheRowNum;
	BOOL ifChang;
	UILabel *aButnLabel;
	GcustomToolBar *bar;
    AppDelegate *app;
    int gNum;
    GKuTableView *gkuTable;
    SmallViewPage *aView;
}
@property(retain,nonatomic)NSString *gTitleString;
@end

@implementation ResultPage
//@synthesize list;
@synthesize table;
@synthesize mArray,mDic;
@synthesize arr,msg,detailString;
@synthesize dicArray,caArray;
@synthesize sourceData,gTitleString;

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
		self.title = NSLocalizedString(@"专利列表",nil);
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        self.msg = [user objectForKey:@"strWhere"];
		 self.sourceData =[user objectForKey:@"strSources"];
    }
    return self;
}
- (void)viewDidLoad
{
    if ([[[UIDevice currentDevice]systemVersion]floatValue]>=7.0)
        self.edgesForExtendedLayout = UIRectEdgeNone;
    Vheight=[UIScreen mainScreen].bounds.size.height;
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardDidShowNotification object:nil];
    app = (AppDelegate *)[UIApplication sharedApplication].delegate;
	TheRowNum = 0;
	ifChang = YES;
	mSoapHttp = nil;
	mLoad = nil;
	NSMutableArray *aArray = [[NSMutableArray alloc]initWithCapacity:10];
	self.dicArray = aArray;
	[aArray release];
	self.navigationController.navigationBarHidden = NO;
//    self.list = [[NSMutableArray alloc]initWithCapacity:0];
//    self.arr = [[NSMutableArray alloc]initWithCapacity:0];
   

    [self GpostToServer:@"0"];
    tabview=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, Vheight-104)];
    self.table = tabview;
    [tabview release];
	self.table.backgroundColor = Main_Color;
	self.table.delegate = self;
    self.table.dataSource = self;
    [self.view addSubview:self.table];
   
    //底部过滤的bar
    bar = [[GcustomToolBar alloc]initWithFrame:CGRectMake(0, Vheight-104, 320, 40)];
	
	aButnLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, 60, 20)];
	aButnLabel.textColor = [UIColor whiteColor];
	aButnLabel.backgroundColor = [UIColor clearColor];
	aButnLabel.text = NSLocalizedString(@"名称",nil);
	aButnLabel.font = [UIFont systemFontOfSize:15.0];
	aButnLabel.textAlignment = NSTextAlignmentRight;
	mess0 = @"名称";
    btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.tag = 1;
    btn.frame = CGRectMake(5, 0, 80, 40);
    [btn addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [btn addSubview:aButnLabel];
	[aButnLabel release];
	
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(65, 15, 10, 10)];
    imageView.image = [UIImage imageNamed:@"04.png"];
    [btn addSubview:imageView];
    [imageView release];
    
    textField = [[UITextField alloc]initWithFrame:CGRectMake(85, 5, 185, 30)];
	textField.tag = 1001;
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.placeholder = NSLocalizedString(@"过滤条件",nil);
    textField.clearButtonMode=UITextFieldViewModeWhileEditing;

	textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [textField addTarget:self action:@selector(textFieldDone:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [textField addTarget: self action:@selector(changeFrame) forControlEvents:UIControlEventEditingDidBegin];
    
    UIButton *seachBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    seachBtn.frame = CGRectMake(270, 3, 50, 32);
    seachBtn.tag = 2;
    [seachBtn addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [seachBtn setImage:[UIImage imageNamed:@"diButton.png"] forState:UIControlStateNormal];
    [bar addSubview:seachBtn];
    [bar addSubview:btn];
    [bar addSubview:textField];
    [self.view addSubview:bar];
    self.view.backgroundColor = [UIColor whiteColor];
   
    self.navigationItem.title = NSLocalizedString(@"专利列表",nil);
//    [self.navigationItem.backBarButtonItem setTitle:@"返回"];

//    activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//    activityView.center = self.view.center;
//    activityView.hidesWhenStopped = YES;
//    [self.view addSubview:activityView];
//    [activityView startAnimating];
    
    [super viewDidLoad];
	UIBarButtonItem *rightButnItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"Gfirst.png"] style:UIBarButtonItemStyleBordered target:self action:@selector(SelfPopToROOtViewControl)];
    self.navigationItem.rightBarButtonItem = rightButnItem;
	[rightButnItem release];
}
-(void)SelfPopToROOtViewControl
{
	[self.navigationController popToRootViewControllerAnimated:YES];
}
-(void)changeFrame
{
}
-(IBAction)buttonPressed:(id)sender
{
    UIButton *button = (UIButton *)sender;
    if (button.tag == 1) {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDidStopSelector:@selector(animationFinished)];
        [UIView setAnimationDuration:1.5];
        // self.view.alpha = 0.3;
        [UIView commitAnimations];
    }
    if (button.tag == 2) {
		[textField resignFirstResponder];
		 bar.frame = CGRectMake(0, Vheight-106, 320, 44);
		if (textField!=NULL) {
			NSLog(@"%@",mess0);
			if ([mess0 isEqualToString:@"分类号"]||[mess0 isEqualToString:@"主分类号"]||[mess0 isEqualToString:@"申请号"]||[mess0 isEqualToString:@"公开（公告）号"]) {
				mess1 = [mess0 stringByAppendingFormat:@"%@%@%@%@%@",@"%3D",@"'",@"%25",textField.text,@"'"];
			}else
				mess1 = [mess0 stringByAppendingFormat:@"%@%@%@%@",@"%3D",@"'",textField.text,@"'"];
            //			NSMutableString *aString = [[NSMutableString alloc]initWithString:self.msg];
//			self.msg = [[aString stringByAppendingString:@" and "]stringByAppendingString:mess1]; 
//			[aString release];
            NSArray *arry = [self.msg componentsSeparatedByString:@" or "];
            if (arry) {
                self.msg = [NSString stringWithFormat:@"%@%@%@",self.msg,@" and ",mess1];
            }else
                self.msg = [self.msg stringByAppendingFormat:@" and %@",mess1];
			
			NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
			
			if ([user objectForKey:@"strSources"]) {
				self.sourceData =[user objectForKey:@"strSources"];
			}else
				self.sourceData = @"FMZL,SYXX,WGZL3";
			[self GpostToServer:@"0"];
			ifChang = YES;
			[self.dicArray removeAllObjects];
			TheRowNum = 0;
			[self.table removeFromSuperview];
			self.table = nil;
            tabview=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, Vheight-104)];
			self.table = tabview;
            [tabview release];
			self.table.backgroundColor = Main_Color;
			self.table.delegate = self;
			self.table.dataSource = self;
			[self.view insertSubview:self.table belowSubview:bar];

		}
	}
}
- (void)keyboardWillShow:(NSNotification *)notification {
    
    
    NSDictionary *userInfo = [notification userInfo];
    
    // Get the origin of the keyboard when it's displayed.
    NSValue* aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    
    CGRect keyboardRect = [aValue CGRectValue];
    
    UITextField *textField1 = (UITextField *)[self.view viewWithTag:1001];
    if (textField1.editing) {
		
		//        UIToolbar *toolbar = (UIToolbar *)[self.view viewWithTag:TOOLBARTAG];
		bar.frame = CGRectMake(0, Vheight-106-keyboardRect.size.height, 320, 44);
		//        toolbar.frame = CGRectMake(0.0f, tableView.frame.size.height+tableView.frame.origin.y, TABLE_WIDTH, 44.0f);    
    }
	//    NSLog(@"%f", keyboardRect.size.width);
}

-(IBAction)textFieldDone:(id)sender
{
    [sender resignFirstResponder];
    bar.frame = CGRectMake(0, Vheight-106, 320, 44);
}
-(IBAction)animationFinished
{
    aView = [[SmallViewPage alloc]initWithFrame:CGRectMake(0, Vheight-480, 320, Vheight-20)];
    aView.delegate = self;
    aView.nameTitle = @selector(getButtonTitle:);
    [self.view addSubview:aView];
    [aView becomeFirstResponder];
}

-(void)getButtonTitle:(SmallViewPage *)aview
{
    mess0 = aview.str;
    aButnLabel.text = NSLocalizedString(aview.mDisStr,nil);
    [aview removeFromSuperview];
}


//请求专利搜索接口
-(IBAction)GpostToServer:(NSString *)aFrom
{
	[self releaseSoap];
    app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [MBProgressHUD showHUDAddedTo:app.window animated:YES];
    mSoapHttp = [[SoapHttpManager alloc]init];
	mSoapHttp.delegate = self;
	mSoapHttp.OnSoapFail = @selector(GcanetFail);
	mSoapHttp.OnSoapRespond = @selector(GgetData);
	NSString *aTo = [NSString stringWithFormat:@"%d",[aFrom intValue]+10];
	if (self.sourceData==nil) {
		self.sourceData = @"FMZL,SYXX,WGZL";
	}
//    NSString *string = [[self.msg stringByReplacingOccurrencesOfString:@"(" withString:@"%28"] stringByReplacingOccurrencesOfString:@")" withString:@"%29"];
    NSString *string=self.msg;
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    NSString *DID=[user objectForKey:@"DID"];
    NSDictionary *jsonDic = [[NSDictionary alloc]initWithObjectsAndKeys:self.sourceData,@"strSources",string,@"strWhere",@"",@"strSortMethod",@"2",@"iOption",aFrom,@"startIndex",aTo,@"endIndex",@"",@"strSection",@"",@"strSynonymous",DID,@"strImei", nil];
    NSLog(@"jsonDic++%@",jsonDic);
	NSString *tString2 = [NSString stringWithFormat:@"http://59.151.99.154:8080/pss-mp/pos"];
	NSString *tString3 = @"";
	[mSoapHttp PostSoadMessage:jsonDic :tString2 :tString3];
	[jsonDic release];
	
}
-(IBAction)GgetData
{
	
	
    
    [MBProgressHUD hideHUDForView:app.window animated:YES];
    [mSoapHttp.mArray removeObjectAtIndex:0];
    [self.dicArray addObjectsFromArray:mSoapHttp.mArray];
    if (mSoapHttp.mArray.count==0) {
        NSString *where=[[self.msg componentsSeparatedByString:@"="]objectAtIndex:0];
        NSLog(@"where===%@",where);
        if ([where isEqualToString:@"公开（公告）日"]) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:NSLocalizedString(@"专利公开日为每周周三，本日期不是公开日日期",nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"确定",nil) otherButtonTitles:nil, nil];
            [alert show];
            [alert release];
        }
        else
        {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:NSLocalizedString(@"没有查询结果",nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"确定",nil) otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        }
    }else{
		if (self.arr.count==0) {
			self.arr = mSoapHttp.mgCateArray;
		}else{
			for (int i = 0; i<self.arr.count; i++) {
				for (int j = 0; j<mSoapHttp.mgCateArray.count; j++) {
					if ([[[self.arr objectAtIndex:i]objectForKey:@"name"]isEqualToString:[[mSoapHttp.mgCateArray objectAtIndex:j]objectForKey:@"name"]]) {
						[self.arr removeObjectAtIndex:i];
						[self.arr insertObject:[mSoapHttp.mgCateArray objectAtIndex:j] atIndex:i];
					}
				}
			}
		}
        
		
		gNum = 0;
		for (NSDictionary *aDic in  self.arr) {
			gNum = gNum + [[aDic objectForKey:@"total"]intValue];
		}
		if (self.dicArray.count==0) {
			gNum = 0;
		}
		if (ifChang) {
            if (ku==0) {
                self.gTitleString = [NSString stringWithFormat:NSLocalizedString(@"总共(%d)",nil),gNum];
            }
			
		}
	}
	ifChang = NO;
	[self.table reloadData];
	[self releaseSoap];
}
-(IBAction)GcanetFail
{
	[MBProgressHUD hideHUDForView:app.window animated:YES];
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:NSLocalizedString(@"网络连接失败！",nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"确定",nil) otherButtonTitles:nil];
    [alert show];
    [alert release];
}

- (void)viewDidUnload
{
	TheRowNum = 0;
	ifChang = YES;
//    self.list = nil;
    self.table = nil;
    self.arr = nil;
    self.detailString = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	if (self.dicArray.count==0) {
		return 0;
	}
    return self.dicArray.count%10==0?self.dicArray.count+1:self.dicArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *d= [NSString stringWithFormat:@"c%d%d",indexPath.row,TheRowNum];
	if (indexPath.row<self.dicArray.count) {
    ResultCell *cell = [self.table dequeueReusableCellWithIdentifier:d];
    if (cell == nil) {
        cell = [[[ResultCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:d]autorelease];
		cell.GcontentDic = [self.dicArray objectAtIndex:indexPath.row];
        
		cell.GtitleName = [NSString stringWithFormat:@"%d. %@",indexPath.row+1+TheRowNum,[[self.dicArray objectAtIndex:indexPath.row]objectForKey:@"name"]];
        NSLog(@"title++%@",cell.GtitleName);
		cell.gScore = [[[self.dicArray objectAtIndex:indexPath.row]objectForKey:@"gpa"]floatValue];
        cell.index=indexPath.row;
        cell.sourceData=self.sourceData;
        cell.nav=self.navigationController;
        [cell CellAddTextLabel];
    }
		
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [activityView stopAnimating];
    return cell;
	}
    //加载更多
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
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
	return cell;
}
//加载更多
-(void)gLoadMoreDate:(GLoadMoreTableViewCell *)cell
{
	[self GpostToServer:cell.mGStr];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (indexPath.row<self.dicArray.count) {
		NSString *gtShangBiao = [[NSString stringWithFormat:@"%d. %@",indexPath.row+1+TheRowNum,[[self.dicArray objectAtIndex:indexPath.row]objectForKey:@"name"]]stringByReplacingOccurrencesOfString:@"～lt;SUB～gt;" withString:@""];
		NSString *gtXiaBiao = [gtShangBiao stringByReplacingOccurrencesOfString:@"～lt;/SUB～gt;" withString:@""];
		NSString *gClearColor = [gtXiaBiao stringByReplacingOccurrencesOfString:@"～lt;font color=red～gt;" withString:@""];
		NSString *sizeString = [gClearColor stringByReplacingOccurrencesOfString:@"～lt;/font～gt;" withString:@""];
		
		CGSize size = [sizeString sizeWithFont:[UIFont systemFontOfSize:16.4] constrainedToSize:CGSizeMake(310, 1000) lineBreakMode:NSLineBreakByCharWrapping];
		if (size.height<=21) {
			size.height = 30;
		}else if (size.height>21&&size.height<43) {
			size.height = 60;
		}else if (size.height>42&&size.height<64) {
			size.height = 80;
		}else if (size.height>63) {
			size.height=105;
		}
    return 120+size.height;
	}
	return 50;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	return 30;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	gKuTableHeaderView *GaHeader = [[[gKuTableHeaderView alloc]initWithFrame:CGRectMake(0, 0, 320, 30)]autorelease];
	GaHeader.backgroundColor = [UIColor whiteColor];
	GaHeader.GmNum = self.gTitleString;
	GaHeader.GAddJumpView = @selector(GAddJumpView);
	GaHeader.GAddKuTableView = @selector(GAddKuTableView);
	GaHeader.delegate = self;
	[GaHeader GaddTitleAndImage];
	[GaHeader GaddJumpButton];
	return GaHeader;
	
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *tms1=nil;
    NSString *tms2=nil;
    NSString *tms=nil;
    [self.table deselectRowAtIndexPath:indexPath animated:YES];
    GNewDtailSearchTable *detailController = [[GNewDtailSearchTable alloc]init];
    NSLog(@"self.dicArray++%@",self.dicArray);
    NSDictionary *aDic = [self.dicArray objectAtIndex:indexPath.row];
    for (NSString *astr in  aDic.allKeys) {
        if ([astr isEqualToString:@"an"]) {
            tms1 = [@"an%3D" stringByAppendingString:[NSString stringWithFormat:@"'%@'",[aDic objectForKey:@"an"]]];
            tms1 = [tms1 stringByAppendingString:@" and "];
        }else if([astr isEqualToString:@"pnm"]){
           tms2 = [@"pnm%3D" stringByAppendingString:[NSString stringWithFormat:@"'%@'",[aDic objectForKey:@"pnm"]]];
        }
    }
    tms = [tms1 stringByAppendingString:tms2];
    detailController.detailMess = tms;
    NSLog(@"tmsResultPage%@",tms);
    [self.navigationController pushViewController:detailController animated:YES];
    [detailController release];    
}
//加载库选择按钮
-(IBAction)GAddKuTableView
{
	gkuTable = [[[GKuTableView alloc]initWithFrame:CGRectMake(0, 30,320,380) Array:self.arr]autorelease];
	gkuTable.nameTitle = @selector(selfTableViewReloadData:);
	gkuTable.delegate = self;
	[self.view addSubview:gkuTable];
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    gkuTable.hidden=YES;
    aView.hidden=YES;
}

//重载抬头
-(IBAction)selfTableViewReloadData:(GKuTableView *)sender
{
	if (sender.Gzong.intValue>0) {
        ku=1;
		self.gTitleString = [NSString stringWithFormat:@"%@(%@)",sender.str,sender.Gzong];
		if (sender.gTheRow<self.arr.count) {
			self.sourceData = [[self.arr objectAtIndex:sender.gTheRow]objectForKey:@"name"];
		}else{
			NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
			
			if ([user objectForKey:@"strSources"]) {
				self.sourceData =[user objectForKey:@"strSources"];
			}else
				self.sourceData = @"FMZL,SYXX,WGZL";
		}
		[self.dicArray removeAllObjects];
		[self GpostToServer:@"0"];
		ifChang = YES;
		TheRowNum = 0;
		[self.table removeFromSuperview];
		self.table = nil;
        tabview=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, Vheight-104)];
		self.table = tabview;
        [tabview release];
   
		self.table.backgroundColor = Main_Color;
		self.table.delegate = self;
		self.table.dataSource = self;
		[self.view insertSubview:self.table belowSubview:bar];
		
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
            NSInteger inputNum=[[alertView textFieldAtIndex:0].text integerValue] ;
            NSInteger SNum=gNum+1;
            if (inputNum&&inputNum<SNum&&inputNum>0)
            {
                
                NSString *astr = [NSString stringWithFormat:@"%d",[[alertView textFieldAtIndex:0].text intValue]-1];
                TheRowNum = [astr intValue];
                NSLog(@"astr+++%@",astr);
                [self.dicArray removeAllObjects];
                [self GpostToServer:astr];
                
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

-(void)dealloc
{
	self.dicArray = nil;
//	self.list = nil;
    self.table = nil;
    self.arr = nil;
    self.detailString = nil;
    [bar release];
	[self releaseSoap];
	[super dealloc];
}
@end
