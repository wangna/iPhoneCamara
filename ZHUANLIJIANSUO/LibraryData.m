//
//  LibraryData.m
//  PatentSearch
//
//  Created by wei on 12-8-15.
//  Copyright (c) 2012年 wei. All rights reserved.
//

#import "LibraryData.h"

@implementation LibraryData
+(NSMutableDictionary *)getAllLibraryDataCondition
{
    NSMutableDictionary * dictionary = [[[NSMutableDictionary alloc]initWithCapacity:5]autorelease];
    
    NSMutableArray *arry0=[NSMutableArray arrayWithObjects:@"中国发明专利",@"中国实用新型",@"中国外观设计",@"中国发明授权",@"香港特区",@"中国台湾专利", nil] ;
    [dictionary setObject:arry0 forKey:@"section0"];
   
    NSMutableArray *arrylist0=[NSMutableArray arrayWithObjects:@"0",@"1",@"2",@"3",@"4",@"5", nil];
    [dictionary setObject:arrylist0 forKey:@"list0"];
    
    NSMutableArray *value0 = [NSMutableArray arrayWithObjects:@"FMZL",@"SYXX",@"WGZL",@"FMSQ",@"HKPATENT",@"TWZL", nil];
    [dictionary setObject:value0 forKey:@"value0"];
    
    NSMutableArray *arry1=[NSMutableArray arrayWithObjects:@"中国外观设计（失效）",@"中国发明专利（失效）",@"中国实用新型（失效）", nil] ;
    [dictionary setObject:arry1 forKey:@"section1"];
    
    NSMutableArray *arrylist1=[NSMutableArray arrayWithObjects:@"0",@"1",@"2", nil];
    [dictionary setObject:arrylist1 forKey:@"list1"];
    NSMutableArray *value1 = [NSMutableArray arrayWithObjects:@"FMSX",@"XXSX",@"WGSX", nil];
    [dictionary setObject:value1 forKey:@"value1"];
    
    
    NSMutableArray *arry2=[NSMutableArray arrayWithObjects:@"EPO",@"WIPO", nil] ;
    [dictionary setObject:arry2 forKey:@"section2"];
    
    NSMutableArray *arrylist2=[NSMutableArray arrayWithObjects:@"0",@"1", nil];
    [dictionary setObject:arrylist2 forKey:@"list2"];
    NSMutableArray *value2 = [NSMutableArray arrayWithObjects:@"EPPATENT",@"WOPATENT", nil];
    [dictionary setObject:value2 forKey:@"value2"];
    
    
    NSMutableArray *arry3=[NSMutableArray arrayWithObjects:@"英国",@"德国",@"法国",@"瑞士",@"韩国",@"俄罗斯",@"日本",@"东南亚",@"阿拉伯",@"美国",@"其它国家和地区", nil] ;
    [dictionary setObject:arry3 forKey:@"section3"];
    NSMutableArray *arrylist3=[NSMutableArray arrayWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10", nil];
    [dictionary setObject:arrylist3 forKey:@"list3"];
    
    NSMutableArray *value3 = [NSMutableArray arrayWithObjects:@"GBPATENT",@"DEPATENT",@"FRPATENT",@"CHPATENT",@"KRPATENT",@"RUPATENT",@"JPPATENT",@"ASPATENT",@"GCPATENT",@"USPATENT",@"APPATENT,ATPATENT,AUPATENT,CAPATENT,ESPATENT,ITPATENT,SEPATENT,OTHERPATENT",nil];
    [dictionary setObject:value3 forKey:@"value3"];
   // [dictionary release];
    return dictionary;
}
+(void)saveLibraryCondition:(NSMutableDictionary *)dic
{
    // [[NSUserDefaults standardUserDefaults]setObject:dic forKey:@"libraryCondition"];
    [[NSUserDefaults standardUserDefaults]setObject:dic forKey:@"libraryCondition11"];
}
+(NSMutableDictionary *)GetNowLibraryDataCondition
{
 
    NSMutableDictionary *dic=[[ NSUserDefaults standardUserDefaults] objectForKey:@"libraryCondition11"];
    if (dic) {
        
      
        return dic;
    }
    else
    {
     
        return [LibraryData getAllLibraryDataCondition] ;
    }
}
-(void)dealloc
{
	[super dealloc];
}
@end
