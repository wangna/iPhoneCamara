//
//  MapViewController.h
//  JiaHuaLiCai
//
//  Created by chenhuiguo on 12-5-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Mapkit/Mapkit.h>
#import <CoreLocation/CoreLocation.h>
#import "SoapHttpManager.h"

@interface MapViewController : UIViewController
<MKMapViewDelegate,CLLocationManagerDelegate>
{
	CLLocationManager *_mLocationManager;
	CLLocation *_mUserPoint;
	MKMapView *mMapView;
    float Vheight;
}
@property(assign,nonatomic)BOOL ifSoap;
@property(retain,nonatomic)CLLocation *mUserPoint;
@property (retain,nonatomic)CLLocationManager *mLocationManager;
@property(retain,nonatomic)MKMapView *mMapView;
@property (nonatomic,retain)NSMutableArray *gAllData;
@end
