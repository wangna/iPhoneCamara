//
//  SearchPageViewController.m
//  PatentSearch
//
//  Created by wei on 12-8-13.
//  Copyright (c) 2012年 wei. All rights reserved.
//

#import "SearchPageViewController.h"
#import "LibrarySetting.h"
#import "ConditionSetting.h"
#import "searchData.h"
#import "ResultPage.h"
#import "CustomCell.h"
#import "GcustomToolBar.h"
@interface SearchPageViewController ()
{
	GcustomToolBar *tab;
}

@end

@implementation SearchPageViewController
@synthesize tableView;
@synthesize array2;
@synthesize mess;
@synthesize searchArray;
@synthesize field;
@synthesize label;
@synthesize dataString;
//保存搜索历史
-(NSString *)GsearchHistPath{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	return [documentsDirectory stringByAppendingPathComponent:@"G_search_Hist_Name.plist"];
}

-(id)init
{
	if (self = [super init]) {
		self.title = NSLocalizedString(@"专利查询",nil);
	}
	return self;
}
-(void)loadView
{
    Vheight=[UIScreen mainScreen].bounds.size.height;
	UIView *tView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, Vheight-20)];
	self.view = tView;
	self.navigationController.navigationBarHidden = NO;
	self.view.backgroundColor = Main_Color;
	[tView release];
	
}
- (void)viewDidLoad
{
    if ([[[UIDevice currentDevice]systemVersion]floatValue]>=7.0)
        self.edgesForExtendedLayout = UIRectEdgeNone;
	self.navigationController.navigationBarHidden = NO;
    array = [[NSMutableArray alloc]initWithCapacity:0];
    searchArray = [[NSMutableArray alloc]initWithCapacity:0];
    valueDic = [[NSMutableDictionary alloc]initWithCapacity:0];
    
    
   tab = [[GcustomToolBar alloc]initWithFrame:CGRectMake(0, Vheight-104, 320, 40)];

    
    UIBarButtonItem *libraryButton = [[UIBarButtonItem alloc]initWithTitle:NSLocalizedString(@"库设置",nil) style:UIBarButtonItemStyleBordered target:self action:@selector(Settting:)];
    libraryButton.width = 110;
    libraryButton.tag = 1;
    
    UIBarButtonItem *conditingButton = [[UIBarButtonItem alloc]initWithTitle:NSLocalizedString(@"条件设置",nil) style:UIBarButtonItemStyleBordered target:self action:@selector(Settting:)];
	conditingButton.width = 100;
    conditingButton.tag = 2;
	
	UIBarButtonItem *aSpaceItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:@selector(Settting:)];
    UIBarButtonItem *searchButton = [[UIBarButtonItem alloc]initWithTitle:NSLocalizedString(@"查询",nil) style:UIBarButtonItemStyleBordered target:self action:@selector(Settting:)];;
    searchButton.tag = 3;
    if ([[[UIDevice currentDevice]systemVersion]floatValue]>=7.0) {
        [libraryButton setTintColor:[UIColor whiteColor]];
        [conditingButton setTintColor:[UIColor whiteColor]];
        [aSpaceItem setTintColor:[UIColor whiteColor]];
        [searchButton setTintColor:[UIColor whiteColor]];
    }
	NSArray *aTarArray = [[NSArray alloc]initWithObjects:libraryButton,conditingButton,aSpaceItem,searchButton, nil];
	[libraryButton release];
	[conditingButton release];
	[aSpaceItem release];
	[searchButton release];
	tab.items = aTarArray;
	[aTarArray release];
    UITableView *tabView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, Vheight-104) style:UITableViewStyleGrouped];
    self.tableView = tabView;
    [tabView release];
    self.tableView.backgroundView=[[[UIView alloc]init]autorelease];
	self.tableView.backgroundColor = Main_Color;
    [self.view addSubview:self.tableView];
    [self.view addSubview:tab];
    [tab release];
   
	UIBarButtonItem *rightButnItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"Gfirst.png"] style:UIBarButtonItemStyleBordered target:self action:@selector(SelfPopToROOtViewControl)];
    self.navigationItem.rightBarButtonItem = rightButnItem;
	[rightButnItem release];

	}
