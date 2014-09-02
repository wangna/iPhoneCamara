//
//  CustomCell.h
//  PatentSearch
//
//  Created by wei on 12-8-22.
//  Copyright (c) 2012年 wei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCell : UITableViewCell
@property(assign,nonatomic)SEL GetfieldText;
@property(assign,nonatomic)id delegate;
@property (retain,nonatomic)IBOutlet UITextField *gTextfield;
@property (retain,nonatomic)IBOutlet UILabel *label;
@property (retain,nonatomic)NSString *mGString;
-(IBAction)textFieldDone:(id)sender;
-(void)addtextfieldWithTag:(NSInteger)tag;
@end
