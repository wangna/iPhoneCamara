//
//  GSearchHistCell.h
//  ZHUANLIJIANSUO
//
//  Created by chenhuiguo on 12-9-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GSearchHistCell : UITableViewCell
{
    NSMutableArray *stringArr;
}
@property(nonatomic,retain)NSDictionary *gDic;
-(void)gAddSearchHistData;
@end
