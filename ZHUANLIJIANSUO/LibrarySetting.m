//
//  LibrarySetting.m
//  PatentSearch
//
//  Created by wei on 12-8-13.
//  Copyright (c) 2012年 wei. All rights reserved.
//

#import "LibrarySetting.h"
#import "LibraryData.h"
#import "AppDelegate.h"
NSInteger offset = 0;
BOOL ifisNil = NO;
@implementation LibrarySetting
@synthesize tv1;
@synthesize array;
@synthesize tempString;
@synthesize libString;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(BOOL)setSelct:(NSIndexPath *)path
{
    NSMutableArray *arr=[[LibraryData GetNowLibraryDataCondition] objectForKey:[NSString stringWithFormat:@"list%d",path.section]];
    if ([arr indexOfObject:[NSString stringWithFormat:@"%d",path.row]]==NSNotFound)
    {
        return YES;
    }
    return NO;
}

- (void)viewDidLoad
{
    ifisNil=NO;
    if ([[[UIDevice currentDevice]systemVersion]floatValue]>=7.0)
        self.edgesForExtendedLayout = UIRectEdgeNone;
	if ([[ NSUserDefaults standardUserDefaults] objectForKey:@"libraryCondition11"]==nil)
	{
		ifisNil = YES;
		NSMutableDictionary *serch=[NSMutableDictionary dictionaryWithDictionary :[LibraryData GetNowLibraryDataCondition]];
		NSMutableArray *arry= [NSMutableArray arrayWithArray:[serch objectForKey:[NSString stringWithFormat:@"list%d",0]]];
		[arry removeObjectAtIndex:5];
		[arry removeObjectAtIndex:4];
        [arry removeObjectAtIndex:3];
        NSLog(@"array++%@",arry);
		[serch setObject:arry forKey:[NSString stringWithFormat:@"list%d",0]];
		[LibraryData saveLibraryCondition:serch];

		for (int i = 1; i<4; i++) {
			NSMutableArray *arry= [NSMutableArray arrayWithArray:[serch objectForKey:[NSString stringWithFormat:@"list%d",i]]];
			[arry removeAllObjects];
			[serch setObject:arry forKey:[NSString stringWithFormat:@"list%d",i]];
            NSLog(@"search+++%@",serch);
			[LibraryData saveLibraryCondition:serch];
		}
	}
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:NSLocalizedString(@"返回",nil) style:UIBarButtonItemStyleBordered target:self action:@selector(goBack)];
    self.navigationItem.title = NSLocalizedString(@"设置－专利库",nil);
    UITableView *tabview=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-44) style:UITableViewStyleGrouped];
 
    self.tv1 = tabview;
    [tabview release];
    self.tv1.dataSource = self;
    self.tv1.delegate = self;
    tv1.backgroundView=[[[UIView alloc]init]autorelease];
	self.tv1.backgroundColor = Main_Color;
    [tv1 reloadData];
    [self.view addSubview:tv1];
    [tv1 release];
    [super viewDidLoad];
	UIBarButtonItem *rightButnItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"Gfirst.png"] style:UIBarButtonItemStyleBordered target:self action:@selector(SelfPopToROOtViewControl)];
    self.navigationItem.rightBarButtonItem = rightButnItem;
	[rightButnItem release];
	
}
-(void)viewWillDisappear:(BOOL)animated
{
    [self goBack];
}
-(void)SelfPopToROOtViewControl
{
	[self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)viewDidAppear:(BOOL)animated
{
	
	[super viewDidAppear:animated];
//	self.tv1.contentOffset = CGPointMake(0, 0);
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 6;
    }
    else if (section == 1)
    {
        return 3;
    }
    else if (section == 2)
    {
        return 2;
    }
    else
    {
        return 11;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
	NSString *b = [NSString stringWithFormat:@"bacea%d%d",indexPath.section,indexPath.row];
    UITableViewCell *cell = [self.tv1 dequeueReusableCellWithIdentifier:b];
	
    if (cell == nil)
    {
        cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:b] autorelease];
    }
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitleColor:[UIColor clearColor] forState:UIControlStateNormal] ;

	button.frame = CGRectMake(270, 10, 30, 30);
	[button addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
	if (ifisNil) {
		if (indexPath.section==0&&indexPath.row<3) {
        [button setImage:[UIImage imageNamed:@"01.png"] forState:UIControlStateNormal];
        [button setTitle:@"选中" forState:UIControlStateNormal];
		}else{
		[button setImage:[UIImage imageNamed:@"02.png"] forState:UIControlStateNormal];
		[button setTitle:@"取消" forState:UIControlStateNormal];
		}
	}else{
		if (![self setSelct:indexPath]) {
			[button setTitle:@"选中" forState:UIControlStateNormal];
			[button setImage:[UIImage imageNamed:@"01.png"] forState:UIControlStateNormal];
		}
		else
		{
			[button setTitle:@"取消" forState:UIControlStateNormal];
			[button setImage:[UIImage imageNamed:@"02.png"] forState:UIControlStateNormal];
		}
	}
	[cell addSubview:button];
    NSInteger section = [indexPath section];
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithDictionary:[LibraryData GetNowLibraryDataCondition]];
    self.array = [dictionary objectForKey:[NSString stringWithFormat:@"section%d",section]];
