//
//  searchData.h
//  PatentSearch
//
//  Created by wei on 12-8-15.
//  Copyright (c) 2012年 wei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface searchData : NSObject
+(NSMutableDictionary *)getAllSearchCondition;
+(void)saveSearchCondition:(NSMutableDictionary *)dic;
+(NSMutableDictionary *)GetNowSearchCondition;

@end
