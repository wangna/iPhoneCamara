//
//  searchData.m
//  PatentSearch
//
//  Created by wei on 12-8-15.
//  Copyright (c) 2012年 wei. All rights reserved.
//

#import "searchData.h"

@implementation searchData
+(NSMutableDictionary *)getAllSearchCondition
{
   NSMutableDictionary * dictionary = [[[NSMutableDictionary alloc]initWithCapacity:5]autorelease];
    
    NSMutableArray *arry0=[NSMutableArray arrayWithObjects:@"名称", nil] ;
    [dictionary setObject:arry0 forKey:@"section0"];
    
    NSMutableArray *arrylist0=[NSMutableArray arrayWithObjects:@"0", nil];
    [dictionary setObject:arrylist0 forKey:@"list0"];
    
    NSMutableArray *value0 = [NSMutableArray arrayWithObjects:@"名称",nil];
    [dictionary setObject:value0 forKey:@"value0"];
    
    NSMutableArray *arry1=[NSMutableArray arrayWithObjects:@"分类号",@"申请号",@"主分类号",@"公开号", nil] ;
    [dictionary setObject:arry1 forKey:@"section1"];
    NSMutableArray *arrylist1=[NSMutableArray arrayWithObjects:@"0",@"1",@"2",@"3", nil];
    [dictionary setObject:arrylist1 forKey:@"list1"];
    
    NSMutableArray *value1 = [NSMutableArray arrayWithObjects:@"分类号",@"申请号",@"主分类号",@"公开（公告）号", nil];
    [dictionary setObject:value1 forKey:@"value1"];

    
    NSMutableArray *arry2=[NSMutableArray arrayWithObjects:@"公开日",@"申请日", nil] ;
    [dictionary setObject:arry2 forKey:@"section2"];
    NSMutableArray *arrylist2=[NSMutableArray arrayWithObjects:@"0",@"1", nil];
    [dictionary setObject:arrylist2 forKey:@"list2"];
    
    NSMutableArray *value2 = [NSMutableArray arrayWithObjects:@"公开（公告）日",@"申请日", nil];
    [dictionary setObject:value2 forKey:@"value2"];

    
    NSMutableArray *arry3=[NSMutableArray arrayWithObjects:@"发明人",@"申请人",@"代理机构",@"代理人", nil] ;
    [dictionary setObject:arry3 forKey:@"section3"];
    NSMutableArray *arrylist3=[NSMutableArray arrayWithObjects:@"0",@"1",@"2",@"3", nil];
    [dictionary setObject:arrylist3 forKey:@"list3"];
    
    NSMutableArray *value3 = [NSMutableArray arrayWithObjects:@"发明（设计）人",@"申请（专利权）人",@"专利代理机构",@"代理人", nil];
    [dictionary setObject:value3 forKey:@"value3"];
    
    
    NSMutableArray *arry4=[NSMutableArray arrayWithObjects:@"国省代码",@"优先权",@"平均分", nil] ;
    [dictionary setObject:arry4 forKey:@"section4"];
    NSMutableArray *arrylist4=[NSMutableArray arrayWithObjects:@"0",@"1",@"2", nil];
    [dictionary setObject:arrylist4 forKey:@"list4"];
    
    NSMutableArray *value4 = [NSMutableArray arrayWithObjects:@"国省代码",@"优先权",@"平均分", nil];
    [dictionary setObject:value4 forKey:@"value4"];
    
    NSMutableArray *arry5=[NSMutableArray arrayWithObjects:@"地址",@"摘要",@"主权项", nil] ;
    [dictionary setObject:arry5 forKey:@"section5"];
    NSMutableArray *arrylist5=[NSMutableArray arrayWithObjects:@"0",@"1",@"2", nil];
    [dictionary setObject:arrylist5 forKey:@"list5"];
    
    NSMutableArray *value5 = [NSMutableArray arrayWithObjects:@"地址",@"摘要",@"主权项", nil];
    [dictionary setObject:value5 forKey:@"value5"];
    
    return dictionary;
   
}
+(void)saveSearchCondition:(NSMutableDictionary *)dic
{
    [[NSUserDefaults standardUserDefaults] setObject:dic forKey:@"searchCondition11"];
}

+(NSMutableDictionary*)GetNowSearchCondition
{
    
    NSMutableDictionary *dic=[[ NSUserDefaults standardUserDefaults] objectForKey:@"searchCondition11"];
    if (dic) {
        return dic;
    }
    else
        return [searchData getAllSearchCondition] ;
}

@end