//    NSArray *arr = [dictionary objectForKey:[NSString stringWithFormat:@"list%d",section]];
    cell.textLabel.text = NSLocalizedString([self.array objectAtIndex:indexPath.row],nil);
    cell.textLabel.font = [UIFont fontWithName:nil size:12];
    cell.textLabel.textColor = Text_Color_Green;
//	if ([button.titleLabel.text  isEqualToString: @"取消"])
//    {
//        NSMutableDictionary *serch=[NSMutableDictionary dictionaryWithDictionary :[LibraryData GetNowLibraryDataCondition]];
//        NSMutableArray *arry= [NSMutableArray arrayWithArray:[serch objectForKey:[NSString stringWithFormat:@"list%d",indexPath.section]]];
//        [arry removeObject:[NSString stringWithFormat:@"%d",indexPath.row]];
//        [serch setObject:arry forKey:[NSString stringWithFormat:@"list%d",indexPath.section]];
//        [LibraryData saveLibraryCondition:serch];
//    }
//    else if ([button.titleLabel.text isEqualToString: @"选中"])
//    {
//        NSMutableDictionary *serch=[NSMutableDictionary dictionaryWithDictionary :[LibraryData GetNowLibraryDataCondition]];
//        NSMutableArray *arry= [NSMutableArray arrayWithArray:[serch objectForKey:[NSString stringWithFormat:@"list%d",indexPath.section]]];
//        if ([arry indexOfObject:[NSString stringWithFormat:@"%d",indexPath.row]]==NSNotFound)
//        {
//            [arry insertObject:[NSString stringWithFormat:@"%d",indexPath.row] atIndex:0];
//            
//            if ([arry count]>1) {
//                NSArray *sortedArray = [arry sortedArrayUsingComparator: ^(id obj1, id obj2) {
//                    
//                    if ([obj1 integerValue] > [obj2 integerValue]) {
//                        return (NSComparisonResult)NSOrderedDescending;//递减
//                    }
//                    
//                    if ([obj1 integerValue] < [obj2 integerValue]) {
//                        return (NSComparisonResult)NSOrderedAscending;//上升
//                    }
//                    return (NSComparisonResult)NSOrderedSame;
//                }];
//                
//                [serch setObject:sortedArray forKey:[NSString stringWithFormat:@"list%d",indexPath.section]];
//                [LibraryData saveLibraryCondition:serch];
//                
//            }
//            else
//            {
//                [serch setObject:arry forKey:[NSString stringWithFormat:@"list%d",indexPath.section]];
//                [LibraryData saveLibraryCondition:serch];
//            }
//        }
//
//    }
	
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell= [self.tv1 cellForRowAtIndexPath:indexPath];
    for (UIButton *btn in cell.subviews) {
        if ([[btn class] isSubclassOfClass:[UIButton class]]) {
            [btn becomeFirstResponder];
            [self buttonTapped:btn];
        }
    }

    [self.tv1 deselectRowAtIndexPath:indexPath animated:YES];
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
    
    NSIndexPath *indexPath = [self.tv1 indexPathForCell:cell];
    if ([senderButton.titleLabel.text  isEqualToString: @"选中"])
    {
        NSMutableDictionary *serch=[NSMutableDictionary dictionaryWithDictionary :[LibraryData GetNowLibraryDataCondition]];
        NSMutableArray *arry= [NSMutableArray arrayWithArray:[serch objectForKey:[NSString stringWithFormat:@"list%d",indexPath.section]]];
        [arry removeObject:[NSString stringWithFormat:@"%d",indexPath.row]];
        [serch setObject:arry forKey:[NSString stringWithFormat:@"list%d",indexPath.section]];
        [LibraryData saveLibraryCondition:serch];
        [senderButton setTitle:@"取消" forState:UIControlStateNormal];
        [senderButton setImage:[UIImage imageNamed:@"02.png"] forState:UIControlStateNormal];
    }
    else if ([senderButton.titleLabel.text isEqualToString: @"取消"])
    {
        NSMutableDictionary *serch=[NSMutableDictionary dictionaryWithDictionary :[LibraryData GetNowLibraryDataCondition]];
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
                [LibraryData saveLibraryCondition:serch];
                
            }
            else
            {
                [serch setObject:arry forKey:[NSString stringWithFormat:@"list%d",indexPath.section]];
                [LibraryData saveLibraryCondition:serch];
            }
        }
        [senderButton setTitle:@"选中" forState:UIControlStateNormal];
        [senderButton setImage:[UIImage imageNamed:@"01.png"] forState:UIControlStateNormal];
    }
}
-(IBAction)goBack
{
    NSMutableDictionary *library=[NSMutableDictionary dictionaryWithDictionary :[LibraryData GetNowLibraryDataCondition]];
 
    self.libString =[NSString stringWithFormat:@""];
    for (NSString *str in [library allKeys])
    {
        if ([str hasPrefix:@"list"]) {
            NSString *s=[str substringFromIndex:str.length-1];
            NSMutableArray *arry=[library objectForKey:str];
                    
            for (int i=0; i<[arry count]; i++) {
                
                NSMutableArray *arrysection=[library objectForKey:[NSString stringWithFormat:@"value%@",s]];
                
                NSLog(@"value:%@  section%@ row:%d",[arrysection objectAtIndex:[[arry objectAtIndex:i] intValue]],s,[[arry objectAtIndex:i] intValue]);
                //  tempString = [arrysection componentsJoinedByString:@","];
                
                                
                self.tempString =[NSString stringWithFormat:@"%@,",[arrysection objectAtIndex:[[arry objectAtIndex:i] intValue]]] ;
                self.libString = [self.libString stringByAppendingString:tempString];
                NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
                [user setObject:libString forKey:@"strSources"];
                [user synchronize];
                data = [self.libString dataUsingEncoding:NSUTF8StringEncoding];
            }
        }
    }
    
    [self postToServer];
//    [self.navigationController popViewControllerAnimated:YES];
}
-(IBAction)postToServer
{
    UIActivityIndicatorView *aiv = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [aiv startAnimating];
    [self.tv1 addSubview:aiv];
    [aiv release];
    
    NSString *path = [NSString stringWithFormat:@"http://59.151.99.154:8080/pss-mp/pos"];
    NSURL *url = [NSURL URLWithString:path];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:data];
    [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    [request release];
}

- (void)viewDidUnload
{
    self.tv1 = nil;
    self.array = nil;
    self.tempString = nil;
    self.libString = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
