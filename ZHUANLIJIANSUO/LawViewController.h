//
//  LawViewController.h
//  ZHUANLIJIANSUO
//
//  Created by WO on 13-3-27.
//
//

#import <UIKit/UIKit.h>

@interface LawViewController : UITableViewController
{
    float Vheight;
}
@property(nonatomic,retain)NSArray *arrLaw;
-(void)add;
@end
