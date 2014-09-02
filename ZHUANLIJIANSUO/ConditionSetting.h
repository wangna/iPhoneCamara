//
//  ConditionSetting.h
//  PatentSearch
//
//  Created by wei on 12-8-13.
//  Copyright (c) 2012年 wei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchPageViewController.h"
@interface ConditionSetting : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *tv;
    NSMutableArray *list;
    NSIndexPath *lastIndexPath;
    UIButton *button;
    SearchPageViewController *searchPage;
    float Vheight;
}
@property (nonatomic,retain)UITableView *tv;
@property (nonatomic,retain)NSMutableArray *list;
@property (nonatomic,retain)SearchPageViewController *searchPage;
-(IBAction)Back:(id)sender;
-(IBAction)buttonTapped:(id)sender;
@end
