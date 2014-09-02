//
//  ContentViewController.m
//  ZHUANLIJIANSUO
//
//  Created by WO on 13-3-29.
//
//

#import "ContentViewController.h"
#import "AppDelegate.h"
static NSInteger inNum;
@interface ContentViewController ()
{
    AppDelegate *app;
}
@end

@implementation ContentViewController
@synthesize pageCount,appID;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        inNum=1;
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    if ([[[UIDevice currentDevice]systemVersion]floatValue]>=7.0)
        self.edgesForExtendedLayout = UIRectEdgeNone;
    app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [MBProgressHUD hideHUDForView:app.window animated:YES];
	// Do any additional setup after loading the view.
    UIBarButtonItem *backItem=[[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:self action:@selector(back)];
   
   
    
    backItem.tintColor=NavgaitonBar_Color;
    
    
    UIBarButtonItem *preBtn=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemRewind target:self action:@selector(btnPre)];
    UIBarButtonItem *nextBtn=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFastForward target:self action:@selector(btnNext)];
    UIBarButtonItem *jumpBtn=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(jumpAction)];
    self.navigationItem.leftBarButtonItems=[NSArray arrayWithObjects:backItem,preBtn, nil];
    self.navigationItem.rightBarButtonItems=[NSArray arrayWithObjects:jumpBtn,nextBtn,nil];
//    self.navigationItem.backBarButtonItem = backItem;
 
   
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self  action:@selector(btnPre)];
    swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    swipeRight.delegate = self;
    [self.view addGestureRecognizer:swipeRight];
    
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(btnNext)];
    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    swipeLeft.delegate = self;
    [self.view addGestureRecognizer:swipeLeft];
    [swipeLeft release];
    [swipeRight release];
    [nextBtn release];
    [backItem release];
    [preBtn release];
    [jumpBtn release];
    [self addScroll];
}
-(void)addScroll
{
    UILabel *labelPage=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    labelPage.backgroundColor=[UIColor clearColor];
    labelPage.textAlignment=NSTextAlignmentCenter;
    NSLog(@"inNum++%d",inNum);
    labelPage.text=[NSString stringWithFormat:@"%d/%d",inNum,pageCount];
    self.navigationItem.titleView=labelPage;
    int wSize=self.view.bounds.size.width;
    int hSize=self.view.bounds.size.height;
    imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, wSize, hSize)];
    //    if( [[[UIDevice currentDevice] systemVersion] floatValue]>=7.0) {
    //        [imageView setFrame:CGRectMake(0, 20, wSize, hSize-20-44)];
    //    }
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory=[paths objectAtIndex:0];
    NSString *PATH=[NSString stringWithFormat:@"%@",documentsDirectory];
    NSString *path=@"";
    if (inNum>0) {
        path=[NSString stringWithFormat:@"%@/%@_%d.PNG",PATH,appID,inNum];
    }
    NSLog(@"path===%@",path);
    UIImage *image=[UIImage imageWithContentsOfFile:path];
    imgStartWidth=imageView.frame.size.width;
	imgStartHeight=imageView.frame.size.height;
    
    scrollerView=[[UIScrollView alloc]initWithFrame:self.view.bounds];
    scrollerView.delegate=self;
    scrollerView.minimumZoomScale=1.0f;
    scrollerView.maximumZoomScale=4.0f;
    [imageView setImage:image];
    [scrollerView addSubview:imageView];
    NSLog(@"1count--%d",scrollerView.retainCount);
    
    
    [self.view addSubview:scrollerView];
    [imageView release];
    
    [labelPage release];
}

-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)jumpAction
{
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"请输入要跳转的页码" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert setAlertViewStyle:UIAlertViewStylePlainTextInput];
    [alert show];
    [alert release];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex) {
        if ([alertView textFieldAtIndex:0].text.length>0) {
            NSInteger num=[[alertView textFieldAtIndex:0].text integerValue];
            NSLog(@"pagecount=====%d",pageCount);
            if (num>0&&num<pageCount+1) {
                [scrollerView removeFromSuperview];
                [scrollerView release];
                inNum=num;
                [self viewDidLoad];
            }
            else{
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:NSLocalizedString(@"请输入有效的序号",nil) message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                [alert release];
            }
        }
        
    }
}

