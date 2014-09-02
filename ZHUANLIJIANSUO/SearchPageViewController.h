//
//  SearchPageViewController.h
//  PatentSearch
//
//  Created by wei on 12-8-13.
//  Copyright (c) 2012年 wei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LibrarySetting.h"
@interface SearchPageViewController : UIViewController <UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    UITableView *tableView;
    NSMutableArray *array2;
    UITextField *field;
    float Vheight;
    NSString *mess;
    UILabel *label;
    NSMutableArray *searchArray;
    NSMutableDictionary *valueDic;
    NSString *dataString;
    NSMutableArray *array;
    
}
@property (nonatomic,retain)UITableView *tableView;
@property (nonatomic,retain)NSMutableArray *array2;
@property (nonatomic,retain)NSString *mess;
@property (nonatomic,retain)NSMutableArray *searchArray;
@property (nonatomic,retain)UITextField *field;
@property (nonatomic,retain)UILabel *label;
@property (nonatomic,retain)NSString *dataString;
-(IBAction)goBack:(id)sender;
-(IBAction)Settting:(id)sender;
-(IBAction)textFieldDone:(id)sender;
@end
