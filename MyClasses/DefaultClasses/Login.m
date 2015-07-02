//
//  Login.m
//  HealthCalendar
//
//  Created by hb hidden on 03/08/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Login.h"

//#import "NewPublisher.h"
#import "HBList.h"
#import "HBAppDelegate.h"
#import "GoogleAnalyticsPlugin.h"
@implementation Login
@synthesize nextPage , sourceType, activity_indi;
int j=0;
UIActivityIndicatorView *activity;
/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
 - (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
 if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
 // Custom initialization
 }
 return self;
 }
 */


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	txtUserName.autocorrectionType = UITextAutocorrectionTypeNo;
	
	
	activity_indi.hidden = YES;
	
	Objplist = [[mplist alloc]init];
	[Objplist mImportPlistSettings];
	[Objplist mReadPlistSettings];
	int temp = [Objplist.UserId intValue];
	if(temp > 0 ) {
		if([Objplist.UserName length] >0 && [Objplist.Password length] > 0){
			txtUserName.text =  Objplist.UserName;
			txtPassword.text  = Objplist.Password ;
			[self btnSubmitPressed:@""];
		} 
	}
	
//---Prop_Owner--//
	txtUserName.text = @"robin@gmail.com";
	txtPassword.text = @"robin";	
	
}
-(void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:YES];
	activity_indi.hidden = YES;
	[activity_indi stopAnimating];
}

/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 
 */


-(IBAction) btnForgotPasswordPressed:(id)sender { 
	
	[txtUserName resignFirstResponder];
	[txtPassword resignFirstResponder];
	ForgotUIView.hidden=NO;
	lblTitle.hidden = FALSE;
	txtEmail.text=@"";
	
}

-(IBAction)btnCancelPressed:(id)sender{
	[txtEmail resignFirstResponder];
	ForgotUIView.hidden=YES;
	lblTitle.hidden = FALSE;
}


-(IBAction)forgetPwdClicked:(id)sender{

	NSString *email = txtEmail.text;
	NSString *emailRegEx =@"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
	NSPredicate *regExPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
	BOOL myStringMatchesRegEx = [regExPredicate evaluateWithObject:email];
	
	
	if ( [txtEmail.text length] == 0 ) {
		[AlertHandler ShowMessageBoxWithTitle:@"Error" Message:@"Please enter e-mail" Button:@"Ok"];
		[txtEmail becomeFirstResponder];
		return;
	}else if(!myStringMatchesRegEx){
		[AlertHandler ShowMessageBoxWithTitle:@"Error" Message:@"Please enter valid e-mail" Button:@"OK"];
		[txtEmail becomeFirstResponder];
		return;
	}
	[txtEmail resignFirstResponder];
	NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
	[data setObject:txtEmail.text forKey:@"email"];
	NSMutableArray *response_arr = [[NSMutableArray alloc] init];
	response_arr = [HBLib getArrayFromURL:@"User.asmx/ForgotPassword" :data];
	if ( [[[response_arr objectAtIndex:0] valueForKey:@"success"] intValue] == 1 ) {
		[objAlert dismissWithClickedButtonIndex:2 animated:YES];
		[AlertHandler ShowMessageBoxWithTitle:@"Success" Message:[[response_arr objectAtIndex:0] valueForKey:@"message"] Button:@"Ok"];
	    ForgotUIView.hidden=YES;
		lblTitle.hidden = FALSE;
		
	}  else {
		[AlertHandler ShowMessageBoxWithTitle:@"Error" Message:[[response_arr objectAtIndex:0] valueForKey:@"message"] Button:@"Ok"];
	}
	return;
}


-(IBAction)btnNewPublisherPressed:(id)sender
{
	[txtUserName resignFirstResponder];
	[txtPassword resignFirstResponder];
	activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
	activity.frame = CGRectMake(145, 225, 30, 30);
	[activity setHidesWhenStopped:YES];
	UIView *view = self.navigationController.view;
	[view addSubview:activity];
	[activity startAnimating];
	[HBAppDelegate loadAppPage:@"Registration" :self.navigationController];
	[activity stopAnimating];
	
}

