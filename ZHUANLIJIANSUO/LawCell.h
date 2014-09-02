//
//  LawCell.h
//  ZHUANLIJIANSUO
//
//  Created by WO on 13-3-27.
//
//

#import <UIKit/UIKit.h>

@interface LawCell : UITableViewCell
@property(nonatomic,retain)NSString *apNum;
@property(nonatomic,retain)NSString *date;
@property(nonatomic,retain)NSString *style;
@property(nonatomic,retain)NSString *message;
-(void)addLawDetail;
@end
