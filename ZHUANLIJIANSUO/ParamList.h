//
//  ParamList.h
//  EcVideo
//
//  Created by hepburn X on 12-4-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ParamList : NSObject {
    NSMutableArray *mArray;
}

@property (nonatomic, assign) NSMutableArray *mArray;

- (void)AddParam:(NSString *)name :(NSString *)value;

@end
