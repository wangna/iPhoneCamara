//
//  HomeButtonViewController.m
//  ZHUANLIJIANSUO
//
//  Created by chenhuiguo on 12-7-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "HomeButtonViewController.h"
#import "GtabbarHeader.h"
#import "ResultPage.h"
#import "GFanKuiVIewControl.h"
#import "LoadView.h"
#import "UserInfoManager.h"
#import "AboutAppViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "NSString+SBJSON.h"
#import "AppDelegate.h"
@interface HomeButtonViewController()
{
	SoapHttpManager *mSoapHttp;
	LoadView *mLoad;
    float Vheight;
    AppDelegate *app;
}
@property(retain,nonatomic)UIImageView *mGLogimage;
@end
@implementation HomeButtonViewController
@synthesize mGLogimage,gTSerchBt,mGSearchField,tmpDay,library;

//读取用户名，密码
-(NSString *)userNamePath{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	return [documentsDirectory stringByAppendingPathComponent:@"Gu_ser_Name.plist"];
}

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
		self.navigationController.navigationBarHidden = YES;
	}
    	return self;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
	self.navigationController.navigationBarHidden = YES;
	UIView *tGview;
//	if () {
		tGview = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
//	}else{
//		tGview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 768, 1004)];
//	}
	Vheight=[UIScreen mainScreen].bounds.size.height;
    NSLog(@"Vheight---%f",Vheight);
	self.view = tGview;
	self.view.backgroundColor = Main_Color;
    
	[tGview release];	
}
//自动登录
-(void)GautoLogin
{

	UILabel *GtLoginLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/3, self.view.frame.size.height*275/460, self.view.frame.size.width/3, 30)];
	GtLoginLabel.backgroundColor = [UIColor clearColor];
	GtLoginLabel.text = NSLocalizedString(@"正在登录...",nil);
	GtLoginLabel.textAlignment = NSTextAlignmentCenter;
	GtLoginLabel.textColor = [UIColor whiteColor];
	[self.mGLogimage addSubview:GtLoginLabel];
	[GtLoginLabel release];
	[self releaseSoap];
	mSoapHttp = [[SoapHttpManager alloc]init];
	mSoapHttp.delegate = self;
	mSoapHttp.OnSoapFail = @selector(GcanetFail);
	mSoapHttp.OnSoapRespond = @selector(GgetLoginData);
	NSDictionary *aDIc = [[NSDictionary alloc]initWithContentsOfFile:[self userNamePath]];
	NSDictionary *JsonDIc = [[NSDictionary alloc]initWithObjectsAndKeys:[aDIc objectForKey:@"userName"],@"username",[aDIc objectForKey:@"passWord"],@"mypassword",LINK_PASSWORD,@"password",@"interface",@"m",@"userlogin",@"a", nil];
	NSString *tString2 = [NSString stringWithFormat:@"%@%@",BASE_URL,@"&a=userlogin"];	
	NSString *tString3 = @"";
	[mSoapHttp PostSoadMessage:JsonDIc :tString2 :tString3];
	[JsonDIc release];
	[aDIc release];
}
//搜索条
-(void)GaddSearchBarAndButton
{
	UIImageView *Gserchbar = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 300, 40)];
	Gserchbar.image = [UIImage imageNamed:@"GsearchBack.png"];
	[self.view addSubview:Gserchbar];
	[Gserchbar release];
	
	UIImageView *GborderImage = [[UIImageView alloc]initWithFrame:CGRectMake(20, 15, 245, 30)];
	GborderImage.image = [UIImage imageNamed:@"GSearchKuang.png"];
	[self.view addSubview:GborderImage];
	[GborderImage release];
	
	mGSearchField = [[UITextField alloc]initWithFrame:CGRectMake(25, 15, 230, 30)];
    mGSearchField.clearButtonMode=UITextFieldViewModeWhileEditing;
	mGSearchField.placeholder = NSLocalizedString(@"请输入搜索条件",nil);
    mGSearchField.font=[UIFont systemFontOfSize:16];
	mGSearchField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
	[mGSearchField addTarget:self action:@selector(resignFirstResponder) forControlEvents:UIControlEventEditingDidEndOnExit];
	[self.view addSubview:mGSearchField];
	[mGSearchField release];
	
	UIImageView *GbuTtonImage = [[UIImageView alloc]initWithFrame:CGRectMake(270, 15, 30, 30)];
	GbuTtonImage.image = [UIImage imageNamed:@"SerchBt.png"];
	[self.view addSubview:GbuTtonImage];
	[GbuTtonImage release];
	//在放大镜图片上放了Custom的button
	self.gTSerchBt = [UIButton buttonWithType:UIButtonTypeCustom];
	gTSerchBt.frame = CGRectMake(270, 10, 60, 40);
	[gTSerchBt addTarget:self action:@selector(GSearchTheZhuanli) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:gTSerchBt];	

}
//九宫按钮
-(void)GaddButtonAndSerchbar
{
		
	NSArray *GbtImageArray = [[NSArray alloc]initWithObjects:@"Hbt1.png",@"Hbt2.png",@"Hbt3.png",@"Hbt4.png",@"Hbt5.png",@"Hbt9.png",@"Hbt8.png",@"CA.png",@"Camera.png", nil];
	NSArray *tLabelArray = [[NSArray alloc]initWithObjects:NSLocalizedString(@"专利查询",nil),NSLocalizedString(@"查询历史",nil),NSLocalizedString(@"我的收藏",nil),NSLocalizedString(@"代理查询",nil),NSLocalizedString(@"代理分布",nil),NSLocalizedString(@"应用中心",nil),NSLocalizedString(@"专利信息网",nil),NSLocalizedString(@"我的取证",nil),NSLocalizedString(@"相机取证",nil), nil];
	int xSpatOr = 20;
    int ySpotOr = 80;
	for (int i = 0; i<[GbtImageArray count]; i++) {
		if (i==0) {
			ySpotOr = 80;
			xSpatOr = 20;
		}else if (i!=0&&i%3==0) {
			xSpatOr= 20;
			ySpotOr = ySpotOr +100+(Vheight-480)/2.5;
		}else{
			xSpatOr = xSpatOr +110;
		}
		UIButton *tGbt = [UIButton buttonWithType:UIButtonTypeCustom];
		tGbt.frame = CGRectMake(xSpatOr, ySpotOr, 60, 60);
		tGbt.tag = 1000+i;
		[tGbt setImage:[UIImage imageNamed:[GbtImageArray objectAtIndex:i]] forState:UIControlStateNormal];
		[tGbt addTarget:self action:@selector(GbuttonAction:) forControlEvents:UIControlEventTouchUpInside];
		[self.view addSubview:tGbt];
		UILabel *tGlabel = [[UILabel alloc]initWithFrame:CGRectMake(tGbt.frame.origin.x-20, tGbt.frame.origin.y+60, 100, 30)];
		tGlabel.text = NSLocalizedString([tLabelArray objectAtIndex:i],nil);
		tGlabel.backgroundColor = [UIColor clearColor];
		tGlabel.textAlignment = NSTextAlignmentCenter;
		[self.view addSubview:tGlabel];
		[tGlabel release];
	}
	[GbtImageArray release];
	[tLabelArray release];
}
//底部按钮
-(void)GaddTabbarButton
{
	UIImageView *tGtabar = [[UIImageView alloc]initWithFrame:CGRectMake(0, Vheight-70, 320, 50)];
	tGtabar.image = [UIImage imageNamed:@"Gxia.png"];
	[self.view addSubview:tGtabar];
	[tGtabar release];
	
	NSArray *GbtImageArray = [[NSArray alloc]initWithObjects:@"Login.png",@"GamendPass.png",@"Gprivate.png",@"gSysSet.png",@"more.png",nil];
NSArray *tLabelArray = [[NSArray alloc]initWithObjects:NSLocalizedString(@"登录",nil),NSLocalizedString(@"更改密码",nil),NSLocalizedString(@"个人信息",nil),NSLocalizedString(@"系统设置",nil),@"关于软件",nil];
	for (int i = 0; i<[GbtImageArray count]; i++) {
		UIButton *tGbt = [UIButton buttonWithType:UIButtonTypeCustom];
		tGbt.frame = CGRectMake(i*62+1, Vheight-70, 62, 50);
		tGbt.tag = 2000+i;
		[tGbt addTarget:self action:@selector(GTabBarbuttonAction:) forControlEvents:UIControlEventTouchUpInside];
		[self.view addSubview:tGbt];
		
		UIImageView *tGbtImage = [[UIImageView alloc]initWithFrame:CGRectMake(1, 3, 60, 31)];
		tGbtImage.image = [UIImage imageNamed:[GbtImageArray objectAtIndex:i]];
		[tGbt addSubview:tGbtImage];
		[tGbtImage release];
		
		UILabel *tGlabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 35, 62, 15)];
		tGlabel.text = NSLocalizedString([tLabelArray objectAtIndex:i],nil);
		tGlabel.backgroundColor = [UIColor clearColor];
		tGlabel.textColor = [UIColor whiteColor];
		tGlabel.font = [UIFont systemFontOfSize:11.0];
		tGlabel.textAlignment = NSTextAlignmentCenter;
		[tGbt addSubview:tGlabel];
		[tGlabel release];
	}
	[GbtImageArray release];
	[tLabelArray release];
	
}