-(void)SelfPopToROOtViewControl
{
	[self.navigationController popToRootViewControllerAnimated:YES];
}
-(void)viewWillAppear:(BOOL)animated
{
      [self GetUpdate];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView reloadData];
    [array removeAllObjects];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [self.tableView removeFromSuperview];
    [self viewDidLoad];
}
-(void)GetUpdate
{
    
    NSDictionary *infoDic=[[NSBundle mainBundle]infoDictionary];
    NSString *nowVersion=[infoDic objectForKey:@"CFBundleVersion"];
    NSURL *url=[NSURL URLWithString:@"https://itunes.apple.com/cn/lookup?bundleId=com.lifeng.zhuanlizhifa"];
    NSString *file=[NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    if (file.length<100)
    {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        return;
    }
    
    NSRange substr=[file rangeOfString:@"\"version\":\""];
    NSRange substr2=[file rangeOfString:@"\""options:nil range:NSMakeRange(substr.location+substr.length,10)];
    
    NSRange range={substr.location+substr.length,substr2.location-substr.location-substr.length};
    NSString *newVersion=[file substringWithRange:range];
    if (![nowVersion isEqualToString:newVersion]) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"检查到版本有更新!" delegate:self cancelButtonTitle:@"以后安装" otherButtonTitles:@"现在安装", nil];
        alert.delegate=self;
        [alert show];
    }
    else
    {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        return;
    }
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex) {
        NSURL *url=[NSURL URLWithString:@"https://itunes.apple.com/us/app/zhuan-li-xing-zheng-zhi-fa/id654855126?l=zh&ls=1&mt=8"];
        [[UIApplication sharedApplication]openURL:url];
    }
}
#pragma mark -
#pragma mark Table view data source


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
   NSMutableDictionary *dicValue=[NSMutableDictionary dictionaryWithDictionary:[searchData GetNowSearchCondition]];
    return [dicValue.allKeys count];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSMutableDictionary *dicValue=[NSMutableDictionary dictionaryWithDictionary:[searchData GetNowSearchCondition]];
    NSString *keys=[NSString stringWithFormat:@"list%d",section];
    array2=[dicValue objectForKey:keys];
    return [array2 count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CustomCellIdentifier= [NSString stringWithFormat:@"c2131%d%d",indexPath.section,indexPath.row];
    CustomCell *cell = (CustomCell *)[self.tableView dequeueReusableCellWithIdentifier:CustomCellIdentifier];
    if (cell == nil) {
        cell = [[[CustomCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CustomCellIdentifier]autorelease];
        cell.delegate = self;
        cell.GetfieldText = @selector(getTheText:);
        cell.selectionStyle=UITableViewCellAccessoryNone;
        [cell addtextfieldWithTag:indexPath.row];
        NSInteger section=[indexPath section];
        NSMutableDictionary *dicValue=[NSMutableDictionary dictionaryWithDictionary:[searchData GetNowSearchCondition]];
        NSMutableArray *arra=[dicValue objectForKey:[NSString stringWithFormat:@"section%d",section]];
        NSMutableArray *arrylist=[dicValue objectForKey:[NSString stringWithFormat:@"list%d",section]];
        NSMutableArray *arra1=[dicValue objectForKey:[NSString stringWithFormat:@"value%d",section]];
        cell.mGString = [arra1 objectAtIndex:[[arrylist objectAtIndex:indexPath.row]intValue]];
        cell.label.text = NSLocalizedString([arra objectAtIndex:[[arrylist objectAtIndex:indexPath.row]intValue]],nil);
        cell.label.font = [UIFont fontWithName:nil size:12];
    }

//    [cell GetfieldText];
    return cell;
     
}

-(BOOL)ifAddTheString:(NSString *)str:(NSString *)ar
{
    for (int i = 0; i<str.length; i++) {
        if ([ar characterAtIndex:i]==[str characterAtIndex:i]) {
            
        }else{
            return NO;
        }
    }
    return YES;
}
-(void)getTheText:(CustomCell *)sender
{
    NSString *mess1 = sender.gTextfield.text;
   	NSString *mess2 = [sender.mGString stringByAppendingString:@"="];
    if ([sender.mGString isEqualToString:@"申请号"]) {
        mess1=[mess1 stringByReplacingOccurrencesOfString:@"Z" withString:@""];
        mess1=[mess1 stringByReplacingOccurrencesOfString:@"z" withString:@""];
        mess1=[mess1 stringByReplacingOccurrencesOfString:@"l" withString:@""];
        mess1=[mess1 stringByReplacingOccurrencesOfString:@"L" withString:@""];
        mess1=[mess1 stringByReplacingOccurrencesOfString:@"." withString:@""];
        mess1=[mess1 stringByReplacingOccurrencesOfString:@" " withString:@""];
        mess1=[[[mess1 stringByReplacingOccurrencesOfString:@" " withString:@""]stringByReplacingOccurrencesOfString:@"CN" withString:@""]stringByReplacingOccurrencesOfString:@"cn" withString:@""];
        NSLog(@"mess1 count__%d",[mess1 length]);
        NSMutableString *mess11=[NSMutableString stringWithCapacity:0];
        [mess11 setString:mess1];
        if ([mess1 length]==9) {
            [mess11 insertString:@"." atIndex:8];
            NSLog(@"mess11---%@",mess11);
        }
        else if([mess1 length]==13)
        {
            [mess11 insertString:@"." atIndex:12];
        }
        mess1=[NSString stringWithFormat:@"%@",mess11];
    }
    
    NSString *mess3 = [NSString stringWithFormat:@"%@%@%@%@%@",@"'",@"%25",mess1,@"%25",@"'"];
    [NSString stringWithFormat:@"%@%@%@",@"'",mess1,@"'"];
//	if ([sender.mGString isEqualToString:@"分类号"]||[sender.mGString isEqualToString:@"申请号"]||[sender.mGString isEqualToString:@"主分类号"]||[sender.mGString isEqualToString:@"公开（公告）号"]) {
//		mess3 = [NSString stringWithFormat:@"%@%@%@",@"'",mess1,@"'"];
//	}
    if ([sender.mGString isEqualToString:@"名称"]||[sender.mGString isEqualToString:@"申请日"]||[sender.mGString isEqualToString:@"公开（公告）日"]) {
		mess3 = [NSString stringWithFormat:@"%@%@%@",@"'",mess1,@"'"];
	}
    
	NSString *mess0 = [mess2 stringByAppendingString:[NSString stringWithFormat:@"%@",mess3]];
	if (sender.gTextfield.text.length) {
	NSArray *aRR = [[NSArray alloc]initWithArray:array];
	[array removeAllObjects];
	for (NSString *astri in  aRR) {
		if ([self ifAddTheString:mess2 :astri]) {
			
		}else{
			[array addObject:astri];
		}
	}
	[array addObject:mess0];
	self.dataString = [array componentsJoinedByString:@" and "];
    [aRR release];
	}
    
}
#pragma mark -
#pragma mark Table delegate Methods


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell= [self.tableView cellForRowAtIndexPath:indexPath];
    for (UIView *view in cell.contentView.subviews) {
        if ([[view class] isSubclassOfClass:[UITextField class]]) {
            [view becomeFirstResponder];
            view.hidden=NO;
        }
    }
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}