-(void) submitPage
{
	
}
-(IBAction)btnSubmitPressed:(id)sender{
	if([Objplist.UserName length] >0 && [Objplist.Password length] > 0){
		[self submit_1];
	} else {
		[activity_indi startAnimating];
		[self performSelector:@selector(submit_1) withObject:nil afterDelay:0.1];
	}
}
-(void)submit_1{	

	[txtUserName resignFirstResponder];
	[txtPassword resignFirstResponder];
	NSString *email = txtUserName.text;
	NSString *emailRegEx =@"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
	NSPredicate *regExPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
	BOOL myStringMatchesRegEx = [regExPredicate evaluateWithObject:email];
	
	if ( [txtUserName.text isEqualToString:@""] ) {
		[AlertHandler ShowMessageBoxWithTitle:@"Error" Message:@"Please enter Email Address" Button:@"OK"];
		[activity_indi stopAnimating];
	}else if(!myStringMatchesRegEx){
		[AlertHandler ShowMessageBoxWithTitle:@"Error" Message:@"Please enter valid Email Address" Button:@"OK"];
		[activity_indi stopAnimating];
	}else if ( [txtPassword.text isEqualToString:@""] ) {
		[AlertHandler ShowMessageBoxWithTitle:@"Error" Message:@"Please enter Password" Button:@"OK"];
		[activity_indi stopAnimating];
	}else{
		NSMutableDictionary *login_info = [[NSMutableDictionary alloc] init];
		[login_info setObject:txtUserName.text forKey:@"email"];
		[login_info setObject:txtPassword.text forKey:@"password"];
		NSMutableArray *loginResponse = [[NSMutableArray alloc] init];
		if ( [sourceType isEqualToString:@"Local"] ) {
			loginResponse = [HBLib getArrayFromURL:@"login":login_info];
		} else {
			loginResponse = [HBLib getArrayFromURL:@"User.asmx/Login":login_info];
		}
		if([loginResponse count] == 0){
			
			
			NSString *msg = [HBAppDelegate getLocalvalue:@"You are not connected to Internet, so please check your Internet Connection." ];
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[HBAppDelegate getLocalvalue:@"Network Problem"]
															message:msg 
														   delegate:nil 
												  cancelButtonTitle:[HBAppDelegate getLocalvalue:@"OK"]
												  otherButtonTitles:nil];
			[alert show];
			[alert release];
			[activity_indi stopAnimating];
			
		}else{	
			
			if ( [[[loginResponse objectAtIndex:0] objectForKey:@"success"] intValue] == 1) 
			{
				[[HBAppDelegate getGlobalInfo] setObject:[[loginResponse objectAtIndex:0] objectForKey:@"user_id"] forKey:@"id"];
				[[HBAppDelegate getGlobalInfo] setObject:[[loginResponse objectAtIndex:0] objectForKey:@"group_id"] forKey:@"group_id"];
				[[HBAppDelegate getGlobalInfo] setObject:[[loginResponse objectAtIndex:0] valueForKey:@"vEmail"] forKey:@"username"];
				[[HBAppDelegate getGlobalInfo] setObject:[[loginResponse objectAtIndex:0] valueForKey:@"vPassword"] forKey:@"password"];
				[[HBAppDelegate getGlobalInfo] setObject:txtUserName.text forKey:@"USERNAME"];
				
				NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
				GoogleAnalyticsPlugin *obj1 = [[GoogleAnalyticsPlugin alloc]init];
				[[HBAppDelegate getGlobalInfo]setObject:[NSString stringWithFormat:@"%@----%@",[[loginResponse objectAtIndex:0]valueForKey:@"company_id"],[[loginResponse objectAtIndex:0]valueForKey:@"company_name"]] forKey:@"CompanyInfo"];
				[[HBAppDelegate getGlobalInfo]setObject:[NSString stringWithFormat:@"%@----%@",[[loginResponse objectAtIndex:0]valueForKey:@"group_id"],[[loginResponse objectAtIndex:0]valueForKey:@"group_name"]]forKey:@"GroupInfo"];
				[data setObject:txtUserName.text forKey:@"info"];
				[data setObject:@"Login button clicked" forKey:@"clicked"];
				[data setObject:txtUserName.text forKey:@"label"];
				[obj1 trackEvent:nil withDict: data];
				[HBAppDelegate loadAppPage:@"Home" :self.navigationController];
			}
			else 
			{
				[AlertHandler ShowMessageBoxWithTitle:@"Error" Message:[[loginResponse objectAtIndex:0] valueForKey:@"message"]  Button:@"OK"];
				[activity_indi stopAnimating];
			}
		}	
		
	}	
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
	if (UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPad) 
	{
		if([textField isEqual:txtUserName] || [textField isEqual:txtPassword])
		{
			scroll.contentOffset=CGPointMake(0,185);
		}else if([textField isEqual:txtEmail])
		{
			scroll.contentOffset=CGPointMake(0,140);
		}
	}
    
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    scroll.contentOffset=CGPointMake(0,0);
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
	[txtEmail resignFirstResponder];
	[textField resignFirstResponder];
	return YES;
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
    return UIInterfaceOrientationIsPortrait(toInterfaceOrientation);
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