- (void)viewDidLoad
{
    if ([[[UIDevice currentDevice]systemVersion]floatValue]>=7.0) {
        self.view.bounds=CGRectMake(0, -20, self.view.frame.size.width, self.view.frame.size.height);
    }
    if ([[NSFileManager defaultManager]fileExistsAtPath:[self userNamePath]]) {
		[self GautoLogin];
	}
    app=(AppDelegate *)[UIApplication sharedApplication].delegate;

	self.navigationController.navigationBarHidden = YES;
    self.title=NSLocalizedString(@"首页",nil);
	[self GaddSearchBarAndButton];
	[self GaddButtonAndSerchbar];
	[self GaddTabbarButton];
    library=[[ALAssetsLibrary alloc]init];

	[self performSelector:@selector(GremoveImageview) withObject:nil afterDelay:2.0];

}
//删除loadImage
-(void)GremoveImageview
{
	[self.mGLogimage removeFromSuperview];

	
}
//获取登录用户数据
-(void)GgetLoginData
{
	if ([mSoapHttp.mArray count]>0) {
		if ([mSoapHttp.mArray count]>1) {
			kkSessionID = [[mSoapHttp.mArray objectAtIndex:0]objectForKey:@"SessionID"];
			if ([[mSoapHttp.mArray objectAtIndex:1]objectForKey:@"nickname"]) {
				kkUserName = [[mSoapHttp.mArray objectAtIndex:1]objectForKey:@"nickname"];
			}
			if ([[mSoapHttp.mArray objectAtIndex:1]objectForKey:@"linktel"]) {
				kkmobilePhone = [[mSoapHttp.mArray objectAtIndex:1]objectForKey:@"linktel"];
			}
			if ([[mSoapHttp.mArray objectAtIndex:1]objectForKey:@"email"]) {
				kkemail = [[mSoapHttp.mArray objectAtIndex:1]objectForKey:@"email"];
			}
			if ([[mSoapHttp.mArray objectAtIndex:1]objectForKey:@"username"]) {
				kkloginName = [[mSoapHttp.mArray objectAtIndex:1]objectForKey:@"username"];
			}
			if ([[mSoapHttp.mArray objectAtIndex:1]objectForKey:@"linkman"]) {
				kkLinkman = [[mSoapHttp.mArray objectAtIndex:1]objectForKey:@"linkman"];
			}

		}else{
			UIAlertView *tAlert = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"提示",nil) message:[[mSoapHttp.mArray objectAtIndex:0]objectForKey:@"message"] delegate:nil cancelButtonTitle:NSLocalizedString(@"确定",nil) otherButtonTitles: nil];
			[tAlert show];
			[tAlert release];
		}
	}
	if (self.mGLogimage) {
		[self.mGLogimage removeFromSuperview];
	}
	[self releaseSoap];
}

