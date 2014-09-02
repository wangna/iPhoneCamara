//
//  HomeButtonViewController.h
//  ZHUANLIJIANSUO
//
//  Created by chenhuiguo on 12-7-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ALAssetsLibrary+CustomPhotoAlbum.h"


@interface HomeButtonViewController : UIViewController
<UISearchBarDelegate,UIAlertViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property(nonatomic,retain)UIButton *gTSerchBt;
@property(nonatomic,retain)UITextField *mGSearchField;
@property(nonatomic,retain)NSMutableArray *arrBtn;
@property(nonatomic,retain)NSString *tmpDay;
@property(strong,atomic)ALAssetsLibrary *library;

@end
