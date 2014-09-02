//
//  DetailPageCell.h
//  PatentSearch
//
//  Created by wei on 12-8-23.
//  Copyright (c) 2012年 wei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailPageCell : UITableViewCell<UIWebViewDelegate>
@property (nonatomic,retain)NSString *titleLabel;
@property (nonatomic,retain)NSString *valueLabel;
@property (nonatomic,retain)NSString *valueString;
-(void)addTheDetailData;
@end
