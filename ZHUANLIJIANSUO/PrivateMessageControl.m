//
//  PrivateMessageControl.m
//  ZHUANLIJIANSUO
//
//  Created by chenhuiguo on 12-8-1.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "PrivateMessageControl.h"
#import "GAmendPrivateMessage.h"
#import "system.h"
#import "UserInfoManager.h"
@interface PrivateMessageControl()
{
	NSDictionary *mGifLoginDic;
}
@end
@implementation PrivateMessageControl

//读取用户名，密码
-(NSString *)userNamePath{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	return [documentsDirectory stringByAppendingPathComponent:@"Gu_ser_Name.plist"];
}
-(id)init
{
	if (self = [super init]) {
		self.title = NSLocalizedString(@"设置-账户",nil);
//		self.navigationItem.leftBarButtonItem.title = @"返回";
	}
	return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle


- (void)loadView
{
	UIView *tView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 460)];
	self.view = tView;
	self.view.backgroundColor = Main_Color;
	self.navigationController.navigationBarHidden = NO;
	[tView release];
}
-(void)GaddButton
{
    UILabel *tGautoLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 10, 280, 40)];
    tGautoLabel.layer.borderWidth=1;
    tGautoLabel.layer.borderColor = [[UIColor colorWithRed:150.0/255.0 green:150.0/255.0 blue:150.0/255.0 alpha:0.8]CGColor];
	tGautoLabel.layer.cornerRadius = 6;
	tGautoLabel.backgroundColor = [UIColor clearColor];
	tGautoLabel.textColor = Text_Color_Green;
	tGautoLabel.text = NSLocalizedString(@" 自动登录",nil);
    tGautoLabel.font=[UIFont systemFontOfSize:18];
    [tGautoLabel setBackgroundColor:[UIColor whiteColor]];
	[self.view addSubview:tGautoLabel];
	[tGautoLabel release];
	UIButton *tGbt = [UIButton buttonWithType:UIButtonTypeCustom];
	tGbt.frame = CGRectMake(20, 10, 280, 40);
	if ([[NSFileManager defaultManager]fileExistsAtPath:[self userNamePath]]) {
		tGbt.selected = YES;
	}
	[tGbt setImage:[UIImage imageNamed:@"enslect.png"] forState:UIControlStateNormal];
	[tGbt setImage:[UIImage imageNamed:@"slected.png"]forState:UIControlStateSelected];
	tGbt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
	[tGbt addTarget:self action:@selector(ifAutoLogin:) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:tGbt];
	

	
	UITableView *tGview = [[UITableView alloc]initWithFrame:CGRectMake(20, 80, 280, 174)style:UITableViewStylePlain];
	tGview.backgroundColor = [UIColor whiteColor];
	tGview.layer.borderWidth = 1;
	tGview.delegate = self;
	tGview.dataSource = self;
	tGview.scrollEnabled = NO;
	tGview.layer.borderColor = [[UIColor colorWithRed:150.0/255.0 green:150.0/255.0 blue:150.0/255.0 alpha:0.8]CGColor];
	tGview.layer.cornerRadius = 10;
	[self.view addSubview:tGview];
	[tGview release];
}
-(void)signout
{
    kkSessionID=@"";
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self zhuxiao];
}
-(void)zhuxiao
{
    if ([[NSFileManager defaultManager]fileExistsAtPath:[self userNamePath]]) {
        
        [self releaseSoap];
        mSoapHttp = [[SoapHttpManager alloc]init];
        mSoapHttp.delegate = self;
        mSoapHttp.OnSoapFail = @selector(GcanetFail);
        mSoapHttp.OnSoapRespond = @selector(GgetData);
        NSUserDefaults *name=[NSUserDefaults standardUserDefaults];
        NSString *username=[name objectForKey:@"name"];
        NSString *word=[name objectForKey:@"word"];
        NSDictionary *JsonDIc = [[NSDictionary alloc]initWithObjectsAndKeys:username,@"username",word,@"mypassword",LINK_PASSWORD,@"password",@"interface",@"m",@"userLogout",@"a", nil];
        NSString *tString2 = [NSString stringWithFormat:@"%@%@",BASE_URL,@"&a=userLogout"];
        NSString *tString3 = @"";
        [mSoapHttp PostSoadMessage:JsonDIc :tString2 :tString3];
        [JsonDIc release];
        [name removeObjectForKey:@"name"];
        [name removeObjectForKey:@"word"];
        [[NSFileManager defaultManager]removeItemAtPath:[self userNamePath] error:nil];
    }
    else
    {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}
-(void)GgetData
{
    NSLog(@"DATA");
    NSString *message=[[mSoapHttp.mArray objectAtIndex:0]objectForKey:@"status"];
    if ([message isEqualToString:@"0"]) {
        
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    NSLog(@"arr+++%@",message);
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 4;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSInteger row = [indexPath row];
	NSLog(@"%d",row);
	NSArray *tNameArray = [[NSArray alloc]initWithObjects:@"昵称",@"姓名",@"电话",@"Email", nil];
	NSArray *tContentArray = [[NSArray alloc]initWithObjects:kkUserName,kkLinkman,kkmobilePhone,kkemail, nil];
	static NSString *cellTableIdentifier =@"italicsCellTableIdentifier";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellTableIdentifier];
	if (cell == nil) {
		cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellTableIdentifier]autorelease];
		
		cell.imageView.image = [UIImage imageNamed:@"point.png"];
		cell.textLabel.text = NSLocalizedString([tNameArray objectAtIndex:row],nil);
		cell.textLabel.font = [UIFont systemFontOfSize:17.0];
		cell.textLabel.textColor = Text_Color_Green;
		cell.textLabel.backgroundColor = [UIColor clearColor];
		cell.detailTextLabel.backgroundColor = [UIColor clearColor];
		cell.detailTextLabel.textColor = [UIColor colorWithRed:0.0/255.0 green:10.0/255.0 blue:20.0/255.0 alpha:1.0];
		cell.detailTextLabel.font = [UIFont systemFontOfSize:17.0];
		cell.detailTextLabel.text = [tContentArray objectAtIndex:row];
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
		
	}
	[tNameArray release];
	[tContentArray release];
	return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSInteger row = [indexPath row];
	NSArray *aArray = [[NSArray alloc]initWithObjects:@"nickname",@"linkman",@"linktel",@"email", nil];
	GAmendPrivateMessage *tGAmend = [[GAmendPrivateMessage alloc]initWithString:[aArray objectAtIndex:row]];
	[self.navigationController pushViewController:tGAmend animated:YES];
	[aArray release];
	[tGAmend release];
}

