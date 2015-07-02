//
//  GoogleAnalyticsPlugin.m
//  MLM
//
//  Created by H!dden Brains on 1/5/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "GoogleAnalyticsPlugin.h"
static const NSInteger kGANDispatchPeriodSec = 10;
@implementation GoogleAnalyticsPlugin
- (void) startTrackerWithAccountID:(NSMutableArray*)arguments withDict:(NSMutableDictionary*)options
{
	[[GANTracker sharedTracker] startTrackerWithAccountID:@"UA-25672706-3"
										   dispatchPeriod:kGANDispatchPeriodSec
												 delegate:self];
	[self trackEvent:nil withDict:nil];
	[self trackPageview:nil withDict:nil];
	[[GANTracker sharedTracker] dispatch];
}
- (void) trackEvent:(NSMutableArray*)arguments withDict:(NSMutableDictionary*)options
{
	NSString* category = [options valueForKey:@"info"];
	NSString* action = [options valueForKey:@"clicked"];
	NSString* label = [NSString stringWithFormat:@"%@----%@----%@",[[HBAppDelegate getGlobalInfo]valueForKey:@"CompanyInfo"],[[HBAppDelegate getGlobalInfo]valueForKey:@"GroupInfo"],[options valueForKey:@"label"]];;
	label = [[[UIDevice currentDevice] uniqueIdentifier] stringByAppendingFormat:@":%@",label];
	int value = 1;
	NSError *error;
	if (![[GANTracker sharedTracker] trackEvent:category
										 action:action
										  label:label
										  value:value
									  withError:&error]) {
		NSLog(@"GoogleAnalyticsPlugin.trackEvent Error::",[error localizedDescription]);
	}
	NSLog(@"GoogleAnalyticsPlugin.trackEvent::%@, %@, %@, %d",category,action,label,value);
}

- (void) trackPageview:(NSMutableArray*)arguments withDict:(NSMutableDictionary*)options
{
	NSError *error;
	if (![[GANTracker sharedTracker] trackPageview:@"/app_launched"
										 withError:&error]) {
		NSLog(@"GoogleAnalyticsPlugin.trackEvent Error::",[error localizedDescription]);
	}
}

-(void)trackerDispatchDidComplete:(GANTracker *)tracker eventsDispatched:(NSUInteger)eventsDispatched eventsFailedDispatch:(NSUInteger)eventsFailedDispatch
{
	//The delegate method only gets called once at launch
	//NSString* callback = [NSString stringWithFormat:@"window.plugins.googleAnalyticsPlugin.trackerDispatchDidComplete(%d);",eventsDispatched];
	NSLog(@"Google Analytics: Events Dispatched = %i | Events Failed Dispatched = %i", eventsDispatched, eventsFailedDispatch);
}

- (void) dealloc
{
	[[GANTracker sharedTracker] stopTracker];
	[ super dealloc ];
}


@end
