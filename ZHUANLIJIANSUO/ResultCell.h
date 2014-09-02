//
//  ResultCell.h
//  PatentSearch
//
//  Created by wei on 12-8-23.
//  Copyright (c) 2012年 wei. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface ResultCell : UITableViewCell<UIWebViewDelegate>
{
    SoapHttpManager *mSoapHttp;
    UIView *tView;
    NSArray *GtcontentArray;
}
@property(nonatomic,retain)UIButton *btnLaw;
@property(retain,nonatomic)NSString *GtitleName;
@property(retain,nonatomic)UIImage *GStarImage;
@property(retain,nonatomic)NSDictionary *GcontentDic;
@property(assign,nonatomic)CGFloat gScore;
@property(nonatomic)NSInteger index;
@property(nonatomic,retain) NSString *sourceData;
@property(nonatomic,retain)NSArray *arrData;
@property(nonatomic,retain)UINavigationController *nav;
-(void)CellAddTextLabel;

@end
