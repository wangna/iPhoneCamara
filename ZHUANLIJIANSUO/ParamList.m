//
//  ParamList.m
//  EcVideo
//
//  Created by hepburn X on 12-4-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ParamList.h"

@implementation ParamList

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
