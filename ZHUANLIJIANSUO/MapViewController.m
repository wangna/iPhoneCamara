//
//  MapViewController.m
//  JiaHuaLiCai
//
//  Created by chenhuiguo on 12-5-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MapViewController.h"
#import "LoadView.h"
#import "District.h"
#import "GenericPinAnnotationView.h"
#import "MultiRowCalloutAnnotationView.h"
#import "MultiRowAnnotation.h"
#import "GAgentDetailTableView.h"




@interface MapViewController()
{
	LoadView *mLoad;
	SoapHttpManager *mSoapHttp;
	MKAnnotationView *_selectedAnnotationView;
	MultiRowAnnotation *_calloutAnnotation;
	NSMutableArray *anitionas;
}
@property (nonatomic, retain) MKAnnotationView *selectedAnnotationView;
@property (nonatomic,retain) MultiRowAnnotation *calloutAnnotation;
@end

@implementation MapViewController
@synthesize selectedAnnotationView = _selectedAnnotationView,calloutAnnotation = _calloutAnnotation,mUserPoint = _mUserPoint,mLocationManager = _mLocationManager,mMapView,gAllData,ifSoap;
//释放请求
-(id)init
{
	if (self = [super init]) {
		self.title = NSLocalizedString(@"代理分布",nil);
		ifSoap = YES;
          [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(setAN) name:@"AN" object:nil];
	}
	return self;
}
-(void)releaseSoap
{
	if (mSoapHttp) {
		[mSoapHttp Cancel];
		[mSoapHttp release];
		mSoapHttp = nil;
	}
}

-(void)setAN
{
    self.calloutAnnotation=nil;
}
- (void)didReceiveMemoryWarning
{

    [super didReceiveMemoryWarning];
    
}

#pragma mark - View lifecycle

- (void)loadView
{
    Vheight=[UIScreen mainScreen].bounds.size.height;
	self.navigationController.navigationBarHidden = NO;
	UIView *tBgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, Vheight-44)];
	self.view = tBgView;
	[tBgView release];
}
-(MKMapView *)addMapView
{
	MKMapView *tMapView = [[[MKMapView alloc]initWithFrame:CGRectMake(0, 0, 320, Vheight-44)]autorelease];
	tMapView.showsUserLocation = YES;
	return tMapView;
}
//-(void)addNavImage:(NSString *)image withWight:(CGFloat)number x:(CGFloat)x
//{
//    UIImageView *tNavImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 54)];
//    tNavImage.image = [UIImage imageNamed:@"nav.png"];
//	[self.view addSubview:tNavImage];
//    [tNavImage release];
//    UIButton *tresignBut = [UIButton buttonWithType:UIControlStateNormal];
//    [tresignBut setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
//	[tresignBut addTarget:self action:@selector(resignApp) forControlEvents:UIControlEventTouchUpInside];
//    tresignBut.frame = CGRectMake(x, 8, number, 33);
//	[self.view addSubview:tresignBut];
//    
//}
//请求列表
-(IBAction)GPostSearchAgency
{
	[self releaseSoap];
	mSoapHttp = [[SoapHttpManager alloc]init];
	mSoapHttp.delegate = self;
	mSoapHttp.OnSoapFail = @selector(GcanetFail);
	mSoapHttp.OnSoapRespond = @selector(GgetsearchAgencyData);
	NSDictionary *JsonDIc = [[NSDictionary alloc]initWithObjectsAndKeys:@"%25",@"name",@"0",@"from",@"2000",@"to",LINK_PASSWORD,@"password",@"getAgentListLite",@"a",@"interface",@"m", nil];
	NSString *tString2 = [NSString stringWithFormat:@"%@%@%@",BASE_URL,@"&a=getAgentListLite&sid=",kkSessionID];	
	NSString *tString3 = @"";
	[mSoapHttp PostSoadMessage:JsonDIc :tString2 :tString3];
	[JsonDIc release];
//	[MBProgressHUD showHUDAddedTo:self.view animated:YES];
}

//请求失败
-(void)GcanetFail
{
	[MBProgressHUD hideHUDForView:self.view animated:YES];
		UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"提示",nil)
															message:NSLocalizedString(@"网络连接失败！",nil)
														   delegate:nil 
												  cancelButtonTitle:NSLocalizedString(@"确定",nil) otherButtonTitles:nil] ;
		[alertView show];
		[alertView release];
}

