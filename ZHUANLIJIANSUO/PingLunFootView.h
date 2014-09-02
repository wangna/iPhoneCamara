//
//  PingLunFootView.h
//  ZHUANLIJIANSUO
//
//  Created by chenhuiguo on 12-8-31.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PingLunFootView : UIView
<UITextViewDelegate>

@property(retain,nonatomic)UITextView *mGTextView;
@property(retain,nonatomic)NSString *pingFen;
@property(assign,nonatomic)id delegate;
@property(assign,nonatomic)SEL gChangeFrame;
@property(assign,nonatomic)SEL gSoapToServe;
-(void)gAddButtonAndTextView;
-(void)soapToServer;
@end
