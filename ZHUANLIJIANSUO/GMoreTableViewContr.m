//
//  GMoreTableViewContr.m
//  ZHUANLIJIANSUO
//
//  Created by chenhuiguo on 12-9-5.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
// 

#import "GMoreTableViewContr.h"
#import "GFanKuiVIewControl.h"
#import "GOboatVIewContr.h"
@interface GMoreTableViewContr()
{
	NSArray *GMoreArray;
}
@end
@implementation GMoreTableViewContr

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
      self.navigationController.navigationBarHidden = NO;
		self.title = @"更多";
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
	self.navigationController.navigationBarHidden = NO;
	GMoreArray = [[NSArray alloc]initWithObjects:@"关于",@"信息反馈", nil];
    [super viewDidLoad];
	self.tableView.backgroundColor = Main_Color;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return GMoreArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    cell.textLabel.text = [GMoreArray objectAtIndex:indexPath.row];
	cell.textLabel.textColor = Text_Color_Green;
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (indexPath.row==0) {
		GOboatVIewContr *gOoat = [[GOboatVIewContr alloc]init];
		[self.navigationController pushViewController:gOoat animated:YES];
		[gOoat release];
	}else{
		GFanKuiVIewControl *gFanKui = [[GFanKuiVIewControl alloc]init];
		[self.navigationController pushViewController:gFanKui animated:YES];
		[gFanKui release];
	}
}
-(void)dealloc
{
	[GMoreArray release];
	[super dealloc];
}

@end
