//
//  gNianJianCell.m
//  ZHUANLIJIANSUO
//
//  Created by chenhuiguo on 12-9-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "gNianJianCell.h"

@implementation gNianJianCell
@synthesize gMdic;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
      	for (int i = 0; i<3; i++) {
            UILabel *aLabel = [[UILabel alloc]initWithFrame:CGRectMake(82+80*i, 5, 80, 20)];
            aLabel.backgroundColor = [UIColor clearColor];
            aLabel.textColor = Text_color_Black;
            aLabel.tag=i+100;
            aLabel.font = [UIFont systemFontOfSize:12.0];
            [self addSubview:aLabel];
            [aLabel release];
        }
        UILabel *tLabel = [[UILabel alloc]initWithFrame:CGRectMake(2, 5, 80, 20)];
        tLabel.backgroundColor = [UIColor clearColor];
        tLabel.textColor = Text_Color_Green;
        tLabel.tag = 103;
        tLabel.font = [UIFont systemFontOfSize:12.0];
        [self addSubview:tLabel];
        [tLabel release];
    }
    return self;
}
-(void)gAddLabelAndText
{
    NSString *str1=NSLocalizedString(@"发明", nil);
    NSString *str2=NSLocalizedString(@"外观", nil);
    NSString *str3=NSLocalizedString(@"实用新型", nil);
	NSString *string1 = [NSString stringWithFormat:@"%@:%@",str1,[self.gMdic objectForKey:@"fm"]];
	NSString *string2 = [NSString stringWithFormat:@"%@:%@",str2,[self.gMdic objectForKey:@"wg"]];
	NSString *string3 = [NSString stringWithFormat:@"%@:%@",str3,[self.gMdic objectForKey:@"xx"]];
	NSString *string4 = [self.gMdic objectForKey:@"year"];
	NSArray *aArray = [NSArray arrayWithObjects:string1,string3,string2,string4, nil];
	for (int i = 0; i<4; i++) {
		UILabel *aLabel = (UILabel *)[self viewWithTag:100+i];
		aLabel.text = [aArray objectAtIndex:i];
	}
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)dealloc
{
    [super dealloc];
}
@end
