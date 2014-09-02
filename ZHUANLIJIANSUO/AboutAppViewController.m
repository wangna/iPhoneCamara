//
//  AboutAppViewController.m
//  ZhuanLiTong_ZF
//
//  Created by WO on 13-5-27.
//
//

#import "OpenUDID.h"
#import <Social/Social.h>
#import "AboutAppViewController.h"
#import "system.h"
#import "GFanKuiVIewControl.h"
#import "AboutViewController.h"
#import "MBProgressHUD.h"
@interface AboutAppViewController ()

@end

@implementation AboutAppViewController
@synthesize limitDays;
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    if ([[[UIDevice currentDevice]systemVersion]floatValue]>=7.0)
        self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationController.navigationBarHidden=NO;
    [super viewDidLoad];
    self.title=NSLocalizedString(@"关于本软件", nil);
    self.view.backgroundColor=Main_Color;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    UIBarButtonItem *rightButnItem = [[UIBarButtonItem alloc]initWithTitle:@"分享" style:UIBarButtonItemStyleBordered target:self action:@selector(share)] ;
    self.navigationItem.rightBarButtonItem = rightButnItem;
	[rightButnItem release];
    self.tableView.backgroundView=[[[UIView alloc]init]autorelease];
    self.tableView.backgroundColor=Main_Color;
    frame=[UIScreen mainScreen].bounds;
    
}
-(void)viewDidAppear:(BOOL)animated
{
    [self share];
}
-(void)share
{
    if( [[[UIDevice currentDevice] systemVersion] floatValue]>=6.0) {
        if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeSinaWeibo]) {
            SLComposeViewController *weiboView=[SLComposeViewController composeViewControllerForServiceType:SLServiceTypeSinaWeibo];
            [weiboView setInitialText:@"我正在使用专利行政执法（专业版）软件查询专利,专利检索方便快捷，向大家推荐，可去Appstore下载https://itunes.apple.com/us/app/zhuan-li-xing-zheng-zhi-fa/id654855126?ls=1&mt=8"];
            [self presentViewController:weiboView animated:YES completion:nil];
        }
        else
        {
            UIAlertView *alertView = [[UIAlertView alloc]
                                      initWithTitle:@"抱歉"
                                      message:@"不能新浪微博分享，请在本机设置中登录微博"
                                      delegate:self
                                      cancelButtonTitle:@"OK"
                                      otherButtonTitles:nil];
            [alertView show];
            [alertView release];
        }
    }
    else
    {
            WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:[self messageToShare]];
            request.userInfo = @{@"ShareMessageFrom": @"SendMessageToWeiboViewController",
                                 @"Other_Info_1": [NSNumber numberWithInt:123],
                                 @"Other_Info_2": @[@"obj1", @"obj2"],
                                 @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
            //    request.shouldOpenWeiboAppInstallPageIfNotInstalled = NO;
            
            [WeiboSDK sendRequest:request];
        }
}
- (WBMessageObject *)messageToShare
{
    WBMessageObject *message = [WBMessageObject message];
    
    
    message.text = @"我正在使用专利行政执法（专业版）软件查询专利,专利检索方便快捷，向大家推荐，可去Appstore下载https://itunes.apple.com/us/app/zhuan-li-xing-zheng-zhi-fa/id654855126?ls=1&mt=8";
    
    
    
    
    return message;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 4;
}
-(float)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return frame.size.height/2;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headView=[[[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height/2)]autorelease];
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(10, 30, 240, 92)];
    imageView.image=[UIImage imageNamed:@"tu"];
    //    UILabel *labalTitle=[[UILabel alloc]initWithFrame:CGRectMake(40, 30,headView.frame.size.width/3, headView.frame.size.height/2-30)];
    //    labalTitle.text=NSLocalizedString(@"中国专利检索iPad", nil);
    //    labalTitle.font=[UIFont systemFontOfSize:24];
    //    labalTitle.backgroundColor=Main_Color;
    UILabel *label1=[[UILabel alloc]initWithFrame:CGRectMake(10, headView.frame.size.height/2, 300, 30)];
    label1.text=NSLocalizedString(@"版本：V1.0.9", nil);
    
    
    NSLog(@"string___%@",limitDays);
    if (limitDays!=NULL) {
        limitDays=[NSString stringWithFormat:@"%d",[limitDays integerValue]+1];
    }
    else
        limitDays=@"0";
