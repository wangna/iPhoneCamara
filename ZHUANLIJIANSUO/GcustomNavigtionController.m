//
//  GcustomNavigtionController.m
//  ZHUANLIJIANSUO
//
//  Created by chenhuiguo on 12-8-29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "GcustomNavigtionController.h"

@implementation UINavigationBar (CustomNavigationBar)

- (void)drawRect:(CGRect)rect
{
    UIImage *image = [UIImage imageNamed: @"nav_bar_bg.png"];
    [image drawInRect:CGRectMake(0, 0, self.frame.size.width,self.frame.size.height)];
	self.tintColor = NavgaitonBar_Color;
}

@end

@implementation GcustomNavigtionController


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    float version = [[[UIDevice currentDevice] systemVersion] floatValue];
    if (version>=7.0) {
        [self.navigationBar setBackgroundImage: [UIImage imageNamed: @"nav_bar_bg.png"] forBarMetrics: UIBarMetricsDefault];
        [self.navigationBar  setBarTintColor:NavgaitonBar_Color];
        [self.navigationBar setTintColor:[UIColor whiteColor]];
    }
   else if (version >= 5.0)
    {
        /* ios5/xcode4.2 以下不支持次方法 */
		[self.navigationBar setBackgroundImage: [UIImage imageNamed: @"nav_bar_bg.png"] forBarMetrics: UIBarMetricsDefault];
        /********************/
        
        self.navigationBar.tintColor = NavgaitonBar_Color;
    }
    self.navigationBar.layer.shadowOffset = CGSizeMake(0, 3);
    self.navigationBar.layer.shadowOpacity = 0.4;
    self.navigationBar.layer.shadowColor = [UIColor blackColor].CGColor;
	
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
-(BOOL)shouldAutorotate
{
    return NO;
}
-(NSInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}
-(void)dealloc
{
    [super dealloc];
}
@end
