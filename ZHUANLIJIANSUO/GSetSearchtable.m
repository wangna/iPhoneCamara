//
//  GSetSearchtable.m
//  ZHUANLIJIANSUO
//
//  Created by chenhuiguo on 12-8-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "GSetSearchtable.h"
@interface GSetSearchtable()
{
	NSArray *mArray;
}
@end
@implementation GSetSearchtable
//用户选择的搜索条件
-(NSString *)GUserChooseSearch
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	return [documentsDirectory stringByAppendingPathComponent:@"G_User_Choose.plist"];
}
//全部搜索条件
-(NSString *)SearchSetPath{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	return [documentsDirectory stringByAppendingPathComponent:@"G_SearchSet.plist"];
}


-(id)init
{
	if (self = [super init]) {
		self.title = @"设置－查询条件";
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
	UITableView *gTAlerm = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 460) style:UITableViewStyleGrouped];
	gTAlerm.backgroundColor = Main_Color;
	self.tableView = gTAlerm;
	[gTAlerm release];
}
-(NSArray *)CreadArray
{
	NSDictionary *GDic00 = [[NSDictionary alloc]initWithObjectsAndKeys:@"名称",@"GSName",@"0",@"GState", nil];
	NSArray *tArray0 = [[NSArray alloc]initWithObjects:GDic00, nil];
	[GDic00 release];
	NSDictionary *GDic01 = [[NSDictionary alloc]initWithObjectsAndKeys:@"分类号",@"GSName",@"0",@"GState", nil];
	NSDictionary *GDic02 = [[NSDictionary alloc]initWithObjectsAndKeys:@"申请号",@"GSName",@"0",@"GState", nil];
	NSDictionary *GDic03 = [[NSDictionary alloc]initWithObjectsAndKeys:@"主分类号",@"GSName",@"0",@"GState", nil];
	NSDictionary *GDic04 = [[NSDictionary alloc]initWithObjectsAndKeys:@"公开号",@"GSName",@"0",@"GState", nil];
	NSArray *tArray1 = [[NSArray alloc]initWithObjects:GDic01,GDic02,GDic03,GDic04, nil];
	[GDic01 release];
	[GDic02 release];
	[GDic03 release];
	[GDic04 release];
	NSDictionary *GDic05 = [[NSDictionary alloc]initWithObjectsAndKeys:@"公开日",@"GSName",@"1",@"GState", nil];
	NSDictionary *GDic06 = [[NSDictionary alloc]initWithObjectsAndKeys:@"申请日",@"GSName",@"1",@"GState", nil];
	NSArray *tArray2 = [[NSArray alloc]initWithObjects:GDic05,GDic06, nil];
	[GDic05 release];
	[GDic06 release];
	NSDictionary *GDic07 = [[NSDictionary alloc]initWithObjectsAndKeys:@"申请人",@"GSName",@"1",@"GState", nil];
	NSDictionary *GDic08 = [[NSDictionary alloc]initWithObjectsAndKeys:@"代理机构",@"GSName",@"1",@"GState", nil];
	NSDictionary *GDicS09 = [[NSDictionary alloc]initWithObjectsAndKeys:@"代理人",@"GSName",@"1",@"GState", nil];
	NSArray *tArray3 = [[NSArray alloc]initWithObjects:GDic07,GDic08,GDicS09, nil];
	[GDic07 release];
	[GDic08 release];
	[GDicS09 release];
	NSDictionary *GDic10 = [[NSDictionary alloc]initWithObjectsAndKeys:@"国省代码",@"GSName",@"1",@"GState", nil];
	NSDictionary *GDic11 = [[NSDictionary alloc]initWithObjectsAndKeys:@"优先权",@"GSName",@"1",@"GState", nil];
	NSDictionary *GDic12 = [[NSDictionary alloc]initWithObjectsAndKeys:@"平均分",@"GSName",@"1",@"GState", nil];
	NSArray *tArray4 = [[NSArray alloc]initWithObjects:GDic10,GDic11,GDic12, nil];
	[GDic10 release];
	[GDic11 release];
	[GDic12 release];
	NSDictionary *GDic13 = [[NSDictionary alloc]initWithObjectsAndKeys:@"地址",@"GSName",@"1",@"GState", nil];
	NSDictionary *GDic14 = [[NSDictionary alloc]initWithObjectsAndKeys:@"摘要",@"GSName",@"1",@"GState", nil];
	NSDictionary *GDic15 = [[NSDictionary alloc]initWithObjectsAndKeys:@"主权项",@"GSName",@"1",@"GState", nil];
	NSArray *tArray5 = [[NSArray alloc]initWithObjects:GDic13,GDic14,GDic15, nil];
	[GDic13 release];
	[GDic14 release];
	[GDic15 release];
	NSArray *tZarray = [NSArray arrayWithObjects:tArray0,tArray1,tArray2,tArray3,tArray4,tArray5, nil];
	[tArray0 release];
	[tArray1 release];
	[tArray2 release];
	[tArray3 release];
	[tArray4 release];
	[tArray5 release];
	return tZarray;
}

- (void)viewDidLoad
{
	if ([[NSFileManager defaultManager]fileExistsAtPath:[self SearchSetPath]]) {
		[[self CreadArray]writeToFile:[self SearchSetPath] atomically:YES];
	}
    [super viewDidLoad];
	UIBarButtonItem *rightButnItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"Gfirst.png"] style:UIBarButtonItemStyleBordered target:self action:@selector(SelfPopToROOtViewControl)];
    self.navigationItem.rightBarButtonItem = rightButnItem;
	[rightButnItem release];
	
}
-(void)SelfPopToROOtViewControl
{
	[self.navigationController popToRootViewControllerAnimated:YES];
}
-(void)viewDidAppear:(BOOL)animated
{
	mArray = [[NSArray alloc]initWithContentsOfFile:[self SearchSetPath]];
	NSLog(@"%@",mArray);
	[super viewDidAppear:animated];
	[self.tableView reloadData];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return mArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [[mArray objectAtIndex:section] count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSInteger row = [indexPath row];
	static NSString *cellTableIdentifier = @"italicsCellTableIdentifier";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellTableIdentifier];
	if (cell == nil) {
		cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellTableIdentifier]autorelease];
	}
	NSDictionary *gTDIc = [[mArray objectAtIndex:indexPath.section]objectAtIndex:row];
	cell.textLabel.text = [gTDIc objectForKey:@"GSName"];
	cell.textLabel.font = [UIFont systemFontOfSize:17.0];
	cell.textLabel.textColor = Text_Color_Green;
	cell.textLabel.backgroundColor = [UIColor clearColor];
	if ([[gTDIc objectForKey:@"GState"]intValue]==1) {
		cell.accessoryType = UITableViewCellAccessoryCheckmark;
	}

	NSLog(@"indexpath.section=%d",indexPath.section);
	NSLog(@"indexpath.row=%d",indexPath.row);
	return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}
- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
