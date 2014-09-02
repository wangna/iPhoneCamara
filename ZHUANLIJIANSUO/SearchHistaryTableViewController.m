//
//  SearchHistaryTableViewController.m
//  ZHUANLIJIANSUO
//
//  Created by chenhuiguo on 12-9-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SearchHistaryTableViewController.h"
#import "GSearchHistCell.h"
#import "ResultPage.h"
@interface SearchHistaryTableViewController()
{
	BOOL done;
    UIBarButtonItem *rightButnItem;
}
@property(nonatomic,retain)NSMutableArray *gMutaArray;
@end
@implementation SearchHistaryTableViewController
@synthesize gMutaArray;
-(NSString *)GsearchHistPath{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	return [documentsDirectory stringByAppendingPathComponent:@"G_search_Hist_Name.plist"];
}
-(id)init
{
	if (self = [super init]) {
		self.title = NSLocalizedString(@"查询历史",nil);
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
	self.navigationController.navigationBarHidden = NO;
	UITableView *gTAlerm = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 416) style:UITableViewStylePlain];
	gTAlerm.backgroundColor = Main_Color;
	gTAlerm.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
	gTAlerm.backgroundColor = Main_Color;
	gTAlerm.delegate = self;
	gTAlerm.dataSource = self;
	self.tableView = gTAlerm;

}
-(void)viewDidLoad
{
    if ([[[UIDevice currentDevice]systemVersion]floatValue]>=7.0)
        self.edgesForExtendedLayout = UIRectEdgeNone;
	NSMutableArray *aGArray = [[NSMutableArray alloc]initWithCapacity:10];
	self.gMutaArray = aGArray;
	[aGArray release];
	if ([[NSFileManager defaultManager]fileExistsAtPath:[self GsearchHistPath]]) {
		NSArray * arry = [[NSArray alloc]initWithContentsOfFile:[self GsearchHistPath]];
		[self.gMutaArray addObjectsFromArray:arry];
		[arry release];
	}
    rightButnItem = [[UIBarButtonItem alloc]initWithTitle:@"编辑" style:UIBarButtonItemStyleBordered target:self action:@selector(tableViewEdit:)];
    self.navigationItem.rightBarButtonItem = rightButnItem;
	[rightButnItem release];
	NSLog(@"1111%@",self.gMutaArray);
	[self.tableView reloadData];
}
-(NSString *)stringChangeArrayAndChangeBack:(NSString *)string
{
    NSString *aGStrin = [string stringByReplacingOccurrencesOfString:@"%25" withString:@""];
	NSString *aZaiBian = [aGStrin stringByReplacingOccurrencesOfString:@"%3D" withString:@"="];
    NSArray *tArray = [aZaiBian componentsSeparatedByString:@" or "];
    if (tArray.count>1) {
        NSString *tStr = [tArray objectAtIndex:0];
        NSArray *tArray1 = [tStr componentsSeparatedByString:@"="];
        aZaiBian = [NSString stringWithFormat:@"%@%@%@%@",@"[",NSLocalizedString(@"关键字=",nil),[tArray1 objectAtIndex:1],@"]"];
        return aZaiBian;
    }else
        return aZaiBian;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return  self.gMutaArray.count?1:0;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	return self.gMutaArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

	NSDictionary *aDic = [self.gMutaArray objectAtIndex:indexPath.row];
	NSString *gTiaoJian = [aDic objectForKey:@"gTiaoJian"];
	NSString *aZaiBian = [self stringChangeArrayAndChangeBack:gTiaoJian];
	CGSize size = [aZaiBian sizeWithFont:[UIFont systemFontOfSize:15.0] constrainedToSize:CGSizeMake(320, 1000) lineBreakMode:NSLineBreakByCharWrapping];
	if (size.height<20) {
		size.height = 20;
	}
	NSMutableArray *arry3=[NSMutableArray arrayWithObjects:@"中国发明专利",@"中国发明授权",@"中国使用新型",@"中国外观设计",@"香港特区",@"中国台湾专利",@"中国外观设计（失效）",@"中国发明专利（失效）",@"中国实用新型（失效）",@"EPO",@"WIPO",@"英国",@"德国",@"法国",@"瑞士",@"韩国",@"俄罗斯",@"日本",@"东南亚",@"阿拉伯",@"美国",@"其它国家和地区", nil] ;
	NSMutableArray *value3 = [NSMutableArray arrayWithObjects:@"FMZL",@"FMSQ",@"SYXX",@"WGZL",@"HKPATENT",@"TWZL",@"WGSX",@"FMSX",@"XXSX",@"EPPATENT",@"WOPATENT",@"GBPATENT",@"DEPATENT",@"FRPATENT",@"CHPATENT",@"KRPATENT",@"RUPATENT",@"JPPATENT",@"ASPATENT",@"GCPATENT",@"USPATENT",@"APPATENT,ATPATENT,AUPATENT,CAPATENT,ESPATENT,ITPATENT,SEPATENT,OTHERPATENT",nil];
	NSArray *stringArr = [[aDic objectForKey:@"gkuString"] componentsSeparatedByString:@","];
	NSMutableArray *tFiMutable = [[NSMutableArray alloc]initWithCapacity:10];
	NSLog(@"%d",stringArr.count);
	//对比换中文，
	for (int i = 0; i<stringArr.count; i++) {
		NSString *tLinshi = [stringArr objectAtIndex:i];
		for (int i1 = 0; i1<value3.count; i1++) {
			if ([tLinshi isEqualToString:[value3 objectAtIndex:i1]]) {
				[tFiMutable addObject:NSLocalizedString([arry3 objectAtIndex:i1],nil)];
				break;
			}
		}
	}
	//如果少了加其他国家喝地区
    if (stringArr.count>tFiMutable.count) {
        [tFiMutable addObject:NSLocalizedString(@"其它国家和地区",nil)];
    }
//     NSLog(@"tFiMutable=++%@",tFiMutable);
//	for (int j = 0; j<stringArr.count-tFiMutable.count; j++) {
//		[tFiMutable addObject:NSLocalizedString(@"其它国家和地区",nil)];
//	}
//	
	NSString *gKuString = [tFiMutable componentsJoinedByString:@","];
	CGSize size1 = [gKuString sizeWithFont:[UIFont systemFontOfSize:15.0] constrainedToSize:CGSizeMake(320, 1000) lineBreakMode:NSLineBreakByCharWrapping];
	if (size1.height<20) {
		size1.height = 20;
	}
    [tFiMutable release];
	return size.height+size1.height+26;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSString *indefineString = [NSString stringWithFormat:@"aIndefine%d",indexPath.row];
	GSearchHistCell *cell = [tableView dequeueReusableCellWithIdentifier:indefineString];
	if (cell == nil) {
		cell = [[[GSearchHistCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indefineString]autorelease];
        cell.gDic = [self.gMutaArray objectAtIndex:indexPath.row];
        [cell gAddSearchHistData];
	}
	
	return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSDictionary *aDic = [self.gMutaArray objectAtIndex:indexPath.row];
	NSString *gTiaoJian = [aDic objectForKey:@"gTiaoJian"];
	NSString *gKuString = [aDic objectForKey:@"gkuString"];
	ResultPage *result = [[ResultPage alloc]init];
	result.msg = gTiaoJian;
	result.sourceData = gKuString;
	[self.navigationController pushViewController:result animated:YES];
	[result release];

}
- (void)tableViewEdit:(id)sender{
    done=!done;
    if (done) {
        [rightButnItem setTitle:@"完成编辑"];
    }
    else
    {
        [rightButnItem setTitle:@"编辑"];
    }
    [self.view setEditing:!self.tableView.editing animated:YES];
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return YES;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row=[indexPath row];
    //对数据库删除
    if ([[NSFileManager defaultManager]fileExistsAtPath:[self GsearchHistPath]]) {
        NSMutableArray *saveArr=nil;
		NSArray *tmpArr= [NSArray arrayWithContentsOfFile:[self GsearchHistPath]];
        saveArr=[NSMutableArray arrayWithArray:tmpArr];
		[saveArr removeObjectAtIndex:row];
        [saveArr writeToFile:[self GsearchHistPath] atomically:YES];
        
	}
    [self.gMutaArray removeObjectAtIndex:indexPath.row];
	
    if (gMutaArray.count) {
        NSArray *indexPaths = [NSArray arrayWithObject:indexPath];
        [self.tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
        
    }
    else
        [tableView deleteSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationLeft];
    
    
    
    
}- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
