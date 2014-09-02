//
//  SummaryViewController.m
//  ZHUANLIJIANSUO
//
//  Created by WO on 13-3-29.
//
//

#import "SummaryViewController.h"
#import "AppDelegate.h"
@interface SummaryViewController ()
{
    AppDelegate *app;
}
@end

@implementation SummaryViewController
-(void)add
{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(pngPath:) name:@"PNG" object:nil];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)pngPath:(NSNotification *)note
{
    path=[note object];
    NSLog(@"path+++%@",path);
}
- (void)viewDidLoad
{
    if ([[[UIDevice currentDevice]systemVersion]floatValue]>=7.0)
        self.edgesForExtendedLayout = UIRectEdgeNone;
    self.title=NSLocalizedString(@"摘要附图",nil);
    app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [MBProgressHUD hideHUDForView:app.window animated:YES];
    Vheight=[UIScreen mainScreen].bounds.size.height;
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:path]];
//    UIImage *image= [UIImage imageWithData:imageData];
//    UIImageView *imageview=[[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 310, 410)];
//    imageview.image=image;
//    [self.view addSubview:imageview];
    if (imageData==nil) {
        UIAlertView *alertNULL=[[UIAlertView alloc]initWithTitle:NSLocalizedString(@"没有查询结果", nil) message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertNULL show];
        [alertNULL release];
    }
    UIWebView *webImage=[[UIWebView alloc]initWithFrame:CGRectMake(5, 5, 310, Vheight-70)];
    [webImage loadData:imageData MIMEType:@"image/gif" textEncodingName:nil baseURL:nil];
    webImage.scalesPageToFit=YES;
    webImage.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:webImage];
    [webImage release];
    UIBarButtonItem *rightButnItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"Gfirst.png"] style:UIBarButtonItemStyleBordered target:self action:@selector(SelfPopToROOtViewControl)];
    self.navigationItem.rightBarButtonItem = rightButnItem;
	[rightButnItem release];
}
-(void)SelfPopToROOtViewControl
{
	[self.navigationController popToRootViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
