//
//  GKuTableView.h
//  ZHUANLIJIANSUO
//
//  Created by chenhuiguo on 12-9-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GKuTableView : UIView<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,retain)UITableView *tv1;
@property (nonatomic,retain)NSArray *list1;
@property (nonatomic,retain)NSString *str;
@property (nonatomic,retain)NSString *Gzong;
@property (nonatomic,assign)id delegate;
@property (nonatomic,assign)SEL nameTitle;
@property (nonatomic,assign)NSInteger gTheRow;
- (id)initWithFrame:(CGRect)frame Array:(NSArray *)array;
@end