-(void)btnPre
{
    if (inNum>1) {
        inNum-=1;
        CATransition *animation = [CATransition animation];
        [animation setDelegate:self];
        [animation setDuration:0.5f];
        [animation setType:@"pageUnCurl"];
        //[animation setType:kcat];
        [animation setSubtype:@"fromRight"];
        [scrollerView removeFromSuperview];
        [scrollerView release];

        [self addScroll];
        [[self.view layer] addAnimation:animation forKey:@"WebPageUnCurl"];
    }
    else if(inNum==1)
    {
        MBProgressHUD *mbpShow=[[MBProgressHUD alloc]initWithView:self.view];
        [self.view addSubview:mbpShow];
        mbpShow.mode=MBProgressHUDModeText;
        mbpShow.labelText=[NSString stringWithFormat:@"已是第一页"];
        [mbpShow show:YES];
        [mbpShow hide:YES afterDelay:0.5];
        [mbpShow release];
    }
}
-(void)btnNext
{
    if (inNum<pageCount) {
        inNum++;
        CATransition *animation = [CATransition animation];
        [animation setDelegate:self];
        [animation setDuration:0.5f];
        [animation setType:@"pageCurl"];
        
        //[animation setType:kcat];
        [animation setSubtype:@"fromRight"];
        [scrollerView removeFromSuperview];
        [scrollerView release];

        [self addScroll];
        [[self.view layer] addAnimation:animation forKey:@"WebPageCurl"];
    }
    else if(inNum==pageCount)
    {
        MBProgressHUD *mbpShow=[[MBProgressHUD alloc]initWithView:self.view];
        [self.view addSubview:mbpShow];
        mbpShow.mode=MBProgressHUDModeText;
        mbpShow.labelText=[NSString stringWithFormat:@"已是最后一页"];
        [mbpShow show:YES];
        [mbpShow hide:YES afterDelay:0.5];
        [mbpShow release];
        
    }
}
-(id)initWithCoder:(NSCoder *)aDecoder{
	
	lastDistance=0;
	return [super initWithCoder:aDecoder];
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
	
	CGPoint p1;
	CGPoint p2;
	CGFloat sub_x;
	CGFloat sub_y;
	CGFloat currentDistance;
	CGRect imgFrame;
	
	NSArray * touchesArr=[[event allTouches] allObjects];
	
    NSLog(@"手指个数%d",[touchesArr count]);
    //    NSLog(@"%@",touchesArr);
	
	if ([touchesArr count]>=2) {
		p1=[[touchesArr objectAtIndex:0] locationInView:self.view];
		p2=[[touchesArr objectAtIndex:1] locationInView:self.view];
		
		sub_x=p1.x-p2.x;
		sub_y=p1.y-p2.y;
		
		currentDistance=sqrtf(sub_x*sub_x+sub_y*sub_y);
		
		if (lastDistance>0) {
			
			imgFrame=imageView.frame;
			
			if (currentDistance>lastDistance+2) {
				NSLog(@"放大");
				
				imgFrame.size.width+=10;
				if (imgFrame.size.width>1000) {
					imgFrame.size.width=1000;
				}
				
				lastDistance=currentDistance;
			}
			if (currentDistance<lastDistance-2) {
				NSLog(@"缩小");
				
				imgFrame.size.width-=10;
				
				if (imgFrame.size.width<150) {
					imgFrame.size.width=150;
				}
				
				lastDistance=currentDistance;
			}
			
			if (lastDistance==currentDistance) {
				imgFrame.size.height=imgStartHeight*imgFrame.size.width/imgStartWidth;
                
                float addwidth=imgFrame.size.width-imageView.frame.size.width;
                float addheight=imgFrame.size.height-imageView.frame.size.height;
                
				imageView.frame=CGRectMake(imgFrame.origin.x-addwidth/2.0f, imgFrame.origin.y-addheight/2.0f, imgFrame.size.width, imgFrame.size.height);
			}
			
		}else {
			lastDistance=currentDistance;
		}
        
	}
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
	lastDistance=0;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.

- (UIView*)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    for (id view in [scrollerView subviews]) {
        if ([view isKindOfClass:[UIImageView class]]) {
            return view;
        }
    }
    return  nil;
}
-(void)viewWillDisappear:(BOOL)animated{
    NSFileManager *fileManger=[NSFileManager defaultManager];
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory=[paths objectAtIndex:0];
    for (int i=0; i<pageCount; i++) {
        [fileManger removeItemAtPath:[documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_%d.PNG",appID,i+1]] error:nil];
    }
    if (scrollerView.retainCount>1) {
        [scrollerView release];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
