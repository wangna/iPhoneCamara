//
//  LoadView.h
//  YuYeWeiBo
//
//  Created by Hepburn on 11-9-20.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface LoadView : UIView 
{
	UIActivityIndicatorView *mActView;
	UIView *mBackView;
}
@property(retain,nonatomic) NSString *gName;
- (void)StartAnimate;
- (void)StopAnimate;

@end
