//
//  CustomCell.m
//  PatentSearch
//
//  Created by wei on 12-8-22.
//  Copyright (c) 2012年 wei. All rights reserved.
//

#import "CustomCell.h"

@implementation CustomCell
@synthesize GetfieldText,delegate;
@synthesize gTextfield,label,mGString;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
           }
    return self;
}
-(void)addtextfieldWithTag:(NSInteger)tag
{
    UITextField *atext = [[UITextField alloc]initWithFrame:CGRectMake(105, 6, 195, 32)];
    atext.borderStyle = UITextBorderStyleRoundedRect;
    self.gTextfield = atext;
    [atext addTarget:self action:@selector(getTheFieldText) forControlEvents:UIControlEventEditingDidEnd];
    [atext addTarget:self action:@selector(textFieldDone:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [atext release];
    atext.tag = tag;
    [self addSubview:self.gTextfield];
    
    UILabel *alabel = [[UILabel alloc]initWithFrame:CGRectMake(13, 11, 98, 21)];
    self.label = alabel;
    [alabel setBackgroundColor:[UIColor clearColor]];
    alabel.textColor = Text_Color_Green;
    [self addSubview:alabel];
    [alabel release];

}
-(void)getTheFieldText
{
    [self.delegate performSelector:self.GetfieldText withObject:self];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(IBAction)textFieldDone:(id)sender
{
    [self.gTextfield resignFirstResponder];
}
@end
