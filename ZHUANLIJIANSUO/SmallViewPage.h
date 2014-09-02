//
//  SmallViewPage.h
//  PatentSearch
//
//  Created by wei on 12-8-24.
//  Copyright (c) 2012年 wei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SmallViewPage : UIView <UITableViewDataSource,UITableViewDelegate>
{
	NSArray *mGarray;
}
@property(nonatomic,retain)NSString *mDisStr;
@property (nonatomic,retain)UITableView *tv1;
@property (nonatomic,retain)NSArray *list1;
@property (nonatomic,retain)NSString *str;
@property (nonatomic,assign)id delegate;
@property (nonatomic,assign)SEL nameTitle;
@end