-(IBAction)textFieldDone:(id)sender
{
    [self.field resignFirstResponder];

}
-(IBAction)goBack:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (void)viewDidUnload
{
   
    [super viewDidUnload];
    // Release any retained subviews of the main view.设置-专利库
}
-(void)dealloc
{
	self.searchArray = nil;
    self.tableView = nil;
    self.array2 = nil;
    self.mess = nil;
    self.field = nil;
    self.label = nil;
    [array release];
	[super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
//保存搜索历史
-(void)GkeepSearchHist:(NSString *)tj AndKu:(NSString *)ku
{
	NSMutableArray *gSaveArray = [[NSMutableArray alloc]initWithCapacity:10];
	NSDate *gDate = [[NSDate alloc]init];
	if ([[NSFileManager defaultManager]fileExistsAtPath:[self GsearchHistPath]]) {
		NSArray *gA = [[NSArray alloc]initWithContentsOfFile:[self GsearchHistPath]];
		[gSaveArray addObjectsFromArray:gA];
		[gA release];
	}
	NSDictionary *aDic = [[NSDictionary alloc]initWithObjectsAndKeys:tj,@"gTiaoJian",ku,@"gkuString",gDate,@"gDateString", nil];
	[gSaveArray insertObject:aDic atIndex:0];
	[gSaveArray writeToFile:[self GsearchHistPath] atomically:YES];
	[gDate release];
	[aDic release];
	[gSaveArray release];
}

-(IBAction)Settting:(id)sender
{
    UIBarButtonItem *button = (UIBarButtonItem *)sender;
    if (button.tag ==1)
    {
        LibrarySetting *library = [[LibrarySetting alloc]init];
        [self.navigationController pushViewController:library animated:YES];
        [library release];
    }
    else if (button.tag ==2)
    {
        ConditionSetting *condition = [[ConditionSetting alloc]init];
        [self.navigationController pushViewController:condition animated:YES];
        [condition release];
    }
    else if (button.tag ==3)
    {
		NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
	if (self.dataString.length) {
		ResultPage *result = [[ResultPage alloc]init];
		if ([user objectForKey:@"strSources"]) {
			result.sourceData = [user objectForKey:@"strSources"];
			result.msg = self.dataString;
		}else{
			result.msg = self.dataString;
			result.sourceData = @"FMZL,SYXX,WGZL";	
		}
		[self.navigationController pushViewController:result animated:YES];
		[result release];
		[self GkeepSearchHist:self.dataString AndKu:result.sourceData];
	}else{
		UIAlertView *tAlert = [[UIAlertView alloc]initWithTitle:@"" message:NSLocalizedString(@"请输入搜索条件",nil) delegate:self cancelButtonTitle:NSLocalizedString(@"确定",nil) otherButtonTitles:nil];
		[tAlert show];
		[tAlert release];
	}
    }
}


@end
