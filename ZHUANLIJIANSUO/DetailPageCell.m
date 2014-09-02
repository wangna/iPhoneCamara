//
//  DetailPageCell.m
//  PatentSearch
//
//  Created by wei on 12-8-23.
//  Copyright (c) 2012年 wei. All rights reserved.
//

#import "DetailPageCell.h"
#import "GNewDtailSearchTable.h"
@implementation DetailPageCell
@synthesize titleLabel,valueLabel;
@synthesize valueString;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
       self.backgroundColor = Main_Color; 
	}
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)addTheDetailData
{
    UILabel *alabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 0, 320, 20)];
    alabel.backgroundColor = [UIColor clearColor];
    alabel.textColor = Text_Color_Green;
    alabel.font = [UIFont boldSystemFontOfSize:14.0];
	alabel.tag = 1;
    alabel.text = self.titleLabel;
    [self addSubview:alabel];
    [alabel release];

	


    NSString *htmlString=@"";
    if ([self.titleLabel isEqualToString:@"摘要"]||[self.titleLabel isEqualToString:@"主权项"]) {
        NSString *str=[[[[[self.valueLabel stringByReplacingOccurrencesOfString:@"～gt;" withString:@">"]stringByReplacingOccurrencesOfString:@"～lt;" withString:@"<"]stringByReplacingOccurrencesOfString:@"～quot;" withString:@"\""]stringByReplacingOccurrencesOfString:@"～amp;amp;" withString:@"&"]stringByReplacingOccurrencesOfString:@"～amp;" withString:@"&"];
        NSLog(@"value---%@",self.valueLabel);
        CGSize detailSize =  [str sizeWithFont:[UIFont boldSystemFontOfSize:14.5] constrainedToSize:CGSizeMake(305, 4000) lineBreakMode:NSLineBreakByCharWrapping];
        //        blabel.text = str;
        htmlString = [[[@"<html><body bgcolor=\"#ecf6fb\"><p><font size=\"2px\"><font color=Black>" stringByAppendingFormat:@"%@%@%@",str,@"<meta name=\"format-detection\" content=\"telephone=no\" /> ",@"</font></font></p></body></html>"]stringByReplacingOccurrencesOfString:@"WIDTH=" withString:@""]stringByReplacingOccurrencesOfString:@"HEIGHT=" withString:@""];
        UIWebView *GNameLabel = [[UIWebView alloc]initWithFrame:CGRectMake(-5, 16, 330, detailSize.height)];
        GNameLabel.backgroundColor = Main_Color;
        GNameLabel.delegate = self;
        GNameLabel.scrollView.scrollEnabled=NO;
        [GNameLabel loadHTMLString:htmlString baseURL:nil];
        [self addSubview:GNameLabel];
        [GNameLabel release];

    }
    else
    {
        CGSize detailSize =  [self.valueString sizeWithFont:[UIFont boldSystemFontOfSize:14] constrainedToSize:CGSizeMake(320, 4000) lineBreakMode:NSLineBreakByCharWrapping];
        UILabel *blabel = [[UILabel alloc]initWithFrame:CGRectMake(3, 22, 320, detailSize.height)];
        blabel.backgroundColor = [UIColor clearColor];
        blabel.numberOfLines = 0;
        blabel.textColor = Text_color_Black;
        blabel.tag = 2;
        blabel.font = [UIFont boldSystemFontOfSize:14];
        blabel.text = self.valueLabel;
        [self.contentView addSubview:blabel];
        [blabel release];

    }
    
}

@end
