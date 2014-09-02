//
//  gAllAlertVIew.m
//  ZHUANLIJIANSUO
//
//  Created by chenhuiguo on 12-9-3.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "gAllAlertVIew.h"

@implementation gAllAlertVIew
-(id)initWithTitle:(NSString *)title message:(NSString *)message delegate:(id)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ...
{
	if (self = [super initWithTitle:title message:message delegate:delegate cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles,nil]) {
		
	}
	return  self;
}
@end
