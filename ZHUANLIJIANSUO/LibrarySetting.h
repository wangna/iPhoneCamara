//
//  LibrarySetting.h
//  PatentSearch
//
//  Created by wei on 12-8-13.
//  Copyright (c) 2012年 wei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchPageViewController.h"

@interface LibrarySetting : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *tv1;
    NSMutableArray *array;
//    UIButton *button;
    NSData *data;
    NSString *tempString;
    NSString *libString;
}
@property(nonatomic,retain)UITableView *tv1;
@property(nonatomic,retain)NSMutableArray *array;
@property(nonatomic,retain)NSString *tempString;
@property(nonatomic,retain)NSString *libString;
-(IBAction)goBack;
-(IBAction)buttonTapped:(id)sender;
-(IBAction)postToServer;
@end
@protocol LibrarySettingProtocal <NSObject>

-(void)chuanString:(NSString *)string;

@end