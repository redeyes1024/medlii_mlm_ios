//
//  webpage.h
//  HBApp
//
//  Created by hb ipl on 07/03/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface webpage : UIViewController <UIWebViewDelegate> {

	IBOutlet UIWebView *webpageName;
	IBOutlet UIButton *back;
	IBOutlet UIActivityIndicatorView *actView;
	IBOutlet UILabel *lbl;
	
}
-(IBAction)btnBackPressed:(id)sender;
@end
