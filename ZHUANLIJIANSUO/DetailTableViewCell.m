//
//  DetailTableViewCell.m
//  ZHUANLIJIANSUO
//
//  Created by chenhuiguo on 12-8-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DetailTableViewCell.h"

@implementation DetailTableViewCell
@synthesize mGtitle,mGdetail,gScore;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}

-(void)AddTitleAndDetailText
{
	UILabel *tGlable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 320, 20)];
	tGlable.textColor =Text_Color_Green;
	tGlable.text = self.mGtitle;
	tGlable.backgroundColor = Main_Color;
	[self addSubview:tGlable];
	[tGlable release];
	if (self.gScore<0) {
		NSString *aString1 = [self.mGdetail stringByReplacingOccurrencesOfString:@"◆" withString:@"\n◆"];

		CGSize tGdetailSize = [aString1 sizeWithFont:[UIFont systemFontOfSize:14.0] constrainedToSize:CGSizeMake(320, 10000) lineBreakMode:NSLineBreakByCharWrapping];
        if (aString1.length>0) {
            UILabel *tGdetailLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, tGlable.frame.size.height+5, 320, tGdetailSize.height)];
            tGdetailLabel.text = aString1;
            tGdetailLabel.numberOfLines = 0;
            tGdetailLabel.font = [UIFont systemFontOfSize:14.0];
            tGdetailLabel.backgroundColor = Main_Color;
            [self addSubview:tGdetailLabel];
            [tGdetailLabel release];
        }
		
	}else{
		for (int i=0; i<3; i++) {
			UIImageView *gtImage = [[UIImageView alloc]initWithFrame:CGRectMake(0+i*20, tGlable.frame.size.height+1, 20, 20)];
			if (self.gScore>=i+1) {
				gtImage.image = [UIImage imageNamed:@"quan.png"];
			}else if (self.gScore>=i+0.5) {
				gtImage.image = [UIImage imageNamed:@"ban.png"];
			}else {
				gtImage.image = [UIImage imageNamed:@"wuL.png"];
			}
			[self addSubview:gtImage];
			[gtImage release];
		}
				
	}
	

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
 
}
-(void)dealloc
{
	self.mGdetail = nil;
	self.mGtitle = nil;
	[super dealloc];
}

@end
