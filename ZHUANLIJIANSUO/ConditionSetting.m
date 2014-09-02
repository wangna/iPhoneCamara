//
//  ConditionSetting.m
//  PatentSearch
//
//  Created by wei on 12-8-13.
//  Copyright (c) 2012年 wei. All rights reserved.
//

#import "ConditionSetting.h"
#import "searchData.h"
@interface ConditionSetting ()

@end

@implementation ConditionSetting
@synthesize tv;
@synthesize list;
@synthesize searchPage;
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
    Vheight=[UIScreen mainScreen].bounds.size.height;
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:NSLocalizedString(@"返回",nil) style:UIBarButtonItemStyleBordered target:self action:@selector(Back:)];
    self.navigationItem.title = NSLocalizedString(@"设置－查询条件",nil);
    
    self.view.backgroundColor = [UIColor whiteColor];
    UITableView *tabview=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, Vheight-44) style:UITableViewStyleGrouped];
    if ([[[UIDevice currentDevice]systemVersion]floatValue]>=7.0)
        self.edgesForExtendedLayout = UIRectEdgeNone;
    self.tv = tabview;
    [tabview release];
    self.tv.dataSource = self;
    self.tv.delegate = self;
    self.tv.backgroundView=[[[UIView alloc]init]autorelease];
	self.tv.backgroundColor = Main_Color;
    [self.view addSubview:self.tv];
    [tv release];
    [super viewDidLoad];
	UIBarButtonItem *rightButnItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"Gfirst.png"] style:UIBarButtonItemStyleBordered target:self action:@selector(SelfPopToROOtViewControl)];
    self.navigationItem.rightBarButtonItem = rightButnItem;
	[rightButnItem release];
	
}
-(void)viewWillDisappear:(BOOL)animated{
    [self Back:nil];
}
-(void)SelfPopToROOtViewControl
{
	[self.navigationController popToRootViewControllerAnimated:YES];

}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 6;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
	{
		return 1;
	}
	else if(section == 1)
	{
		return 4;
	}
	else if(section == 2)
	{
        return 2;
	}
	else if(section == 3)
    {
		return 4;
	}
    else if(section == 4)
	{
		return 3;
	}
	else
	{       
		return 3;
	}
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *a = @"a";
    UITableViewCell *cell = [self.tv dequeueReusableCellWithIdentifier:a];
    
    if (cell == nil)
    {  
        cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:a] autorelease];
        button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(270, 10, 30, 30);
        button.tag=100;
        [button setImage:[UIImage imageNamed:@"01.png"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:@"选中" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor clearColor] forState:UIControlStateNormal] ;

        [cell addSubview:button];
    }
    
   NSMutableDictionary *dicValue=[NSMutableDictionary dictionaryWithDictionary:[searchData getAllSearchCondition]];
    self.list = [NSMutableArray arrayWithArray:[dicValue objectForKey:[NSString stringWithFormat:@"section%d",indexPath.section]]];
    NSInteger section=[indexPath section];
    NSMutableArray *arrayList = [dicValue objectForKey:[NSString stringWithFormat:@"list%d",section]];
    cell.textLabel.text = NSLocalizedString([self.list objectAtIndex:[[arrayList objectAtIndex:indexPath.row] intValue]],nil);
    cell.textLabel.textColor = Text_Color_Green;
    
    UIButton *btn=(UIButton *)[cell viewWithTag:100];
    if (![self setSelct:indexPath]) {
        [btn setTitle:@"选中" forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"01.png"] forState:UIControlStateNormal];
    }
     else
     {
        [btn setTitle:@"取消" forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"02.png"] forState:UIControlStateNormal];
     }
    [btn setTitleColor:[UIColor clearColor] forState:UIControlStateNormal] ;

    cell.textLabel.font = [UIFont fontWithName:nil size:12];
    return cell;
}
-(BOOL)setSelct:(NSIndexPath *)path
{
    NSMutableArray *array=[[searchData GetNowSearchCondition] objectForKey:[NSString stringWithFormat:@"list%d",path.section]];
    if ([array indexOfObject:[NSString stringWithFormat:@"%d",path.row]]==NSNotFound)
    {
        return YES;
    }
    return NO;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell= [self.tv cellForRowAtIndexPath:indexPath];
    for (UIButton *btn in cell.subviews) {
        if ([[btn class] isSubclassOfClass:[UIButton class]]) {
            [btn becomeFirstResponder];
            [self buttonTapped:btn];
        }
    }
    [self.tv deselectRowAtIndexPath:indexPath animated:YES];
}

