//
//  PhoneWebView.m
//  ZHUANLIJIANSUO
//
//  Created by chenhuiguo on 12-8-16.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "PhoneWebView.h"
@interface PhoneWebView()
{
	LoadView *mLoad;
}
@end
@implementation PhoneWebView

-(id)init
{
	if (self = [super init]) {
		self.title = NSLocalizedString(@"专利信息网",nil);
	}
	return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


- (void)loadView
{
	self.navigationController.navigationBarHidden = NO;
	UIWebView *tWebView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, 320, 412)];
	tWebView.delegate = self;
	NSURL *aUrl = [NSURL URLWithString:@"http://m.souips.com/"];
	NSURLRequest *aRequest = [[NSURLRequest alloc]initWithURL:aUrl];
	tWebView.scalesPageToFit = YES;
	[tWebView loadRequest:aRequest];
	[aRequest release];
	self.view = tWebView;
	[tWebView release];
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    if ([[[UIDevice currentDevice]systemVersion]floatValue]>=7.0)
        self.edgesForExtendedLayout = UIRectEdgeNone;
	UIBarButtonItem *rightButnItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"Gfirst.png"] style:UIBarButtonItemStyleBordered target:self action:@selector(SelfPopToROOtViewControl)];
    self.navigationItem.rightBarButtonItem = rightButnItem;
	[rightButnItem release];
	
}
-(void)SelfPopToROOtViewControl
{
	[self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)webViewDidStartLoad:(UIWebView *)webView
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
	[MBProgressHUD hideHUDForView:self.view animated:YES];
}
- (void)viewDidUnload
{
    [super viewDidUnload];
	UIWebView *aWeb = (UIWebView *)self.view;
	[aWeb stopLoading];
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