-(void)viewWillAppear:(BOOL)animated
{
	self.navigationController.navigationBarHidden = YES;
	[super viewWillAppear:animated];
	
}

//获得关注数据
-(void)GgetData
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
	GPatentAtentionTable *gPatentT = [[GPatentAtentionTable alloc]init];
    NSArray *arrnew=[[mSoapHttp.jsonStr JSONValue]objectForKey:@"mycollectinfos"];

	gPatentT.mGAtentionArray =[NSMutableArray arrayWithArray:arrnew];
	[self.navigationController pushViewController:gPatentT animated:YES];
    [gPatentT release];
	[self releaseSoap];
}
//模糊搜索
-(IBAction)GSearchTheZhuanli
{
    NSLog(@"text====%d==",[mGSearchField.text length]);
    if ([mGSearchField.text length]==0) {
       
            UIAlertView *alertNULL=[[UIAlertView alloc]initWithTitle:NSLocalizedString(@"请输入要检索的内容",nil) message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertNULL show];
            [alertNULL release];
    
    }
	else  {
		NSArray *aRR = [[NSArray alloc]initWithObjects:@"名称",@"申请号",@"申请（专利权）人",@"摘要",nil];
		NSMutableArray *gArray = [[NSMutableArray alloc]initWithCapacity:10];
		for (int i = 0; i<aRR.count; i++) {
            if (i==1) {
                NSString *aStr = [NSString stringWithFormat:@"名称%@%@%@%@%@",@"%3D",@"'",@"%25",mGSearchField.text,@"'"];
                [gArray addObject:aStr];

            }else if(i==2)
            {
                 NSString *mess1 = mGSearchField.text;
                mess1=[mess1 stringByReplacingOccurrencesOfString:@"Z" withString:@""];
                mess1=[mess1 stringByReplacingOccurrencesOfString:@"z" withString:@""];
                mess1=[mess1 stringByReplacingOccurrencesOfString:@"l" withString:@""];
                mess1=[mess1 stringByReplacingOccurrencesOfString:@"L" withString:@""];
                mess1=[mess1 stringByReplacingOccurrencesOfString:@"." withString:@""];
                mess1=[mess1 stringByReplacingOccurrencesOfString:@" " withString:@""];
                mess1=[mess1 stringByReplacingOccurrencesOfString:@" " withString:@""];
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

                NSString *aStr=[NSString stringWithFormat:@"申请号%@%@%@%@%@",@"%3D",@"'",@"%25",mess1,@"'"];
                [gArray addObject:aStr];
            }
            else{
			NSString *aStr = [NSString stringWithFormat:@"%@%@%@%@%@",[aRR objectAtIndex:i],@"%3D",@"'",mGSearchField.text,@"'"];
			[gArray addObject:aStr];

          }
		}
        //数组的数据用or转换成字符串
		NSString *dataString = [gArray componentsJoinedByString:@" or "];
        dataString = [NSString stringWithFormat:@"%@%@%@",@"[",dataString,@"]"];
//        NSString *dataString = [NSString stringWithFormat:@"%@%@%@%@",@"[",@"关键字=",mGSearchField.text,@"]"];
		ResultPage *result = [[ResultPage alloc]init];
		result.msg = dataString;
		NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
		if ([user objectForKey:@"strSources"]) {
			result.sourceData = [user objectForKey:@"strSources"];
		}else
        {
			result.sourceData = @"FMZL,SYXX,WGZL";
        }
		[self.navigationController pushViewController:result animated:YES];
		[result release];
		[self GkeepSearchHist:dataString AndKu:result.sourceData];
		[aRR release];
		[gArray release];

	}
    

}
//保存搜索历史存入数组每次格式：【{条件：  }{库： }{日期： }】
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
//保存搜索历史
-(NSString *)GsearchHistPath{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
    
	return [documentsDirectory stringByAppendingPathComponent:@"G_search_Hist_Name.plist"];
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
	NSDictionary *JsonDIc = [[NSDictionary alloc]initWithObjectsAndKeys:aFrom,@"startindex",aTo,@"endindex",name,@"userid", nil];
	NSString *tString2 = [NSString stringWithFormat:@"http://59.151.99.154:8080/dsqb/mcts"];
	NSString *tString3 = @"";
	[mSoapHttp PostSoadMessage:JsonDIc :tString2 :tString3];
	[JsonDIc release];
	[MBProgressHUD showHUDAddedTo:self.view animated:YES];
}
-(void)gAddAlertView
{
    UIAlertView *tAlert = [[UIAlertView alloc]initWithTitle:@"" message:NSLocalizedString(@"您还未登录！请先登录",nil) delegate:self cancelButtonTitle:NSLocalizedString(@"取消",nil) otherButtonTitles:NSLocalizedString(@"登录",nil), nil];
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
//中间按钮方法
-(void)GbuttonAction:(UIButton *)sender
{
	switch (sender.tag) {
		case 1000:
		{
			SearchPageViewController *Gpa = [[SearchPageViewController alloc]init];
			[self.navigationController pushViewController:Gpa animated:YES];
			[Gpa release];
		}
			break;
		case 1001:
		{
			SearchHistaryTableViewController *GsearchHist = [[SearchHistaryTableViewController alloc]init];
			[self.navigationController pushViewController:GsearchHist animated:YES];
			[GsearchHist release];
		}
			break;
		case 1002:
		{
                [self GPostSearchHistor:@"1"];
            			
		}
			break;
		case 1003:
		{
			GAgencySearchTableView *GtAgencyTable = [[GAgencySearchTableView alloc]init];
			[self.navigationController pushViewController:GtAgencyTable animated:YES];
			[GtAgencyTable release];
		}
			break;
		case 1004:
		{
			MapViewController *tGmapView = [[MapViewController alloc]init];
			[self.navigationController pushViewController:tGmapView animated:YES];
			[tGmapView release];
		}
			break;
//		case 1005:
//		{
//            if (kkSessionID.length>0) {
//               	DaiLiAtention *gDaiLiAtent = [[DaiLiAtention alloc]init];
//                [self.navigationController pushViewController:gDaiLiAtent animated:YES];
//                [gDaiLiAtent release];
//            }else{
//                [self gAddAlertView];
//            }
//		
//		}
//			break;
		case 1005:
		{
//            if (kkSessionID.length>0) {
//                GAlermNumTableVIew *gAlermNum = [[GAlermNumTableVIew alloc]init];
//                [self.navigationController pushViewController:gAlermNum animated:YES];
//                [gAlermNum release];
//            }else{
//                [self gAddAlertView];
//            }
            YYViewController *yyView=[[YYViewController alloc]initWithStyle:UITableViewStyleGrouped];
            [self.navigationController pushViewController:yyView animated:YES];
            self.navigationController.navigationBarHidden=NO;
            [yyView release];
		
		}
			break;
		case 1006:
		{
			PhoneWebView *gWebView = [[PhoneWebView alloc]init];
			[self.navigationController pushViewController:gWebView animated:YES];
			[gWebView release];
		}
			break;
		case 1007:
		{
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
            {
                UIImagePickerController *picker = [[UIImagePickerController alloc] init];
                picker.delegate = self;
                picker.allowsEditing=YES;
                picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                picker.mediaTypes=[NSArray arrayWithObjects:(NSString *)kUTTypeMovie,(NSString *)kUTTypeImage,nil];
                [self presentModalViewController:picker animated:YES];
                [picker release];
            }
            
			
        }
            break;
		case 1008:
        {
            
            UIImagePickerController *picker=[[UIImagePickerController alloc]init];
            
            picker.sourceType=UIImagePickerControllerSourceTypeCamera;
            NSArray *tmp_MediaTypes=[UIImagePickerController availableMediaTypesForSourceType:picker.sourceType];
            picker.mediaTypes=tmp_MediaTypes;
            picker.delegate=self;
            [picker setAllowsEditing:YES];
            
            
            
            [self presentViewController:picker animated:YES completion:nil];
            [picker release];
            
        }
            break;
	}
}
#pragma mark-UIImagepickerControllerDelegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *mediaType=[info objectForKey:UIImagePickerControllerMediaType];
    
    
    if ([mediaType isEqualToString:@"public.image"]) {
        UIImage *image=[info objectForKey:@"UIImagePickerControllerEditedImage"];
        NSLog(@"找到图片");
        [self.library saveImage:image toAlbum:@"专利执法 照片" withCompletionBlock:^(NSError *error)
         {
             if (error!=nil) {
                 NSLog(@"error:%@",[error description]);
             }
         }];
        
    }
    else if([mediaType isEqualToString:@"public.movie"])
    {
        NSURL *videoURL = [info objectForKey:UIImagePickerControllerMediaURL];
        NSLog(@"%@", videoURL);
        NSLog(@"found a video");
        [self.library saveVideo:videoURL toAlbum:@"专利执法 录像" withCompletionBlock:^(NSError *error)
         {
             if (error!=nil) {
                 NSLog(@"error:%@",[error description]);
             }
         }];
        
    }
    
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}


