//
//  setting.h
//  Sentara
//
//  Created by H!dden Brains on 7/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "mplist.h"

@interface setting : UIViewController <UITextFieldDelegate>{
	
	IBOutlet UITextField *oldpwd, *newpwd, *re_newpwd,*autotxt,*alerttxt;
	IBOutlet UIButton *HomeBtn,*LogOutBtn,*SaveBtn;
	IBOutlet UISwitch *AutoLogin;  
    IBOutlet UISwitch *AlertEmail; 
	IBOutlet UIScrollView *scrollView;
	IBOutlet UIView *view_hidden;
	//mplist *Objplist;
}
@property (nonatomic, retain) UISwitch *AutoLogin;  
@property (nonatomic, retain) UISwitch *AlertEmail;  
-(IBAction)CancelButton:(id)sender;
-(IBAction)ChangePassword:(id)sender;
-(IBAction)HomeBtn:(id)sender;
-(IBAction)LogOutBtn:(id)sender;
-(IBAction)SaveBtn:(id)sender;
-(IBAction)EnableAutoLogin:(id)sender;
-(IBAction)EnableAlertEmail:(id)sender;
@end
