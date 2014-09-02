//
//  DanDuParamlist.h
//  ZHUANLIJIANSUO
//
//  Created by chenhuiguo on 12-9-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DanDuParamlist : NSObject{
    NSMutableArray *mArray;
}

@property (nonatomic, assign) NSMutableArray *mArray;

- (void)AddParam:(NSString *)name :(NSString *)value;


@end
