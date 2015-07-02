//
//  CustomAlertView.h
//  App Idea Pro
//
//  Created by iMobDev Technologies on 09/09/09.
//  Copyright 2009 iMobDev Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#define OVALSCALEX 1.0
#define OVALSCALEY 70.0/425.0

@interface CustomAlertView : UIAlertView {

}
- (void) drawRoundedRect:(CGRect) rect 
          withBackground:(UIColor *) backgroundColor
               andBorder:(UIColor *) borderColor
               andRadius:(CGFloat) radius
			  andContext:(CGContextRef)cntxt;

@end