//    NSString *strDay=[NSString stringWithFormat:NSLocalizedString(@"有效期：还有%@天",nil),self.limitDays];
//    UILabel *label2=[[UILabel alloc]initWithFrame:CGRectMake(10, label1.frame.origin.y+30, 300, 30)];
//    label2.text=strDay;
    UILabel *label3=[[UILabel alloc]initWithFrame:CGRectMake(10, label1.frame.origin.y+30, 300, 60)];
    NSMutableString *useID=[[NSMutableString alloc]init];
    [useID setString:[[OpenUDID value]stringByAppendingString:@"z"]];
    for (int i=0; i<10; i++) {
        NSInteger num=4+i*5;
        [useID insertString:@" " atIndex:num];
    }
    
    
    NSString *ID=[NSString stringWithFormat:@"序列号：%@(%@)",useID,limitDays] ;
    [useID release];
    label3.numberOfLines=0;
    label3.text=ID;
   
    NSLog(@"ID++%@", [[OpenUDID value]stringByAppendingString:@"z"]);
    label3.backgroundColor=Main_Color;
    label1.backgroundColor=Main_Color;
//    label2.backgroundColor=Main_Color;
    [headView addSubview:imageView];
//    [headView addSubview:label2];
    [headView addSubview:label1];
    [headView addSubview:label3];
    [imageView release];
    [label1 release];
//    [label2 release];
    [label3 release];
    return headView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier]autorelease];
    }
    NSInteger row=[indexPath row];
    NSArray *arrlist=[NSArray arrayWithObjects:@"信息反馈",@"联系我们",@"给我评分",@"检查更新", nil];
    // Configure the cell...
    cell.textLabel.text=NSLocalizedString([arrlist objectAtIndex:row], nil);
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
    NSInteger row=[indexPath row];
    switch (row)
    {
        case 0:
        {
            GFanKuiVIewControl *fanView=[[GFanKuiVIewControl alloc]init];
            [self.navigationController pushViewController:fanView animated:YES];
            fanView.navigationController.navigationBarHidden=NO;
            [fanView release];
        }
            break;
        case 1:
        {
            AboutViewController *aboutView=[[AboutViewController alloc]init];
            [self.navigationController pushViewController:aboutView animated:YES];
            aboutView.navigationController.navigationBarHidden=NO;
            [aboutView release];
        }
            break;
            case 2:
        {
            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            [self openAppStore];
        }
            break;
            
        case 3:
        {
            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            [NSThread detachNewThreadSelector:@selector(GetUpdate) toTarget:self withObject:nil];
        }
            break;
    }
    
    
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
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"已是最新版本！" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        alert.delegate=self;
        [alert show];
        
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
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"已是最新版本！" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        alert.delegate=self;
        [alert show];
        
        return;
    }
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex) {
        NSURL *url=[NSURL URLWithString:@"https://itunes.apple.com/us/app/zhuan-li-xing-zheng-zhi-fa/id654855126?l=zh&ls=1&mt=8"];
        [[UIApplication sharedApplication]openURL:url];
    }
}
- (void)openAppStore {
    // Initialize Product View Controller
    SKStoreProductViewController *storeProductViewController = [[SKStoreProductViewController alloc] init];
    
    // Configure View Controller
    [storeProductViewController setDelegate:self];
    [storeProductViewController loadProductWithParameters:@{SKStoreProductParameterITunesItemIdentifier : @"654855126"} completionBlock:^(BOOL result, NSError *error) {
        if (error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            NSString *info=[[error userInfo]objectForKey:@"NSLocalizedDescription"];
            MBProgressHUD *mbpView=[[MBProgressHUD alloc]initWithView:self.view];
            [self.view addSubview:mbpView];
            [mbpView setMode:MBProgressHUDModeText];
            mbpView.labelText=info;
            [mbpView show:YES];
            [mbpView hide:YES afterDelay:2];
            [mbpView release];
            NSLog(@"Error %@ with User Info %@.", error, [error userInfo]);
            
        } else {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            // Present Store Product View Controller
            [self presentViewController:storeProductViewController animated:YES completion:nil];
        }
    }];
}

#pragma mark -
#pragma mark Store Product View Controller Delegate Methods
- (void)productViewControllerDidFinish:(SKStoreProductViewController *)viewController {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
