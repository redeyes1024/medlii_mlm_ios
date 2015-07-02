//
//  GoogleMap.m
//  PickImageControl
//
//  Created by HB17 on 8/14/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "GoogleMap.h"
#import "DisplayMap.h"

@implementation GoogleMap
@synthesize  mapView,StrTitle,StrSubTitle,StrLatitude,StrLongitude; 

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	//Display Map Attributes.
	[mapView setMapType:MKMapTypeStandard];
	[mapView setZoomEnabled:YES];
	[mapView setScrollEnabled:YES];
	MKCoordinateRegion region = { {0.0, 0.0 }, { 0.0, 0.0 } }; 
	region.center.latitude = [StrLatitude floatValue];  //22.569722 ;
	region.center.longitude = [StrLongitude floatValue];//88.369722;
	region.span.longitudeDelta = 0.01f;
	region.span.latitudeDelta = 0.01f;
	[mapView setRegion:region animated:YES]; 
	
	[mapView setDelegate:self];
	
	
	//Displaying Pin Attributes.
	DisplayMap *ann = [[DisplayMap alloc] init]; 
	ann.title =StrTitle;
	ann.subtitle = StrSubTitle; 
	ann.coordinate = region.center; 
	[mapView addAnnotation:ann];
	
	//Displaying Segment Buttons 
	buttonBarSegmentedControl = [[UISegmentedControl alloc] initWithItems:
								 [NSArray arrayWithObjects:@"Standard", @"Satellite", @"Hybrid", nil]];
	[buttonBarSegmentedControl setFrame:CGRectMake(30, 10, 280-30, 30)];
	buttonBarSegmentedControl.selectedSegmentIndex = 0.0;	// start by showing the normal picker
	[buttonBarSegmentedControl addTarget:self action:@selector(toggleToolBarChange:) forControlEvents:UIControlEventValueChanged];
	buttonBarSegmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;
	buttonBarSegmentedControl.tintColor=[UIColor blackColor];
	buttonBarSegmentedControl.backgroundColor = [UIColor clearColor];
	[buttonBarSegmentedControl setAlpha:0.8];
	
	[self.view addSubview:buttonBarSegmentedControl]; 
}
 
-(MKAnnotationView *)mapView:(MKMapView *)mV viewForAnnotation:
(id <MKAnnotation>)annotation {
	MKPinAnnotationView *pinView = nil; 
	if(annotation != mapView.userLocation) 
	{
		static NSString *defaultPinID = @"com.hiddenbrains.pin";
		pinView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:defaultPinID];
		if ( pinView == nil ) pinView = [[[MKPinAnnotationView alloc]
										  initWithAnnotation:annotation reuseIdentifier:defaultPinID] autorelease];
		
		pinView.pinColor = MKPinAnnotationColorRed; 
		pinView.canShowCallout = YES;
		pinView.animatesDrop = YES;
	} 
	else {
		[mapView.userLocation setTitle:@"I am here"];
	}
	return pinView;
}

- (void)toggleToolBarChange:(id)sender  
{  
    UISegmentedControl *segControl = sender;  
	
    switch (segControl.selectedSegmentIndex)  
    {  
        case 0: // Map  
        {  
            [mapView setMapType:MKMapTypeStandard];  
            break;  
        }  
        case 1: // Satellite  
        {  
            [mapView setMapType:MKMapTypeSatellite];  
            break;  
        }  
        case 2: // Hybrid  
        {  
            [mapView setMapType:MKMapTypeHybrid];  
            break;  
        }  
    }  
} 

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

-(IBAction) btnBackPressed:(id) sender{
	[self.navigationController popViewControllerAnimated:YES];
}


- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