-(IBAction)buttonTapped:(id)sender
{
    UIButton *senderButton = (UIButton *)sender;
    [senderButton setTitleColor:[UIColor clearColor] forState:UIControlStateNormal] ;

    UITableViewCell *cell;
    if ([[[UIDevice currentDevice]systemVersion]floatValue]>=7)
        cell=(UITableViewCell *)[[senderButton superview]superview];
    
    else
        cell=(UITableViewCell *)[senderButton superview];
    
    NSIndexPath *indexPath = [self.tv indexPathForCell:cell];
   //  NSLog(@"%@ index:%d section:%d",cell.textLabel.text,indexPath.row,indexPath.section );
    if ([senderButton.titleLabel.text  isEqualToString: @"选中"])
    {
        NSMutableDictionary *serch=[NSMutableDictionary dictionaryWithDictionary :[searchData GetNowSearchCondition]];
        NSMutableArray *arry= [NSMutableArray arrayWithArray:[serch objectForKey:[NSString stringWithFormat:@"list%d",indexPath.section]]];
        [arry removeObject:[NSString stringWithFormat:@"%d",indexPath.row]];
        [serch setObject:arry forKey:[NSString stringWithFormat:@"list%d",indexPath.section]];
        [searchData saveSearchCondition:serch];
        [senderButton setTitle:@"取消" forState:UIControlStateNormal];
        [senderButton setImage:[UIImage imageNamed:@"02.png"] forState:UIControlStateNormal];
    }
    else if ([senderButton.titleLabel.text isEqualToString: @"取消"])
    {   
        NSMutableDictionary *serch=[NSMutableDictionary dictionaryWithDictionary :[searchData GetNowSearchCondition]];
        NSMutableArray *arry= [NSMutableArray arrayWithArray:[serch objectForKey:[NSString stringWithFormat:@"list%d",indexPath.section]]];
        if ([arry indexOfObject:[NSString stringWithFormat:@"%d",indexPath.row]]==NSNotFound)
        {   
            [arry insertObject:[NSString stringWithFormat:@"%d",indexPath.row] atIndex:0];
            
            if ([arry count]>1) {
                NSArray *sortedArray = [arry sortedArrayUsingComparator: ^(id obj1, id obj2) {
                    
                    if ([obj1 integerValue] > [obj2 integerValue]) {
                        return (NSComparisonResult)NSOrderedDescending;//递减
                    }
                    
                    if ([obj1 integerValue] < [obj2 integerValue]) {
                        return (NSComparisonResult)NSOrderedAscending;//上升
                    }
                    return (NSComparisonResult)NSOrderedSame;
                }];
                
                [serch setObject:sortedArray forKey:[NSString stringWithFormat:@"list%d",indexPath.section]];
                [searchData saveSearchCondition:serch];

            }
            else
            {
                [serch setObject:arry forKey:[NSString stringWithFormat:@"list%d",indexPath.section]];
                [searchData saveSearchCondition:serch];
            } 
        }      
        [senderButton setTitle:@"选中" forState:UIControlStateNormal];
        [senderButton setImage:[UIImage imageNamed:@"01.png"] forState:UIControlStateNormal];
    }
}
- (void)viewDidUnload
{
    self.tv = nil;
    self.list = nil;
    self.searchPage = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}
-(IBAction)Back:(id)sender
{
    NSMutableDictionary *serch=[NSMutableDictionary dictionaryWithDictionary :[searchData GetNowSearchCondition]];
    for (NSString *str in [serch allKeys])
    {
      if ([str hasPrefix:@"list"])
        {
          NSString *s=[str substringFromIndex:str.length-1];
          NSMutableArray *arry=[serch objectForKey:str];
         for (int i=0; i<[arry count]; i++)
        {
            NSMutableArray *arrysection=[serch objectForKey:[NSString stringWithFormat:@"section%@",s]];
            NSLog(@"value:%@  section%@ row:%d",[arrysection objectAtIndex:i],s,i );
        }
        }
    }
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
