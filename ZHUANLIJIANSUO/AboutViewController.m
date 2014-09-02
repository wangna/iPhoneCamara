//
//  AboutViewController.m
//  ZHUANLIJIANSUO
//
//  Created by WO on 13-4-1.
//
//

#import "AboutViewController.h"

@interface AboutViewController ()

@end

@implementation AboutViewController
@synthesize limitDays;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if ([[[UIDevice currentDevice]systemVersion]floatValue]>=7.0)
        self.edgesForExtendedLayout = UIRectEdgeNone;
    Vheight=[UIScreen mainScreen].bounds.size.height;
	// Do any additional setup after loading the view.
    self.title=NSLocalizedString(@"关于我们",nil);
       NSString *aString=@"北京中献智慧知识产权咨询有限公司成立于2010年，是中国专利文献法定唯一出版单位、国家知识产权局对外专利信息服务统一出口单位——知识产权出版社的全资子公司，一直专注于知识产权服务领域，为国内外政府机构、企事业单位和科研机构提供全面专业的知识产权解决方案，广受好评。<br/>专利通（执法版）是根据知识产权局专利执法人员的需求定制而成的，能随时随地、快速查询专利信息，提高执法人员的办事效率。<br/>我们的联系方式<br/>客服专线：010-82000860转8502或010-82000860转8508<br/>Email:<br/>ipinfo@cnipr.com<br/>官网：<a href=\"http://www.zhihuiip.com\">http://www.zhihuiip.com</a> <br/> 您还可以关注我们的新浪微博和微信<br/>微博：直接搜索“中献智慧专利”或链接<a href=\"http://e.weibo.com/ipinfo\">http://e.weibo.com/ipinfo</a>  <br/>微信：直接搜索“中献智慧专利”或搜索微信号“zhihuiip”";

     NSString *htmlString=[@"<html><body bgcolor=\"#ecf6fb\"><p><font size=\"3px\"><font color=Black>" stringByAppendingFormat:@"%@%@",aString,@"</font></font></p></body></html>"];
    UIWebView *text=[[UIWebView alloc]initWithFrame:CGRectMake(5, 10, 310, Vheight-64-15)];
    text.delegate=self;
    [text loadHTMLString:htmlString baseURL:nil];
    
    
    text.backgroundColor=Main_Color;
    CALayer *layerClean=[text layer];
    [layerClean setBorderColor:[[UIColor blackColor]CGColor]];
    [layerClean setBorderWidth:1.0];
    
	[self.view addSubview:text];
    [text release];
}
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType;
{
    NSURL *requestURL =[ [ request URL ] retain ];
    if ( ( [ [ requestURL scheme ] isEqualToString: @"http" ] || [ [ requestURL scheme ] isEqualToString: @"https" ] || [ [ requestURL scheme ] isEqualToString: @"mailto" ])
        && ( navigationType == UIWebViewNavigationTypeLinkClicked ) ) {
        return ![ [ UIApplication sharedApplication ] openURL: [ requestURL autorelease ] ];
    }
    [ requestURL release ];
    return YES;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
