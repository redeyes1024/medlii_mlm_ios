//
//  setting.m
//  Sentara
//
//  Created by H!dden Brains on 7/16/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "setting.h"
#import "AlertHandler.h"
#import "GoogleAnalyticsPlugin.h"

@implementation setting

@synthesize AutoLogin,AlertEmail;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	NSMutableDictionary *data = [[NSMutableDictionary alloc]init];
	[data setObject:[[HBAppDelegate getGlobalInfo] valueForKey:@"id"] forKey:@"user_id"];
	data = [[HBLib getArrayFromURL:@"User.asmx/SettingView":data]objectAtIndex:0];
	if([[data valueForKey:@"alerts_email"] isEqualToString:@"Off"])
	{
		AlertEmail.on = NO;
	}
	mplist *Objplist = [[mplist alloc]init];
	[Objplist mImportPlistSettings];
	[Objplist mReadPlistSettings];
	int temp = [Objplist.UserId intValue];
	if(temp > 0 ) 
	{
		AutoLogin.on = YES;
	}else
	{
		AutoLogin.on = NO;
	}
}

-(IBAction)ChangePassword:(id)sender{
	view_hidden.hidden = NO;
}
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

-(IBAction)EnableAutoLogin:(id)sender
{
	mplist *Objplist = [[mplist alloc]init];
	[Objplist mImportPlistSettings];
	if (AutoLogin.on) 
	{
		Objplist.UserId =[[HBAppDelegate getGlobalInfo] valueForKey:@"id"];
		Objplist.UserName = [[HBAppDelegate getGlobalInfo] valueForKey:@"username"];
		Objplist.Password = [[HBAppDelegate getGlobalInfo] valueForKey:@"password"];
	}
    else
	{
		Objplist.UserId =@"";
		Objplist.UserName = @"";
		Objplist.Password = @"";
	}
	[Objplist mWritePlistSettings];
}

-(IBAction)EnableAlertEmail:(id)sender
{
	if (AlertEmail.on) 
	{
		alerttxt.text = @"On";
	}
    else
	{
		alerttxt.text = @"Off";
	}
	NSLog(@"New pw is %@",alerttxt.text);
	NSMutableDictionary *data = [[NSMutableDictionary alloc]init];
	[data setObject:[[HBAppDelegate getGlobalInfo] valueForKey:@"id"] forKey:@"user_id"];
	[data setObject:alerttxt.text forKey:@"alerts_email"];
	[data setObject:oldpwd.text forKey:@"old_password"];
	[data setObject:newpwd.text forKey:@"new_password"];
	[data setObject:re_newpwd.text forKey:@"confirm_password"];
	data = [[HBLib getArrayFromURL:@"User.asmx/changepassword":data]objectAtIndex:0];
}
-(IBAction)HomeBtn:(id)sender
{
	[HBAppDelegate loadAppPage:@"Home_Back1" :(UINavigationController*)self.navigationController];
}

-(IBAction)LogOutBtn:(id)sender
{
	[[HBAppDelegate getGlobalInfo]setObject:@"1" forKey:@"flag"];
	[self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
}

-(IBAction)SaveBtn:(id)sender
{
	[oldpwd resignFirstResponder];
	[newpwd resignFirstResponder];
	[re_newpwd resignFirstResponder];
	NSMutableDictionary *data = [[NSMutableDictionary alloc]init];
	[data setObject:[[HBAppDelegate getGlobalInfo] valueForKey:@"id"] forKey:@"user_id"];
	[data setObject:oldpwd.text forKey:@"old_password"];
	[data setObject:newpwd.text forKey:@"new_password"];
	[data setObject:re_newpwd.text forKey:@"confirm_password"];
	[data setObject:alerttxt.text forKey:@"alerts_email"];
	data = [[HBLib getArrayFromURL:@"User.asmx/changepassword":data]objectAtIndex:0];
	[AlertHandler ShowMessageBoxWithTitle:@"Message" Message:[data valueForKey:@"message"] Button:@"Ok"];
	if([[data valueForKey:@"success"] isEqualToString:@"1"])
	{
		GoogleAnalyticsPlugin *obj1 = [[GoogleAnalyticsPlugin alloc]init];
		[data setObject:[NSString stringWithFormat:@"%@",[[HBAppDelegate getGlobalInfo] valueForKey:@"USERNAME"]] forKey:@"info"];
		[data setObject:@"Save button clicked" forKey:@"clicked"];
		[data setObject:[data valueForKey:@"message"] forKey:@"label"];
		[obj1 trackEvent:nil withDict: data];
		view_hidden.hidden = YES;
	}
}
-(IBAction)CancelButton:(id)sender{
	[oldpwd resignFirstResponder];
	[newpwd resignFirstResponder];
	[re_newpwd resignFirstResponder];
	view_hidden.hidden = YES;
}

- (BOOL)textFieldShouldReturn:(UITextField*)TextField
{
	[TextField resignFirstResponder];
	return YES;
}
- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
	
    if([textField isEqual:re_newpwd] || [textField isEqual:newpwd] || [textField isEqual:oldpwd])
    {
        scrollView.contentOffset=CGPointMake(0,100);
    }
    
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    scrollView.contentOffset=CGPointMake(0,0);
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
    return UIInterfaceOrientationIsPortrait(toInterfaceOrientation);
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
