//
//  LibraryData.h
//  PatentSearch
//
//  Created by wei on 12-8-15.
//  Copyright (c) 2012年 wei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LibraryData : NSObject
+(NSMutableDictionary *)getAllLibraryDataCondition;
+(void)saveLibraryCondition:(NSMutableDictionary *)dic;
+(NSMutableDictionary *)GetNowLibraryDataCondition;
@end
