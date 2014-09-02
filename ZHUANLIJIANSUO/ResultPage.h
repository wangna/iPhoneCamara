//
//  ResultPage.h
//  PatentSearch
//
//  Created by wei on 12-8-23.
//  Copyright (c) 2012年 wei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
@interface ResultPage : UIViewController<UITableViewDataSource,UITableViewDelegate,NSXMLParserDelegate,UIAlertViewDelegate>
{
    SoapHttpManager *mSoapHttp;
//    NSMutableArray *list;
    UITableView *table;
	NSMutableArray *mArray;
    NSMutableArray *caArray;
    UILabel *aLabel;
    NSMutableArray *dicArray;
    NSMutableArray *arr;
    UILabel *totalLabel;
    UILabel *libLabel;
    NSString *mess0;
    NSString *mess1;
    NSString *msg;
    NSString *detailString;
    UIActivityIndicatorView *activityView;
    UIButton *btn;
    UITextField *textField ;
    float Vheight;
    UITableView *tabview;
    BOOL ku;
}
//@property (nonatomic,retain)NSMutableArray *list;
@property (nonatomic,retain)UITableView *table;
@property (nonatomic, retain) NSMutableArray *mArray;
@property(nonatomic,retain) NSString *mDic;
@property (nonatomic, retain) NSMutableArray *arr;
@property (nonatomic,retain)NSMutableArray *dicArray;
@property (nonatomic,retain)NSString *msg;
@property (nonatomic,retain)NSString *detailString;
@property (nonatomic,retain)NSMutableArray *caArray;
@property(nonatomic,retain) NSString *sourceData;
-(IBAction)buttonPressed:(id)sender;
-(IBAction)animationFinished;
-(IBAction)textFieldDone:(id)sender;
@end
