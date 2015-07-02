//
//  HBAppDb.h
//  Health
//
//  Created by hbipl on 14/08/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface HBAppDb : UIViewController {

}
+(NSMutableArray *) getData : (NSString *) actionType : (NSMutableDictionary *) data;
@end
