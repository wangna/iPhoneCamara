//
//  DanDuParamlist.m
//  ZHUANLIJIANSUO
//
//  Created by chenhuiguo on 12-9-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DanDuParamlist.h"

@implementation DanDuParamlist
@synthesize mArray;

- (id)init {
    self = [super init];
    if (self) {
        mArray = [[NSMutableArray alloc] initWithCapacity:10];
    }
    return self;
}

- (void)dealloc {
    [mArray release];
    [super dealloc];
}

- (void)AddParam:(NSString *)name :(NSString *)value {
    NSMutableDictionary *dict = [[[NSMutableDictionary alloc] init] autorelease];
    [dict setObject:name forKey:@"name"];
    [dict setObject:value forKey:@"value"];
    [mArray addObject:dict];
}


@end
