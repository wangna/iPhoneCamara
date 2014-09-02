//
//  GNianjianVIewControl.m
//  ZHUANLIJIANSUO
//
//  Created by chenhuiguo on 12-9-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "GNianjianVIewControl.h"
#import "gNianJianCell.h"
#import "PingLunHeaderView.h"
@implementation GNianjianVIewControl
@synthesize GmArray,aString,aDIc;
-(id)init
{
	if (self = [super init]) {
		self.title = NSLocalizedString(@"年检",nil);
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
    Vheight=[UIScreen mainScreen].bounds.size.height;
	self.navigationController.navigationBarHidden = NO;
	UITableView *gTAlerm = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, Vheight-106) style:UITableViewStylePlain];
	gTAlerm.backgroundColor = Main_Color;
	gTAlerm.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
	self.tableView = gTAlerm;
	[gTAlerm release];
	
}

- (void)viewDidLoad
{
    if ([[[UIDevice currentDevice]systemVersion]floatValue]>=7.0)
        self.edgesForExtendedLayout = UIRectEdgeNone;
	self.navigationController.navigationBarHidden = NO;
    [super viewDidLoad];
	UIBarButtonItem *rightButnItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"Gfirst.png"] style:UIBarButtonItemStyleBordered target:self action:@selector(SelfPopToROOtViewControl)];
    self.navigationItem.rightBarButtonItem = rightButnItem;
	[rightButnItem release];
	
}
-(void)SelfPopToROOtViewControl
{
	[self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.GmArray.count+1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (indexPath.row<self.GmArray.count) {
		return 30;
	}
	return 118;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    if (indexPath.row<self.GmArray.count) {
		gNianJianCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
		if (cell == nil) {
			cell = [[[gNianJianCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
            [cell setBackgroundColor:Main_Color];
		}
		cell.gMdic = [self.GmArray objectAtIndex:indexPath.row];
		[cell gAddLabelAndText];
		
		return cell;
	}
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
		cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier]autorelease];
	}
	NSURL *aUrl = [NSURL URLWithString:self.aString];
	NSData *aData = [NSData dataWithContentsOfURL:aUrl];
	UIImage *aImage = [UIImage imageWithData:aData];
    UIImageView *aIMageView = [[[UIImageView alloc]initWithFrame:CGRectMake(0,0,320,118+(Vheight-480))]autorelease];
    aIMageView.image = aImage;
	[cell addSubview:aIMageView];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
	return 50;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	PingLunHeaderView *GaHeader = [[[PingLunHeaderView alloc]initWithFrame:CGRectMake(0, 0, 320, 40)]autorelease];
	GaHeader.GcontentDic = self.aDIc;
	[GaHeader CellAddTextLabel];
	return GaHeader;
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
