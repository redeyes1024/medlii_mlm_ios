//
//  GoogleAnalyticsPlugin.h
//  MLM
//
//  Created by H!dden Brains on 1/5/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GANTracker.h"

@interface GoogleAnalyticsPlugin : NSObject<GANTrackerDelegate> {
}
- (void) startTrackerWithAccountID:(NSMutableArray*)arguments withDict:(NSMutableDictionary*)options;
- (void) trackEvent:(NSMutableArray*)arguments withDict:(NSMutableDictionary*)options;
- (void) trackPageview:(NSMutableArray*)arguments withDict:(NSMutableDictionary*)options;
@end
