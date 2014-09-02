//
//  LawViewController.m
//  ZHUANLIJIANSUO
//
//  Created by WO on 13-3-27.
//
//

#import "LawViewController.h"
#import "LawCell.h"
#import "AppDelegate.h"
@interface LawViewController ()
{
    AppDelegate *app;
}
@end

@implementation LawViewController
@synthesize arrLaw;
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)add
{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getarrlaw:) name:@"LAW" object:nil];
}
-(void)getarrlaw:(NSNotification *)note
{
    self.arrLaw=[note object];
    NSLog(@"appNum+++%d",[self.arrLaw count]);
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    if ([[[UIDevice currentDevice]systemVersion]floatValue]>=7.0)
        self.edgesForExtendedLayout = UIRectEdgeNone;
    app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [MBProgressHUD hideHUDForView:app.window animated:YES];
    self.title=NSLocalizedString(@"法律状态",nil);
    Vheight=[UIScreen mainScreen].bounds.size.height;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
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
    NSLog(@"count++%d",[self.arrLaw count]);
    return [self.arrLaw count];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.arrLaw count]==1) {
        return Vheight-64;
    }
    if ([self.arrLaw count]==2) {
        NSInteger row1=[indexPath row];
        
        NSString *message1=[NSString stringWithFormat:@"%@",[[self.arrLaw objectAtIndex:row1]objectForKey:@"strStatusInfo" ]];
        CGSize detailSize = [message1 sizeWithFont:[UIFont boldSystemFontOfSize:16] constrainedToSize:CGSizeMake(210, 4000) lineBreakMode:NSLineBreakByCharWrapping];
        NSLog(@"height++%f",self.view.frame.size.height/2);
        if (detailSize.height<370) {
            return self.view.frame.size.height/2;
        }
        else
            return detailSize.height+110;

    }
    if ([self.arrLaw count]>2) {
        NSInteger row1=[indexPath row];
        NSString *message1=[NSString stringWithFormat:@"%@",[[self.arrLaw objectAtIndex:row1]objectForKey:@"strStatusInfo" ]];
        CGSize detailSize = [message1 sizeWithFont:[UIFont boldSystemFontOfSize:16] constrainedToSize:CGSizeMake(210, 4000) lineBreakMode:NSLineBreakByCharWrapping];
        if (detailSize.height<10||message1.length==0) {
            detailSize.height=30;
        }
            return detailSize.height+95;
    }
    
    else
        return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  NSString *CellIdentifier =[NSString stringWithFormat:@"CEll%d",indexPath.row] ;
    NSInteger row=[indexPath row];
    LawCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    NSString *applyNum=[NSString stringWithFormat:@"%@",[[self.arrLaw objectAtIndex:row]objectForKey:@"strAn"]];
    NSString *date=[NSString stringWithFormat:@"%@",[[self.arrLaw objectAtIndex:row]objectForKey:@"strLegalStatusDay"]];
    NSLog(@">>>>>>>>date%@",date);
    NSString *style=[NSString stringWithFormat:@"%@",[[self.arrLaw objectAtIndex:row]objectForKey:@"strLegalStatus"]];
    NSString *message=[NSString stringWithFormat:@"%@",[[self.arrLaw objectAtIndex:row]objectForKey:@"strStatusInfo" ]];
    if (cell==nil) {
        cell=[[[LawCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier]autorelease];
        cell.selectionStyle=UITableViewCellAccessoryNone;
        cell.apNum=applyNum;
        cell.date=date;
        cell.style=style;
        cell.message=message;
        [cell addLawDetail];
    }
    // Configure the cell...
    
    
   
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
}

@end