//计算两地距离
-(double)countDistance:(CLLocation *)userLocation with:(CLLocationCoordinate2D)aCord2D
{
	return 	(fabs(userLocation.coordinate.latitude) - fabs(aCord2D.latitude))*(fabs(userLocation.coordinate.latitude) - fabs(aCord2D.latitude))+(fabs(userLocation.coordinate.longitude) - fabs(aCord2D.longitude))*(fabs(userLocation.coordinate.longitude) - fabs(aCord2D.longitude));
}
-(void)gAddAnitionnouView
{
	NSMutableArray *tmpArray = [[[NSMutableArray alloc] initWithCapacity:10] autorelease];
    anitionas = [[NSMutableArray alloc]initWithCapacity:10];
	for (NSDictionary *dict in self.gAllData) {
		NSString *mappoint = [dict objectForKey:@"mappoint"];
		NSString *name = [dict objectForKey:@"name"];
        BOOL bFind = NO;
        for (NSDictionary *tmpdict in tmpArray) {
            NSString *mappoint2 = [tmpdict objectForKey:@"mappoint"];
            NSString *name2 = [tmpdict objectForKey:@"name"];
            if ([mappoint isEqualToString:mappoint2] || [name isEqualToString:name2]) {
                bFind = YES;
                break;
            }
        }
        if (!bFind) {
            NSArray *GjiexiArray = [mappoint componentsSeparatedByString:@"|"];
            NSString *longitude = [GjiexiArray objectAtIndex:0];
            NSString *latitude = [GjiexiArray objectAtIndex:1];
            if ([longitude floatValue] >= -180 && [longitude floatValue] <= 180 && [latitude floatValue] >= -90 && [latitude floatValue] <= 90) {
                [tmpArray addObject:dict];
            }
        }
    }
	for (int i = 0; i<[tmpArray count]; i++) {
		NSDictionary *tDic = [tmpArray objectAtIndex:i];
		NSString *aString = [tDic objectForKey:@"mappoint"];
        if (![aString isEqualToString:@"|"]) {
            NSArray *GjiexiArray = [aString componentsSeparatedByString:@"|"];
            District *dis = [District demoAnnotationFactory:[[GjiexiArray objectAtIndex:1] doubleValue] :[[GjiexiArray objectAtIndex:0]doubleValue] :[tDic objectForKey:@"address"] :[tDic objectForKey:@"tel"] :[tDic objectForKey:@"leader"] :[tDic objectForKey:@"name"]];
            //		[self.mMapView addAnnotation:dis];
            [anitionas addObject:dis];
            
            NSLog(@"gAddAnitionnouView, %d, %@", i, tDic);
            [self.mMapView addAnnotation:dis];
        }
	}
	//[self.mMapView addAnnotations:anitionas];

}


//获取数据
-(void)GgetsearchAgencyData
{
	[MBProgressHUD hideHUDForView:self.view animated:YES];
	if (mSoapHttp.mArray.count>1) {
	[mSoapHttp.mArray removeObjectAtIndex:0];
	self.gAllData = mSoapHttp.mArray;
	[self gAddAnitionnouView];
	
	}else{
		UIAlertView *tAlert = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"提示",nil) message:[[mSoapHttp.mArray objectAtIndex:0]objectForKey:@"message"] delegate:nil cancelButtonTitle:NSLocalizedString(@"确定",nil) otherButtonTitles:nil];
		[tAlert show];
		[tAlert release];
	}
	[self releaseSoap];
	
}
- (void)viewDidLoad
{
    if ([[[UIDevice currentDevice]systemVersion]floatValue]>=7.0)
        self.edgesForExtendedLayout = UIRectEdgeNone;
	_mUserPoint =nil;
	mSoapHttp = nil;
	mLoad = nil;
	[super viewDidLoad];
//	[self addNavImage:@"back.png" withWight:33 x:700];mappoint
	self.mMapView = [self addMapView];
	self.mMapView.delegate = self;
	[self.view addSubview:self.mMapView];
	MKCoordinateRegion newRegion;
//    NSLog(@"===%f,===%f",newRegion.center.latitude,newRegion.center.longitude);
	newRegion.center.latitude = 39.923355;
	newRegion.center.longitude = 116.46768;//106.574394;
	newRegion.span.latitudeDelta = 30;
	newRegion.span.longitudeDelta = 30;
	
	[self.mMapView setRegion:newRegion animated:YES];
	_mLocationManager = [[CLLocationManager alloc]init];
	self.mLocationManager.delegate = self;
	self.mLocationManager.desiredAccuracy = kCLLocationAccuracyBest;
	[self.mLocationManager startUpdatingLocation];
	if (ifSoap) {
		[self GPostSearchAgency];
	}else{
		[self gAddAnitionnouView];
	}
	UIBarButtonItem *rightButnItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"Gfirst.png"] style:UIBarButtonItemStyleBordered target:self action:@selector(SelfPopToROOtViewControl)];
    self.navigationItem.rightBarButtonItem = rightButnItem;
	[rightButnItem release];
	
}
-(void)SelfPopToROOtViewControl
{
	[self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	
}
- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
	
}
- (void)mapView:(MKMapView *)mapView didChangeUserTrackingMode:(MKUserTrackingMode)mode animated:(BOOL)animated
{
	
}
//获取用户坐标
//-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
//{
////	if (self.mUserPoint == nil) {
////		self.mUserPoint = newLocation;
////	}
////	[self.mLocationManager stopUpdatingLocation];
////	[self GPostSearchAgency];
//}
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    
    if (![annotation conformsToProtocol:@protocol(MultiRowAnnotationProtocol)])
        return nil;
    NSObject <MultiRowAnnotationProtocol> *newAnnotation = (NSObject <MultiRowAnnotationProtocol> *)annotation;
    if (newAnnotation == self.calloutAnnotation) {
        MultiRowCalloutAnnotationView *annotationView = (MultiRowCalloutAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:MultiRowCalloutReuseIdentifier];
        if (!annotationView) {
            annotationView = [MultiRowCalloutAnnotationView calloutWithAnnotation:newAnnotation onCalloutAccessoryTapped:^(MultiRowCalloutCell *cell, UIControl *control, NSDictionary *userData) {
            }];
        }
        else
            annotationView.annotation = newAnnotation;
        annotationView.parentAnnotationView = self.selectedAnnotationView;
        annotationView.mapView = mapView;
        return annotationView;
    }
    GenericPinAnnotationView *annotationView = (GenericPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:GenericPinReuseIdentifier];
    if (!annotationView) {
        annotationView = [GenericPinAnnotationView pinViewWithAnnotation:newAnnotation];
    }
    annotationView.annotation = newAnnotation;
    return annotationView;
}
//放大地图 
-(void)fangDaDItu:(id<MKAnnotation>)aDic
{
	if (self.mMapView.region.span.latitudeDelta>0.1) {
		MKCoordinateRegion newRegion;
		newRegion.center.latitude = aDic.coordinate.latitude;
		newRegion.center.longitude = aDic.coordinate.longitude;//113.74768;
		newRegion.span.latitudeDelta = 0.1;
		newRegion.span.longitudeDelta = 0.1;	
		[self.mMapView setRegion:newRegion animated:YES];
	}
	
}


- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)aView {
	
    id<MKAnnotation> annotation = aView.annotation;
	[self fangDaDItu:annotation];
    if (!annotation || ![aView isSelected])
        return;
    if ( NO == [annotation isKindOfClass:[MultiRowCalloutCell class]] &&
        [annotation conformsToProtocol:@protocol(MultiRowAnnotationProtocol)] )
    {
        NSObject <MultiRowAnnotationProtocol> *pinAnnotation = (NSObject <MultiRowAnnotationProtocol> *)annotation;
        if (!self.calloutAnnotation) {
            _calloutAnnotation = [[MultiRowAnnotation alloc] init];
            [_calloutAnnotation copyAttributesFromAnnotation:pinAnnotation];
            [mapView addAnnotation:_calloutAnnotation];
        }
        self.selectedAnnotationView = aView;
        return;
    }
    [mapView setCenterCoordinate:annotation.coordinate animated:YES];
    self.selectedAnnotationView = aView;
}

- (void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)aView {
	

    if ( NO == [aView.annotation conformsToProtocol:@protocol(MultiRowAnnotationProtocol)] )
        return;
    if ([aView.annotation isKindOfClass:[MultiRowAnnotation class]])
        return;
	
    GenericPinAnnotationView *pinView = (GenericPinAnnotationView *)aView;
    if (self.calloutAnnotation && !pinView.preventSelectionChange) {
        [mapView removeAnnotation:_calloutAnnotation];
        self.calloutAnnotation = nil;
		return;
    }
        
		for (int i=0; i<self.gAllData.count; i++) {
            NSString *dx=[NSString stringWithFormat:@"%.2f",aView.annotation.coordinate.latitude];
            NSString *dy=[NSString stringWithFormat:@"%.2f",aView.annotation.coordinate.longitude];
            NSString *jingwei=[NSString stringWithFormat:@"%@|%@",dx,dy];
            NSString *str=[[self.gAllData objectAtIndex:i]objectForKey:@"mappoint"];
            NSArray *JWArray = [str componentsSeparatedByString:@"|"];
            NSString *da=[NSString stringWithFormat:@"%.2f",[[JWArray objectAtIndex:1] doubleValue]];
            NSString *db=[NSString stringWithFormat:@"%.2f",[[JWArray objectAtIndex:0] doubleValue]];
            NSString *JW=[NSString stringWithFormat:@"%@|%@",da,db];
            if ([jingwei isEqualToString:JW]) {
                NSString* str=[self.gAllData objectAtIndex:i];
                NSLog(@"111%@",str);
                
                GAgentDetailTableView *tGdetail = [[GAgentDetailTableView alloc]init];
                tGdetail.mGId = [[self.gAllData objectAtIndex:i]objectForKey:@"id"];
                [self.navigationController pushViewController:tGdetail animated:YES];
                [tGdetail release];
                return;
            }
        }

}

-(void)resignApp
{
	[self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}
-(void)dealloc
{
	self.gAllData = nil;
	self.calloutAnnotation = nil;
	self.selectedAnnotationView = nil;
	self.mMapView = nil;
	[anitionas release];
	self.mLocationManager = nil;
	self.mUserPoint = nil;
	[self releaseSoap];
	[super dealloc];
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
