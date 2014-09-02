//
//  GSystemSetViewContrl.m
//  ZHUANLIJIANSUO
//
//  Created by chenhuiguo on 12-8-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "GSystemSetViewContrl.h"
#import "GtabbarHeader.h"
#import "LibrarySetting.h"
#import "ConditionSetting.h"
@implementation GSystemSetViewContrl

-(id)init
{
	if (self = [super init]) {
		self.title = NSLocalizedString(@"系统设置",nil);
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
	UIView *gTAlerm = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 460)];
	gTAlerm.backgroundColor = Main_Color;
	self.view = gTAlerm;
	[gTAlerm release];
}
-(void)GaddButton
{
		
	UITableView *tGview = [[UITableView alloc]initWithFrame:CGRectMake(20, 20, 280, 130)style:UITableViewStylePlain];
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
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 3;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSInteger row = [indexPath row];
	NSArray *tNameArray = [[NSArray alloc]initWithObjects:@"用户名",@"查询条件",@"专利库", nil];
	NSArray *tContentArray = [[NSArray alloc]initWithObjects:kkUserName,kkmobilePhone,kkemail, nil];
	static NSString *cellTableIdentifier =@"italicsCellTableIdentifier";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellTableIdentifier];
	if (cell == nil) {
		cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellTableIdentifier]autorelease];
		
		cell.textLabel.text = NSLocalizedString([tNameArray objectAtIndex:row],nil);
		cell.textLabel.font = [UIFont systemFontOfSize:17.0];
		cell.textLabel.textColor = Text_Color_Green;
		cell.textLabel.backgroundColor = [UIColor clearColor];
//		cell.detailTextLabel.backgroundColor = [UIColor clearColor];
//		cell.detailTextLabel.textColor = [UIColor colorWithRed:0.0/255.0 green:10.0/255.0 blue:20.0/255.0 alpha:1.0];
//		cell.detailTextLabel.font = [UIFont systemFontOfSize:17.0];
//		cell.detailTextLabel.text = [tContentArray objectAtIndex:row];
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
		
	}
	[tNameArray release];
	[tContentArray release];
	return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSInteger row = [indexPath row];
	switch (row) {
		case 0:
		{
			
            if (kkSessionID.length>0) {
                PrivateMessageControl *gtAprivate = [[PrivateMessageControl alloc]init];
                [self.navigationController pushViewController:gtAprivate animated:YES];
                [gtAprivate release];
                
            }
            else
            {
                UIAlertView *Deng=[[UIAlertView alloc]initWithTitle:NSLocalizedString(@"您还未登录！请先登录",nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"取消",nil) otherButtonTitles:NSLocalizedString(@"登录",nil), nil];
                [Deng show];
                [Deng release];
            }

		}
			break;
		case 2:
		{
			LibrarySetting *library = [[LibrarySetting alloc]init];
			[self.navigationController pushViewController:library animated:YES];
			[library release];
		}
			break;
		case 1:
		{
			ConditionSetting *condition = [[ConditionSetting alloc]init];
			[self.navigationController pushViewController:condition animated:YES];
			[condition release];

		}
			break;

	}
}

- (void)viewDidLoad
{
    if ([[[UIDevice currentDevice]systemVersion]floatValue]>=7.0)
        self.edgesForExtendedLayout = UIRectEdgeNone;
	self.navigationController.navigationBarHidden = NO;
    [super viewDidLoad];
	[self GaddButton];
	UIBarButtonItem *rightButnItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"Gfirst.png"] style:UIBarButtonItemStyleBordered target:self action:@selector(SelfPopToROOtViewControl)];
    self.navigationItem.rightBarButtonItem = rightButnItem;
	[rightButnItem release];
	
}
-(void)SelfPopToROOtViewControl
{
	[self.navigationController popToRootViewControllerAnimated:YES];
}


- (void)viewDidUnload
{
    [super viewDidUnload];

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
-(void)dealloc
{
	[super dealloc];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex)
    {
        GLoginViewController *tGlogin = [[GLoginViewController alloc]init];
        [self.navigationController pushViewController:tGlogin animated:YES];
        [tGlogin release];
    }
}


@end
