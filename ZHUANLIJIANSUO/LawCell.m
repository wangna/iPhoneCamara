//
//  LawCell.m
//  ZHUANLIJIANSUO
//
//  Created by WO on 13-3-27.
//
//
#define blue [UIColor colorWithRed:22.0/255.0 green:99.0/255.0 blue:153.0/255.0 alpha:1.00]
#import "LawCell.h"

@implementation LawCell
@synthesize apNum,date,style,message;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}
-(void)addLawDetail
{
    UILabel *apstr=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 120, 28)];
    apstr.backgroundColor=[UIColor clearColor];
    apstr.textColor=blue;
    apstr.font = [UIFont boldSystemFontOfSize:16.0];
    apstr.text =NSLocalizedString(@"申请(专利)号:",nil);
    [self addSubview:apstr];
    [apstr release];
   UILabel *apNumLabel = [[UILabel alloc]initWithFrame:CGRectMake(120,0, 220, 28)];
    apNumLabel.backgroundColor = [UIColor clearColor];
    apNumLabel.textColor = [UIColor blackColor];
    apNumLabel.font = [UIFont boldSystemFontOfSize:16.0];
	apNumLabel.tag = 1;
    apNumLabel.text = self.apNum;
    [self addSubview:apNumLabel];
    [apNumLabel release];
    
	
    UILabel *dastr=[[UILabel alloc]initWithFrame:CGRectMake(0, 30, 120, 28)];
    dastr.backgroundColor=[UIColor clearColor];
    dastr.textColor=blue;
    dastr.font = [UIFont boldSystemFontOfSize:16.0];
    dastr.text =NSLocalizedString(@"法律状态公告日:",nil);
    [self addSubview:dastr];
    [dastr release];
    UILabel *dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(120, 30, 300, 28)];
    dateLabel.backgroundColor = [UIColor clearColor];
    dateLabel.numberOfLines = 0;
    dateLabel.tag = 2;
    dateLabel.font = [UIFont boldSystemFontOfSize:16];
    dateLabel.text = self.date;
    [self addSubview:dateLabel];
    [dateLabel release];
    
    UILabel *ststr=[[UILabel alloc]initWithFrame:CGRectMake(0, 60, 120, 28)];
    ststr.backgroundColor=[UIColor clearColor];
    ststr.textColor=blue;
    ststr.font = [UIFont boldSystemFontOfSize:16.0];
    ststr.text =NSLocalizedString(@"法律状态类型:",nil);
    [self addSubview:ststr];
    [ststr release];
    CGSize styleSize =  [self.style sizeWithFont:[UIFont boldSystemFontOfSize:16] constrainedToSize:CGSizeMake(200, 4000) lineBreakMode:NSLineBreakByCharWrapping];
    if (styleSize.height<28) {
        styleSize.height=28;
    }
    UILabel *styleLabel = [[UILabel alloc]initWithFrame:CGRectMake(120, 60, 200, styleSize.height)];
    styleLabel.backgroundColor = [UIColor clearColor];
    styleLabel.numberOfLines = 0;
    styleLabel.tag = 3;
    styleLabel.font = [UIFont boldSystemFontOfSize:16];
    styleLabel.text = self.style;
    [self addSubview:styleLabel];
    [styleLabel release];
    
    UILabel *mestr=[[UILabel alloc]initWithFrame:CGRectMake(0, 62+styleSize.height, 110, 28)];
    mestr.backgroundColor=[UIColor clearColor];
    mestr.textColor=blue;
    mestr.font = [UIFont boldSystemFontOfSize:16.0];
    mestr.text =NSLocalizedString(@"法律状态信息:",nil);
    [self addSubview:mestr];
    [mestr release];
    CGSize detailSize =  [self.message sizeWithFont:[UIFont boldSystemFontOfSize:16] constrainedToSize:CGSizeMake(200, 4000) lineBreakMode:NSLineBreakByCharWrapping];
    if (detailSize.height<28) {
        detailSize.height=28;
    }
    UILabel *messageLabel = [[UILabel alloc]initWithFrame:CGRectMake(120, 62+styleSize.height, 200, detailSize.height)];
    messageLabel.backgroundColor = [UIColor clearColor];
    messageLabel.font = [UIFont boldSystemFontOfSize:16.0];
	messageLabel.tag = 1;
    messageLabel.numberOfLines=0;
    messageLabel.text = self.message;
    [self addSubview:messageLabel];
    [messageLabel release];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
