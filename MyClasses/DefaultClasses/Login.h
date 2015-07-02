//
//  Login.h
//  HealthCalendar
//
//  Created by hb hidden on 03/08/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AlertHandler.h"
#import "mplist.h"

@interface Login : UIViewController <UITextFieldDelegate,UIScrollViewDelegate>{
	mplist *Objplist;
	UIAlertView *objAlert;
	IBOutlet UITextField *txtUserName , *txtPassword;
	IBOutlet UIButton *btnLogin , *btnSignUp , *btnForgotPassword , *btnRemember;
	IBOutlet UILabel *lblTitle;
	NSString *nextPage , *sourceType;
	IBOutlet UITextField *txtEmail;
	int i;
	IBOutlet UIScrollView *scroll;
	IBOutlet UIView *ForgotUIView;
	IBOutlet UIActivityIndicatorView *activity_indi;

}
@property(nonatomic , retain) NSString *nextPage , *sourceType;
@property(nonatomic, retain)IBOutlet UIActivityIndicatorView *activity_indi;
-(IBAction)btnNewPublisherPressed:(id)sender;
-(IBAction)btnSubmitPressed:(id)sender;
-(IBAction) btnForgotPasswordPressed:(id)sender;
-(IBAction)btnCancelPressed:(id)sender;
-(IBAction)forgetPwdClicked:(id)sender;
-(void)submit_1;
@end
