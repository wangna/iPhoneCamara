//
//  system.h
//  Finance_ios
//
//  Created by iHope iHope on 11-11-9.
//  Copyright (c) 2011年 iHope. All rights reserved.
//


//http://www.kingfinancial.cn
//http://124.207.165.67:8080/appswsdoc/
//13677799524
//123456
//#pragma mark ---- url ----
//真实网址
//#define PATH_URL  @"http://59.151.99.154:8080/pss-mp/"
#define BASE_URL  @"http://i.souips.com/index.php?m=interface"
//测试网址
//#define BASE_URL  @"http://phpcms.zhendata.com/index.php?m=interface"
//#define BASE_URL  @"http://221.122.40.156:8000/pss-mp/"
//用户登录
#define MEMBER_URL [NSString stringWithFormat:@"%@", BASE_URL]
//所有消息
#define INFOMATION_URL [NSString stringWithFormat:@"%@%@", BASE_URL,@"informationwebservice?wsdl"]
//产品中心
#define PRODUCT_URL  [NSString stringWithFormat:@"%@%@", BASE_URL,@"productwebservice?wsdl"]
//网页
#define SURVEY_WEB_URL  [NSString stringWithFormat:@"%@%@", BASE_URL,@"surveywebservice?wsdl"]
//网页
#define ENTER_PRISE_URL  [NSString stringWithFormat:@"%@%@", BASE_URL,@"enterprisewebservice?wsdl"]
#define LINK_PASSWORD @"phpcms"
#define NET_LINK_FAIL @"网络连接失败！"

//*******定义COLOR************
#pragma mark 定义COLOR
#define  NavgaitonBar_Color     [UIColor colorWithRed:22.0/255.0 green:99.0/255.0 blue:153.0/255.0 alpha:1.00]
#define Text_Color_Green  [UIColor colorWithRed:143.0/255.0 green:180.0/255.0 blue:16.0/255.0 alpha:1.0]
#define Text_color_Black  [UIColor colorWithRed:75.0/255.0 green:91.0/255.0 blue:104.0/255.0 alpha:1.0]
#define Main_Color   [UIColor colorWithRed:236.0/255.0	green:246.0/255.0 blue:251.0/255.0 alpha:1.00]


typedef enum{
    PRDU_TYPE_MSG,
    PRDU_TYPE_SUN,
    PRDU_TYPE_PRIVATE,
    PRDU_TYPE_OTHER
}PRDU_TYPE;


typedef enum{
    QUE_TYPE_BUY=1,
    QUE_TYPE_TRAC,
    QUE_TYPE_HOME,
    QUE_TYPE_BEAUTY,
    QUE_TYPE_FOOD,
    QUE_TYPE_OTHER
}QUE_TYPE;

typedef enum{
	USER_SEX_FEMALE,
    USER_SEX_MALE
    
}USER_SEX;




