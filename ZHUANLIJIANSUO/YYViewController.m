//
//  YYViewController.m
//  ZHUANLIJIANSUO
//
//  Created by WO on 13-4-1.
//
//

#import "YYViewController.h"

@interface YYViewController ()

@end

@implementation YYViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    self.tableView.backgroundView=[[[UIView alloc]init]autorelease];
    self.tableView.backgroundColor=Main_Color;
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if ([[[UIDevice currentDevice]systemVersion]floatValue]>=7.0)
        self.edgesForExtendedLayout = UIRectEdgeNone;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.title=NSLocalizedString(@"应用中心",nil);
    arrPng=[[NSArray alloc]initWithObjects:@"10",@"10",@"2011",@"2011",@"2011",@"lite", nil];
    arrText=[[NSArray alloc]initWithObjects:@"专利代理人资格考试（2000年~2010年）十年真题 iPad版",@"专利代理人资格考试（2000年~2010年）十年真题 iPhone版",@"专利代理人资格考试真题及解析（2011年）iPad版",@"专利代理人资格考试真题及解析（2011年）iPhone版",@"专利代理人资格考试真题及解析（2012年）",@"专利代理人资格考试真题及解析（两年真题免费版）", nil];
    
//    UITableView *tabview=[[UITableView alloc]initWithFrame:CGRectMake(5, 5, 310, 450) style:UITableViewStyleGrouped];
//    tabview.delegate=self;
//    tabview.dataSource=self;
//    [self.view addSubview:tabview];
    
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
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    tableView.separatorColor=[UIColor blueColor];
    NSInteger row=[indexPath row];
    NSLog(@"index====%d",row);
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier]autorelease];
    }
    NSString *strname=[NSString stringWithFormat:@"%@",[arrPng objectAtIndex:row]];
    NSLog(@"name==%@",strname);
    cell.imageView.image=[UIImage imageNamed:strname];
    cell.textLabel.text=NSLocalizedString([arrText objectAtIndex:row ],nil);
    cell.textLabel.numberOfLines=0;
    cell.textLabel.font=[UIFont fontWithName:@"Heiti SC" size:20];
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}
//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 110;
//}
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
    switch (row) {
        case 0:
            [self ADmoreIPad];
            break;
        case 1:
            [self ADmoreIPhone];
            break;
        case 2:
            [self ADIpad2011];
            break;
        case 3:
            [self ADIphone2011];
            break;
        case 4:
            [self AD2012];
            break;
        case 5:
            [self ADCom];
            break;
        default:
            break;
    }

}
-(void)ADmoreIPhone
{
    NSString *url = [NSString  stringWithFormat:@"https://itunes.apple.com/us/app/zhuan-li-dai-li-ren-kao-shi/id594137840?ls=1&mt=8"];
    NSURL *nsurl = [NSURL URLWithString:url];
    [[UIApplication sharedApplication] openURL:nsurl];
}
-(void)ADmoreIPad
{
    NSString *url = [NSString  stringWithFormat:@"https://itunes.apple.com/us/app/zhuan-li-dai-li-ren-kao-shiipad/id592667655?ls=1&mt=8"];
    NSURL *nsurl = [NSURL URLWithString:url];
    [[UIApplication sharedApplication] openURL:nsurl];
}
-(void)ADIpad2011
{
    NSString *url = [NSString  stringWithFormat:@"https://itunes.apple.com/us/app/zhuan-li-dai-li-ren-zi-ge/id624380226?mt=8"];
    NSURL *nsurl = [NSURL URLWithString:url];
    [[UIApplication sharedApplication] openURL:nsurl];

}
-(void)ADIphone2011
{
    NSString *url = [NSString  stringWithFormat:@"https://itunes.apple.com/us/app/zhuan-li-dai-li-ren-zi-ge/id624453758?mt=8"];
    NSURL *nsurl = [NSURL URLWithString:url];
    [[UIApplication sharedApplication] openURL:nsurl];

}

-(void)AD2012
{
    NSString *url = [NSString  stringWithFormat:@"https://itunes.apple.com/us/app/zhuan-li-dai-li-ren-zi-ge/id756189915?ls=1&mt=8"];
    NSURL *nsurl = [NSURL URLWithString:url];
    [[UIApplication sharedApplication] openURL:nsurl];
}
-(void)ADCom
{
    NSString *url = [NSString  stringWithFormat:@"https://itunes.apple.com/us/app/zhuan-li-dai-li-kao-shi-mian/id605127123?ls=1&mt=8"];
    NSURL *nsurl = [NSURL URLWithString:url];
    [[UIApplication sharedApplication] openURL:nsurl];
}

@end
