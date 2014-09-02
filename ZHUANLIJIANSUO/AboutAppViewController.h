//
//  AboutAppViewController.h
//  ZhuanLiTong_ZF
//
//  Created by WO on 13-5-27.
//
//

#import <UIKit/UIKit.h>
#import <StoreKit/StoreKit.h>
@interface AboutAppViewController : UITableViewController<SKStoreProductViewControllerDelegate>
{
    CGRect frame;
    
}
@property(nonatomic,retain)NSString *limitDays;

@end