//底部按钮方法
-(void)GTabBarbuttonAction:(UIButton *)sender
{
	switch (sender.tag) {
		case 2000:{
			GLoginViewController *tGlogin = [[GLoginViewController alloc]init];
			[self.navigationController pushViewController:tGlogin animated:YES];
			[tGlogin release];
		}
			break;
		case 2001:
		{
            if (kkSessionID.length>0) {
                GAmendPassViewControl *tGamendPass = [[GAmendPassViewControl alloc]init];
                [self.navigationController pushViewController:tGamendPass animated:YES];
                [tGamendPass release];
            }else{
                [self gAddAlertView];
            }

		}
			break;
		case 2002:
		{
            if (kkSessionID.length>0) {
             	PrivateMessageControl *tGprivate = [[PrivateMessageControl alloc]init];
                [self.navigationController pushViewController:tGprivate animated:YES];
                [tGprivate release];
            }else{
                [self gAddAlertView];
            }
		
		}
			break;
		case 2003:
		{
			GSystemSetViewContrl *tGsystemSet = [[GSystemSetViewContrl alloc]init];
			[self.navigationController pushViewController:tGsystemSet animated:YES];
			[tGsystemSet release];
		}
			break;
//		case 2004:
//		{
//			GFanKuiVIewControl *gFanKui = [[GFanKuiVIewControl alloc]init];
//            [self.navigationController pushViewController:gFanKui animated:YES];
//            gFanKui.navigationController.navigationBarHidden=NO;
//            [gFanKui release];
//		}
//			break;
        case 2004:
        {
            AboutAppViewController *appView=[[AboutAppViewController alloc]initWithStyle:UITableViewStyleGrouped];
            appView.limitDays=self.tmpDay;
            [self.navigationController pushViewController:appView animated:YES];
            
            [appView release];
        }

	}
}
//无网络连接
-(void)GcanetFail
{
    if (self.mGLogimage) {
		[self.mGLogimage removeFromSuperview];
	}
	[MBProgressHUD hideHUDForView:self.view animated:YES];
	UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"提示",nil)
														message:NSLocalizedString(@"网络连接失败！",nil)
													   delegate:nil 
											  cancelButtonTitle:NSLocalizedString(@"确定",nil) otherButtonTitles:nil] ;
	[alertView show];
	[alertView release];
    

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
	[super dealloc];
}
@end