- (void)viewDidLoad
{
    if ([[[UIDevice currentDevice]systemVersion]floatValue]>=7.0)
        self.edgesForExtendedLayout = UIRectEdgeNone;
	if ([[NSFileManager defaultManager]fileExistsAtPath:[self userNamePath]]) {
		mGifLoginDic = [[NSDictionary alloc]initWithContentsOfFile:[self userNamePath]];
	}else{
		mGifLoginDic = [[NSDictionary alloc]initWithObjectsAndKeys:kkloginName,@"userName",kkPassWord,@"passWord", nil];
	}
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reload:) name:@"RL" object:nil];

    [self GaddButton];
	UIBarButtonItem *rightButnItem = [[UIBarButtonItem alloc]initWithTitle:NSLocalizedString(@"注销",nil) style:UIBarButtonItemStyleBordered target:self action:@selector(signout)];
    self.navigationItem.rightBarButtonItem = rightButnItem;
	[rightButnItem release];
	
}
-(void)reload:(NSNotification *)note
{
    kkUserName=[note object];
    [self GaddButton];
}
-(void)SelfPopToROOtViewControl
{
	[self.navigationController popToRootViewControllerAnimated:YES];
}
-(void)ifAutoLogin:(UIButton *)sender
{
	sender.selected = !sender.selected;
	if (sender.selected) {
		[mGifLoginDic writeToFile:[self userNamePath] atomically:YES];
	}else{
		[[NSFileManager defaultManager]removeItemAtPath:[self userNamePath] error:nil];
	}
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
-(void)releaseSoap
{
	if (mSoapHttp) {
		[mSoapHttp Cancel];
		[mSoapHttp release];
		mSoapHttp = nil;
	}
}

-(void)dealloc
{
	[mGifLoginDic release];
	[super dealloc];
}
@end
