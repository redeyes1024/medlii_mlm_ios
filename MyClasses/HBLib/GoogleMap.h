//
//  GoogleMap.h
//  PickImageControl
//
//  Created by HB17 on 8/14/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@class DisplayMap;

@interface GoogleMap : UIViewController<MKMapViewDelegate> {

	IBOutlet MKMapView *mapView;
	NSString *StrTitle,*StrSubTitle,*StrLatitude,*StrLongitude;
	UISegmentedControl *buttonBarSegmentedControl; 
	
}

-(IBAction)btnBackPressed:(id) sender;

@property (nonatomic, retain) IBOutlet MKMapView *mapView;
@property (nonatomic, retain) NSString *StrTitle;
@property (nonatomic, retain) NSString *StrSubTitle;
@property (nonatomic, retain) NSString *StrLatitude;
@property (nonatomic, retain) NSString *StrLongitude;

@end
