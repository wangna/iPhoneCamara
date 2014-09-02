//
//  ContentViewController.h
//  ZHUANLIJIANSUO
//
//  Created by WO on 13-3-29.
//
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
@interface ContentViewController : UIViewController<UIScrollViewDelegate,UIGestureRecognizerDelegate>
{
    NSInteger pageCount;
    NSString *pngPath;
    UIImageView * imageView;
	
	CGFloat lastDistance;
	
	CGFloat imgStartWidth;
	CGFloat imgStartHeight;
	
	UIScrollView *scrollerView;
}
@property(nonatomic,retain) NSString *appID;
@property(nonatomic,assign)NSInteger pageCount;
@end
