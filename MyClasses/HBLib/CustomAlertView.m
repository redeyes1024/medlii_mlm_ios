//
//  CustomAlertView.m
//  App Idea Pro
//
//  Created by iMobDev Technologies on 09/09/09.
//  Copyright 2009 iMobDev Technologies. All rights reserved.
//

#import "CustomAlertView.h"


@implementation CustomAlertView


- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // Initialization code
		
    }
    return self;
}


- (void)drawRect:(CGRect)rect {
    // Drawing code
	CGContextRef context = UIGraphicsGetCurrentContext ();
	[self drawRoundedRect:rect withBackground:[UIColor blackColor] andBorder:[UIColor clearColor] andRadius:10.0  andContext:context];
}

- (void)didAddSubview:(UIView *)subview {
	if ([subview isMemberOfClass:[UIImageView class]]) {
		[subview removeFromSuperview];
	}
}


- (void) drawRoundedRect:(CGRect) rect 
          withBackground:(UIColor *) backgroundColor
               andBorder:(UIColor *) borderColor
               andRadius:(CGFloat) radius
			  andContext:(CGContextRef)cntxt
{
	CGContextRef context = cntxt;
	
	CGContextSaveGState (context);
	
	//Calculate rounded form
	CGMutablePathRef     roundedPath = CGPathCreateMutable ();
	
	CGPathMoveToPoint (roundedPath, NULL, CGRectGetMinX (rect) + radius, CGRectGetMinY (rect));
	CGPathAddArc (roundedPath, NULL, CGRectGetMaxX (rect)-radius, CGRectGetMinY (rect)+radius, radius, 3*M_PI/2, 0, 0);
	CGPathAddArc (roundedPath, NULL, CGRectGetMaxX (rect)-radius, CGRectGetMaxY (rect)-radius, radius, 0, M_PI/2, 0);
	CGPathAddArc (roundedPath, NULL, CGRectGetMinX (rect)+radius, CGRectGetMaxY (rect)-radius, radius, M_PI/2, M_PI, 0);
	CGPathAddArc (roundedPath, NULL, CGRectGetMinX (rect)+radius, CGRectGetMinY (rect)+radius, radius, M_PI, 3*M_PI/2, 0);     
	CGPathCloseSubpath (roundedPath);
	
	
	
	//If background defined, fill roundedPath and add some light effect from the top
	
	if (backgroundColor)
	{
		//Fill background
		CGContextSetFillColorWithColor (context, [backgroundColor CGColor]); 
		CGContextAddPath (context, roundedPath);
		CGContextFillPath (context);
		
		//Clip area
		CGContextAddPath (context, roundedPath);          
		CGContextClip (context);
		
		
		//     Draw elipse
		CGContextSetFillColorWithColor (context, [[[UIColor whiteColor] colorWithAlphaComponent:40.0/255.0] CGColor]);
		
		
		
		CGContextScaleCTM (context, OVALSCALEX, OVALSCALEY);
		CGContextAddArc (context, 
						 (rect.origin.x+rect.size.width/2.0)/OVALSCALEX,
						 (rect.origin.y+0.0)/OVALSCALEY,
						 rect.size.width/2.0*425.0/270.0, 
						 0.0, 2*M_PI, 1);
		CGContextFillPath (context);
		
		CGContextRestoreGState (context);     // Reset CTM
        CGContextSaveGState (context);          
	}
	
	if (borderColor)
	{
		CGContextSetStrokeColorWithColor (context, [borderColor CGColor]);
		CGContextSetLineWidth (context, 3.0);
		CGContextAddPath (context, roundedPath);
		CGContextStrokePath (context);
	}
	
	CFRelease (roundedPath);
	
	CGContextRestoreGState (context);
}


- (void)dealloc {
    [super dealloc];
}

@end
