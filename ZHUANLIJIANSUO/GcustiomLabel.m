//
//  GcustiomLabel.m
//  ZHUANLIJIANSUO
//
//  Created by chenhuiguo on 12-9-14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "GcustiomLabel.h"
#import <CoreText/CoreText.h>
@implementation GcustiomLabel
-(id)init
{
	if (self = [super init]) {
		
	}
	return self;
}
-(id)initWithFrame:(CGRect)frame
{
	if (self = [super initWithFrame:frame]) {
		
	}
	return self;
}
- (NSAttributedString *)illuminatedString:(NSString *)textfont:(UIFont *)AtFont{
	
	int len = [textfont length];
	//创建一个可变的属性字符串
	 NSMutableAttributedString *mutaString = [[[NSMutableAttributedString alloc] initWithString:textfont] autorelease];
	 //改变字符串 从1位 长度为1 这一段的前景色，即字的颜色。
	/*    [mutaString addAttribute:(NSString *)(kCTForegroundColorAttributeName) 
	                        value:(id)[UIColor darkGrayColor].CGColor 
	                        range:NSMakeRange(1, 1)]; */
	 [mutaString addAttribute:(NSString *)(kCTForegroundColorAttributeName) value:(id)[[UIColor blackColor]CGColor]range:NSMakeRange(0, len)];
	
	
	
// if (self.keywordColor != nil)
// {
//	for (NSValue *value in list)
//			{
				//   NSValue *value = [list objectAtIndex:i];
//		NSRange keyRange = [value rangeValue];
		[mutaString addAttribute:(NSString *)(kCTForegroundColorAttributeName)value:(id)[[UIColor redColor]CGColor]range:NSMakeRange(0, 2)];
//					 }
//}
	
	
	
 //设置部分字段的字体大小与其他的不同
	/*    CTFontRef ctFont = CTFontCreateWithName((CFStringRef)AtFont.fontName, 
	                                             AtFont.pointSize, 
	                                             NULL);
	     [mutaString addAttribute:(NSString *)(kCTFontAttributeName) 
	                        value:(id)ctFont 
	                        range:NSMakeRange(0, 1)];*/
	
//设置是否使用连字属性，这里设置为0，表示不使用连字属性。标准的英文连字有FI,FL.默认值为1，既是使用标准连字。也就是当搜索到f时候，会把fl当成一个文字。
 int nNumType = 0;
	//    float fNum = 3.0;
 CFNumberRef cfNum = CFNumberCreate(NULL, kCFNumberIntType, &nNumType);
	//    CFNumberRef cfNum2 = CFNumberCreate(NULL, kCFNumberFloatType, &fNum);
[mutaString addAttribute:(NSString *)kCTLigatureAttributeName
		 value:(id)cfNum
range:NSMakeRange(0, len)];
//空心字
	//    [mutaString addAttribute:(NSString *)kCTStrokeWidthAttributeName value:(id)cfNum2 range:NSMakeRange(0, len)];
	
	
	CTFontRef ctFont2 = CTFontCreateWithName((CFStringRef)AtFont.fontName,
												AtFont.pointSize,
												NULL);
 [mutaString addAttribute:(NSString *)(kCTFontAttributeName)
	value:(id)ctFont2
	range:NSMakeRange(0, len)];
	//   CFRelease(ctFont);
	 CFRelease(ctFont2);
    CFRelease(cfNum);
	 return [[mutaString copy] autorelease];
}


//重绘Text
- (void)drawRect:(CGRect)rect
{
	//获取当前label的上下文以便于之后的绘画，这个是一个离屏。
	CGContextRef context = UIGraphicsGetCurrentContext();
	//压栈，压入图形状态栈中.每个图形上下文维护一个图形状态栈，并不是所有的当前绘画环境的图形状态的元素都被保存。图形状态中不考虑当前路径，所以不保存
	 //保存现在得上下文图形状态。不管后续对context上绘制什么都不会影响真正得屏幕。
	CGContextSaveGState(context);
	//x，y轴方向移动
	CGContextTranslateCTM(context, 0.0, 0.0);/*self.bounds.size.height*/
	
	 //缩放x，y轴方向缩放，－1.0为反向1.0倍,坐标系转换,沿x轴翻转180度
	// CGContextScaleCTM(context, 1, 100); 
	
	NSArray *fontArray = [UIFont familyNames];
	NSString *fontName;
	if ([fontArray count]) {
		fontName = [fontArray objectAtIndex:0];
        NSLog(@"%@",fontName);
	}
	 //创建一个文本行对象，此对象包含一个字符
	CTLineRef line = CTLineCreateWithAttributedString((CFAttributedStringRef)[self illuminatedString:self.text font:self.font]); //[UIFont fontWithName:fontName size:60]
	 //设置文字绘画的起点坐标。
	CGContextSetTextPosition(context, 0.0, 0.0); /*ceill(self.bounds.size.height/4)*/
 //在离屏上绘制line
	CTLineDraw(line, context);
	 //将离屏上得内容覆盖到屏幕。此处得做法很像windows绘制中的双缓冲。
	CGContextRestoreGState(context); 
	CFRelease(line);
	//CGContextRef myContext = UIGraphicsGetCurrentContext();
	//CGContextSaveGState(myContext);
	//[self MyColoredPatternPainting:myContext rect:self.bounds];
	//CGContextRestoreGState(myContext);
}

@end
