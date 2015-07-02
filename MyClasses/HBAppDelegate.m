#import "HBAppDelegate.h"
#import "Login.h"
#import "HBList.h"
#import <sqlite3.h>
#import "DBOperation.h"
#import "HBAppDb.h"
#import "AlertHandler.h"
#import "setting.h"
#import "webpage.h"
#import "CustomMoviePlayerViewController.h"
#import "iPhoneStreamingPlayerViewController.h"
#import "GANTracker.h"
#import "GoogleAnalyticsPlugin.h"
#import "MasterInherite.h"

int rundone =1;
@interface HBMaster (customHBMaster)

@end

@implementation HBMaster (customHBMaster)

-(void) getFailourResponseCall : (NSString *) tmp_string 
{
	[libobj hideAlert];
	UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Failure!!" message:@"Sorry, We could not get proper Data from server.\nPlease try again." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
	[alert show];
	[alert release];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if (buttonIndex == 0)
	{
		[self.navigationController popViewControllerAnimated:YES];
	}
}


-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
    return UIInterfaceOrientationIsPortrait(toInterfaceOrientation);
}
//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
//{
//	 return (interfaceOrientation == UIInterfaceOrientationPortrait);
//}

@end

@interface HBList (categoryHBList)

@end

@implementation HBList (cateoryHBList)

-(void) getFailourResponseCall : (NSString *) tmp_string 
{
	[libobj hideAlert];
	UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Failure!!" message:@"Sorry, We could not get proper Data from server.\nPlease try again." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];
	[alert show];
	[alert release];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if (buttonIndex == 0)
	{
		[self.navigationController popViewControllerAnimated:YES];
	}
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.0f;
    
}


-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
    return UIInterfaceOrientationIsPortrait(toInterfaceOrientation);
}
//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation 
//{
//	return (interfaceOrientation == UIInterfaceOrientationPortrait);
//}

@end

@interface HBForm (categoryHBForm)

@end

@implementation HBForm (cateoryHBForm)
-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
    return UIInterfaceOrientationIsPortrait(toInterfaceOrientation);
}
@end

@interface HBLib (customHBLib)

+(void)showAlertForProcesswithMessege:(NSString*)imessege;
+(void)hideAlert ;

@end

@implementation HBLib (customHBLib)

+(void)showAlertForProcesswithMessege:(NSString*)imessege
{
    [HBAppDelegate ShowAlert];
}

+(void)hideAlert 
{
    [HBAppDelegate hideAlertcat];
}

@end

static const NSInteger kGANDispatchPeriodSec = 10;
@implementation HBAppDelegate
UIActivityIndicatorView *activity;
UIView *loadingView;
UINavigationController *nav;
NSMutableDictionary *globalInfo;
static NSBundle *myLocalizedBundle;
static NSString *current_lang , *default_lang;
@synthesize window;
@synthesize navigationController;
@synthesize downloadQueue;


#pragma mark -
#pragma mark Application lifecycle

-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{    
    
	GoogleAnalyticsPlugin *obj1 = [[GoogleAnalyticsPlugin alloc]init];
	[obj1 startTrackerWithAccountID:nil withDict:nil];

	
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) 
	{
		[navigationController.view setFrame:CGRectMake(0, 0, 768, 1024)];
		[window addSubview:navigationController.view];
	}
	else
	{
		[window addSubview:navigationController.view];
	}
	
    [window makeKeyAndVisible];
	//Chagne below url to change the base url of the Web Service
	[HBLib setBaseURL:@"http://mlm.hospitalu.com/iphone/"];

	globalInfo=[[NSMutableDictionary alloc]init];
	[globalInfo setValue:@"Yes" forKey:@"cache_images"];
	[globalInfo setValue:@"Yes" forKey:@"local_nonet"];
	
	downloadQueue = [[NSOperationQueue alloc] init];
	Reachability *reachManager = [Reachability sharedReachability];
    [reachManager setHostName:@"www.apple.com"];
    NetworkStatus remoteHostStatus = [reachManager remoteHostStatus];
    if (remoteHostStatus == NotReachable)
    {
        [[NSNotificationCenter defaultCenter] removeObserver:self];
        NSString *msg = @"You are not connected to internet! Please check your internet connection.";
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Network Problem" 
                                                        message:msg 
                                                       delegate:nil 
                                              cancelButtonTitle:@"OK" 
                                              otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
    else if (remoteHostStatus == ReachableViaWiFiNetwork)
    {
        [self.downloadQueue setMaxConcurrentOperationCount:4];
    }
    else if (remoteHostStatus == ReachableViaCarrierDataNetwork)
    {
        [self.downloadQueue setMaxConcurrentOperationCount:NSOperationQueueDefaultMaxConcurrentOperationCount];
    }
	
	[globalInfo setValue:@"CheckingInProgress" forKey:@"internet_connected"];
	[globalInfo setValue:@"500" forKey:@"image_scaling"];
	[[HBAppDelegate getGlobalInfo] setObject:@"YES" forKey:@"orientation_enabled"];
	[globalInfo setValue:@"Yes" forKey:@"cache_images"];
	NSString *is_ipad = @"No";
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
	{
		is_ipad = @"Yes";
	} 
	[globalInfo setObject:is_ipad forKey:@"is_ipad"];
	default_lang = @"en";
	current_lang = @"en";
	[HBAppDelegate GetLangKey:current_lang];
    return YES;
}

+(NSMutableDictionary *)getGlobalInfo
{
	return globalInfo;
}

+(void)maketransparentwebview:(HBMaster *)MObj
{
    for (id tmpview in MObj.view.subviews) 
	{
        if ([tmpview isKindOfClass:[UIWebView class]]) 
		{
            UIWebView *tmp = (UIWebView *)tmpview;
            [tmp setBackgroundColor:[UIColor clearColor]];
            [tmp setOpaque:NO];
            tmp.dataDetectorTypes = UIDataDetectorTypeNone;
		
        }
    }
}
+(void)maketransparentwebview_for_searchpage:(HBMaster *)MObj
{
    for (id tmpview in MObj.view.subviews) 
	{
        if ([tmpview isKindOfClass:[UIWebView class]]) 
		{
            UIWebView *tmp = (UIWebView *)tmpview;
            [tmp setBackgroundColor:[UIColor clearColor]];
            [tmp setOpaque:NO];
            tmp.dataDetectorTypes = UIDataDetectorTypeNone;
			for(UIView *wview in [[[tmp subviews] objectAtIndex:0] subviews]) { 
				if([wview isKindOfClass:[UIImageView class]]) { wview.hidden = YES; } 
			} 
        }
    }
}

+(void)maketransparentwebviewforcoursedetail:(HBMaster *)MObj
{
    for (id tmpview in MObj.view.subviews) 
	{
        if ([tmpview isKindOfClass:[UIWebView class]]) 
		{
            UIWebView *tmp = (UIWebView *)tmpview;
            [tmp setBackgroundColor:[UIColor clearColor]];
            [tmp setOpaque:NO];
			tmp.scalesPageToFit=YES;
            tmp.dataDetectorTypes = UIDataDetectorTypeNone;
        }
    }
}




+(void) loadAppPage : (NSString *) className : (UINavigationController *) navController 
{
	//NSLog(@"\n==========\n%@\n==========\n",className);
	if ( [className length] == 0 ) 
	{
			className = @"Login";
	}
	
	Reachability *reachManager = [Reachability sharedReachability];
    [reachManager setHostName:@"www.apple.com"];
    NetworkStatus remoteHostStatus = [reachManager internetConnectionStatus];
	
    if (remoteHostStatus == NotReachable  && ![className isEqualToString:@"Login"]) {
		
        [[NSNotificationCenter defaultCenter] removeObserver:self];
		
		NSString *msg = [HBAppDelegate getLocalvalue:@"You are not connected to Internet, so please check your Internet Connection." ];
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[HBAppDelegate getLocalvalue:@"Network Problem"]
                                                        message:msg 
                                                       delegate:nil 
                                              cancelButtonTitle:[HBAppDelegate getLocalvalue:@"OK"]
                                              otherButtonTitles:nil];
        [alert show];
        [alert release];
        return  ;
    }
	
	if ( [className isEqualToString:@"Login"] )
	{
		Login *obj = [[Login alloc] initWithNibName:[HBAppDelegate getNibFileName:@"Login"] bundle:nil];
		[navController pushViewController:obj animated:YES];	
	}
	else if ([className isEqualToString:@"Home"])
	{
			
		[[HBAppDelegate getGlobalInfo]setObject:@"0" forKey:@"flag"];
		HBMaster *obj=[[HBMaster alloc]initWithNibName:[HBAppDelegate getNibFileName:@"HBMaster"] bundle:nil];
		obj.sourceType=@"Online";
		obj.sourceFile=@"";
		obj.pListFile=[HBAppDelegate getPlistFileName:@"Home.plist"];
		[navController pushViewController:obj animated:YES];
		
	}
	else if ([className isEqualToString:@"Directry"]) 
	{
		 
		[HBAppDelegate ShowAlert];
		HBList *obj_list=[[HBList alloc]initWithNibName:[HBAppDelegate getNibFileName:@"Directory"] bundle:nil];
		obj_list.sourceType=@"Online";
		obj_list.sourceFile=@"Directories.asmx/DirectoryList";
		obj_list.cacheInterval=@"0";
		obj_list.pListFile=[HBAppDelegate getPlistFileName:@"screen4.plist"];
		NSMutableDictionary *tmpOtherPageSettings = [[NSMutableDictionary alloc] init];
		[tmpOtherPageSettings setObject:@"Yes" forKey:@"load_more_image"];
		if ([[[HBAppDelegate getGlobalInfo] valueForKey:@"is_ipad"]isEqualToString:@"Yes"]) 
		{
			[tmpOtherPageSettings setObject:@"strip_middel_s4_ipad.png" forKey:@"list_background"];
			[tmpOtherPageSettings setObject:@"strip_middel_s4_h_ipad.png" forKey:@"selected_background"];
			[tmpOtherPageSettings setObject:@"100" forKey:@"cell_height"];
		}
		else 
		{
			[tmpOtherPageSettings setObject:@"strip_middel_s4.png" forKey:@"list_background"];
			[tmpOtherPageSettings setObject:@"strip_middel_s4_h.png" forKey:@"selected_background"];
			[tmpOtherPageSettings setObject:@"70" forKey:@"cell_height"];
		}
		[tmpOtherPageSettings setObject:@"member_email" forKey:@"search_field"];	
		obj_list.otherPageSettings = tmpOtherPageSettings;
		[tmpOtherPageSettings release];
		NSMutableDictionary *param=[[NSMutableDictionary alloc]init];
		[param setObject:[[HBAppDelegate getGlobalInfo] valueForKey:@"group_id"] forKey:@"group_id"];
		obj_list.sourceParams=param;
		[navController pushViewController:obj_list animated:YES];
		[HBAppDelegate hideAlertclass];
	}
	else if([className isEqualToString:@"SendEmail"])
	{
		if ([MFMailComposeViewController canSendMail])
		{
			MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
			picker.mailComposeDelegate = self;
			picker.navigationBar.barStyle = UIBarStyleBlack;
			picker.navigationBar.alpha = 0.8 ;
			NSMutableDictionary *PData = [[HBAppDelegate getGlobalInfo] valueForKey:@"tmp_page_data"];
			NSArray *arr = [[NSArray alloc] initWithObjects:[NSString stringWithFormat:@"%@",[PData valueForKey:@"email"]],nil];
			[picker setToRecipients:arr];
			[((HBAppDelegate *)[[UIApplication sharedApplication]delegate]).navigationController presentModalViewController:picker animated:YES];
		}else
		{
			[AlertHandler ShowMessageBoxWithTitle:@"Message" Message:@"Sorry, unable to send email.\nPlease check email setting in your device." Button:@"Ok"];
		}
		
	}else if([className isEqualToString:@"CallToNumber"])
	{
		NSMutableDictionary *PData = [[HBAppDelegate getGlobalInfo] valueForKey:@"tmp_page_data"];
		NSURL *rl=[[NSURL alloc]initWithString:[NSString stringWithFormat:@"tel:%@",[PData valueForKey:@"contact_no"]]];
		[[UIApplication sharedApplication]openURL:rl];
		
		GoogleAnalyticsPlugin *obj1 = [[GoogleAnalyticsPlugin alloc]init];
		[PData setObject:[NSString stringWithFormat:@"%@",[[HBAppDelegate getGlobalInfo] valueForKey:@"USERNAME"]] forKey:@"info"];
		[PData setObject:@"Number clicked" forKey:@"clicked"];
		[PData setObject:[PData valueForKey:@"contact_no"] forKey:@"label"];
		[obj1 trackEvent:nil withDict:PData];

	}
	else if ([className isEqualToString:@"Home_Back"]) 
	{
		HBList *obj = ([navController.viewControllers objectAtIndex:([navController.viewControllers count]-1)]);
        for(id tmpObj in obj.view.subviews) 
		{
            if([tmpObj isKindOfClass:[UIButton class]])
			{
                UIButton *btnObj = (UIButton *)tmpObj;
                int btn_tag = btnObj.tag;
                if ( btn_tag == 20000 )
				{
					if ([[[HBAppDelegate getGlobalInfo] valueForKey:@"is_ipad"]isEqualToString:@"Yes"]) 
					{
						[btnObj setBackgroundImage:[UIImage imageNamed:@"btn_home_h_ipad.png"] forState:UIControlStateNormal];
						
					}
					else 
					{
						[btnObj setBackgroundImage:[UIImage imageNamed:@"btn_home_h.png"] forState:UIControlStateNormal];
					}
				}
            }
        }		
		[NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(changeimage:) userInfo:nil repeats:NO];
	}
	else if ([className isEqualToString:@"Home_Back1"]) 
	{
		HBMaster *obj = ([navController.viewControllers objectAtIndex:([navController.viewControllers count]-2)]);
		for(id tmpObj in obj.view.subviews) 
		{
			if([tmpObj isKindOfClass:[UIButton class]])
			{
				UIButton *btnObj = (UIButton *)tmpObj;
				int btn_tag = btnObj.tag;
				if ( btn_tag == 0 )
				{
					if ([[[HBAppDelegate getGlobalInfo] valueForKey:@"is_ipad"]isEqualToString:@"Yes"]) 
					{
						[btnObj setBackgroundImage:[UIImage imageNamed:@"btn_setting_ipad.png"] forState:UIControlStateNormal];
					}
					else
					{
						[btnObj setBackgroundImage:[UIImage imageNamed:@"btn_setting.png"] forState:UIControlStateNormal];
					}
				}
			}
		}
		[NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(changeimage:) userInfo:nil repeats:NO];
	}
	else if ([className isEqualToString:@"Events"])
	{
		HBList *obj_list=[[HBList alloc]initWithNibName:[HBAppDelegate getNibFileName:@"HBList"] bundle:nil];
		obj_list.sourceType=@"Online";
		obj_list.sourceFile=@"Directories.asmx/EventList";
		obj_list.cacheInterval=@"0";
		obj_list.pListFile=[HBAppDelegate getPlistFileName:@"Events.plist"];
		NSMutableDictionary *tmpOtherPageSettings = [[NSMutableDictionary alloc] init];
		[tmpOtherPageSettings setObject:@"Yes" forKey:@"load_more_image"];
		if ([[[HBAppDelegate getGlobalInfo] valueForKey:@"is_ipad"]isEqualToString:@"Yes"]) 
		{
			[tmpOtherPageSettings setObject:@"strip_middel_ipad.png" forKey:@"list_background"];
			[tmpOtherPageSettings setObject:@"strip_middel_h_ipad.png" forKey:@"selected_background"];
			[tmpOtherPageSettings setObject:@"71" forKey:@"cell_height"];
		}
		else 
		{
			[tmpOtherPageSettings setObject:@"strip_middel.png" forKey:@"list_background"];
			[tmpOtherPageSettings setObject:@"strip_middel_h.png" forKey:@"selected_background"];
			[tmpOtherPageSettings setObject:@"50" forKey:@"cell_height"];
		}
		obj_list.otherPageSettings = tmpOtherPageSettings;
		[tmpOtherPageSettings release];
		NSMutableDictionary *param=[[NSMutableDictionary alloc]init];
		[param setObject:[[HBAppDelegate getGlobalInfo] valueForKey:@"group_id"] forKey:@"group_id"];
		obj_list.sourceParams=param;
		[navController pushViewController:obj_list animated:YES];
	}
	else if([className isEqualToString:@"Registration"])
	{		
		HBForm *obj = [[HBForm alloc] initWithNibName:[HBAppDelegate getNibFileName:@"HBForm"] bundle:nil];
		obj.sourceType = @"Online";
		obj.actionFile=@"";
		
		NSMutableArray *tmp_form_vars = [[NSMutableArray alloc] init];
		NSMutableDictionary *elements = [[NSMutableDictionary alloc] init];
		[elements setObject:@"company_id" forKey:@"element_id"];
		[elements setObject:@"Others.asmx/CompanyDropDown" forKey:@"sourceURL"];
		[elements setObject:@"group_id" forKey:@"changeSource"];
		[tmp_form_vars addObject:elements];
		[elements release];
		
		NSMutableDictionary *element_details1 = [[NSMutableDictionary alloc] init];
		[element_details1 setObject:@"group_id" forKey:@"element_id"];
		[element_details1 setObject:@"Others.asmx/GroupDropDown" forKey:@"sourceURL"];
		[tmp_form_vars addObject:element_details1];
		[element_details1 release];
		
		NSLog(@"temp:--%@",tmp_form_vars);
		obj.htmlForm = [HBAppDelegate getHTMLFileName:@"screen2a"];
		obj.formSelectVars = tmp_form_vars;
		obj.nextPage = @"registration_submit";
	    [navController pushViewController:obj animated:YES];
		
	}else if ([className isEqualToString:@"Backpage"]) 
	{
		NSMutableDictionary *data = [[NSMutableDictionary alloc]init];
		data = [[HBAppDelegate getGlobalInfo] valueForKey:@"tmp_page_data"];
		[navController popViewControllerAnimated:YES];
		GoogleAnalyticsPlugin *obj1 = [[GoogleAnalyticsPlugin alloc]init];
		[data setObject:[data valueForKey:@"email"] forKey:@"info"];
		[data setObject:@"Submit clicked" forKey:@"clicked"];
		[data setObject:[data valueForKey:@"message"] forKey:@"label"];
		[obj1 trackEvent:nil withDict: data];
		
	}else if ([className isEqualToString:@"registration_submit"]) 
	{
		NSMutableDictionary *param=[[NSMutableDictionary alloc]init];
		param=[[HBAppDelegate getGlobalInfo] valueForKey:@"tmp_page_data"];
		[param setObject:[param valueForKey:@"email"] forKey:@"username"];

		param=[[HBLib getArrayFromURL:@"User.asmx/Registration" :param]objectAtIndex:0];
		if ([[param valueForKey:@"success"]intValue] == 0) 
		{
			[AlertHandler ShowMessageBoxWithTitle:@"Error" Message:[param valueForKey:@"message"] Button:@"OK"];
		}
		else
		{
			[AlertHandler ShowMessageBoxWithTitle:@"Message" Message:[param valueForKey:@"message"] Button:@"OK"];
			[navController popViewControllerAnimated:YES];
			GoogleAnalyticsPlugin *obj1 = [[GoogleAnalyticsPlugin alloc]init];
			[param setObject:[param valueForKey:@"username"] forKey:@"info"];
			[param setObject:@"Submit clicked" forKey:@"clicked"];
			[param setObject:[param valueForKey:@"message"] forKey:@"label"];
			[obj1 trackEvent:nil withDict: param];
		}
	}
	else if([className isEqualToString:@"Setting"])
	{
		HBMaster *obj = ([navController.viewControllers objectAtIndex:([navController.viewControllers count]-1)]);
        for(id tmpObj in obj.view.subviews)
		{
            if([tmpObj isKindOfClass:[UIButton class]]) 
			{
                UIButton *btnObj = (UIButton *)tmpObj;
                int btn_tag = btnObj.tag;
                if ( btn_tag == 0 ) 
				{
					if ([[[HBAppDelegate getGlobalInfo] valueForKey:@"is_ipad"]isEqualToString:@"Yes"]) 
					{
						[btnObj setBackgroundImage:[UIImage imageNamed:@"btn_setting_h_ipad.png"] forState:UIControlStateNormal];
					}
					else
					{
						[btnObj setBackgroundImage:[UIImage imageNamed:@"btn_setting_h.png"] forState:UIControlStateNormal];
					}
				}
            }
        }
		setting *obj1 = [[setting alloc] initWithNibName:[HBAppDelegate getNibFileName:@"setting"] bundle:nil];
		[navController pushViewController:obj1 animated:YES];
	}
	else if([className isEqualToString:@"SaveData"])
	{
		[navController popToViewController:[navController.viewControllers objectAtIndex:1] animated:YES];	
	}
	else if([className isEqualToString:@"EventDetail"])
	{
		MasterInherite *obj = [[MasterInherite alloc] initWithNibName:[HBAppDelegate getNibFileName:@"HBMaster"] bundle:nil];
		obj.sourceType = @"Online";
		obj.sourceFile = @"Directories.asmx/EventDetail";
		obj.pListFile = [HBAppDelegate getPlistFileName:@"Eve_Details.plist"];
		NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
		data = [[HBAppDelegate getGlobalInfo] valueForKey:@"tmp_page_data"];
		obj.sourceParams = data;
		[navController pushViewController:obj animated:YES];
		[HBAppDelegate maketransparentwebview:obj];
		GoogleAnalyticsPlugin *obj1 = [[GoogleAnalyticsPlugin alloc]init];
		[data setObject:[NSString stringWithFormat:@"%@",[[HBAppDelegate getGlobalInfo] valueForKey:@"USERNAME"]] forKey:@"info"];
		[data setObject:@"List Clicked" forKey:@"clicked"];
		[data setObject:[data valueForKey:@"event_name"] forKey:@"label"];
		[obj1 trackEvent:nil withDict:data];
		
	}
	else if ([className isEqualToString:@"Courses"])
	{
		HBList *obj_list=[[HBList alloc]initWithNibName:[HBAppDelegate getNibFileName:@"HBList"] bundle:nil];
		obj_list.sourceType=@"Online";
		obj_list.sourceFile=@"Directories.asmx/CourseList";
		obj_list.cacheInterval=@"0";
		obj_list.pListFile=[HBAppDelegate getPlistFileName:@"screen8.plist"];
		NSMutableDictionary *tmpOtherPageSettings = [[NSMutableDictionary alloc] init];
		[tmpOtherPageSettings setObject:@"Yes" forKey:@"load_more_image"];
		if ([[[HBAppDelegate getGlobalInfo] valueForKey:@"is_ipad"]isEqualToString:@"Yes"]) 
		{
			[tmpOtherPageSettings setObject:@"strip_middel_ipad.png" forKey:@"list_background"];
			[tmpOtherPageSettings setObject:@"strip_middel_h_ipad.png" forKey:@"selected_background"];
			[tmpOtherPageSettings setObject:@"71" forKey:@"cell_height"];
		}
		else
		{
			[tmpOtherPageSettings setObject:@"strip_middel.png" forKey:@"list_background"];
			[tmpOtherPageSettings setObject:@"strip_middel_h.png" forKey:@"selected_background"];
			[tmpOtherPageSettings setObject:@"50" forKey:@"cell_height"];
		}
		obj_list.otherPageSettings = tmpOtherPageSettings;
		[tmpOtherPageSettings release];
		NSMutableDictionary *param=[[NSMutableDictionary alloc]init];
		[param setObject:[[HBAppDelegate getGlobalInfo] valueForKey:@"group_id"] forKey:@"group_id"];
		obj_list.sourceParams=param;
		[navController pushViewController:obj_list animated:YES];
	}
	else if ([className isEqualToString:@"Course_detail"])
	{
		[HBAppDelegate ShowAlert];
		HBMaster *obj = [[HBMaster alloc] initWithNibName:[HBAppDelegate getNibFileName:@"HBMaster"] bundle:nil];
		obj.sourceType = @"Online";
		obj.sourceFile = @"";
		obj.pListFile = [HBAppDelegate getPlistFileName:@"Course_Details.plist"];
		NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
		data = [[HBAppDelegate getGlobalInfo] valueForKey:@"tmp_page_data"];
		if ([[[HBAppDelegate getGlobalInfo] valueForKey:@"is_ipad"]isEqualToString:@"Yes"]) 
		{
			[data setObject:@"ipad" forKey:@"keyword"];
		}
		data = [[HBLib getArrayFromURL:@"Directories.asmx/CourseDetail" :data] objectAtIndex:0];
		obj.sourceParams=data;
		[navController pushViewController:obj animated:YES];
		[HBAppDelegate maketransparentwebviewforcoursedetail:obj];
		[HBAppDelegate hideAlertclass];
		GoogleAnalyticsPlugin *obj1 = [[GoogleAnalyticsPlugin alloc]init];
		[data setObject:[NSString stringWithFormat:@"%@",[[HBAppDelegate getGlobalInfo] valueForKey:@"USERNAME"]] forKey:@"info"];
		[data setObject:@"Course Clicked" forKey:@"clicked"];
		[data setObject:[data valueForKey:@"course_name"] forKey:@"label"];
		[obj1 trackEvent:nil withDict: data];
	}
	else if ([className isEqualToString:@"Search_course"]) 
	{
		HBList *obj = ([navController.viewControllers objectAtIndex:([navController.viewControllers count]-1)]);
        for(id tmpObj in obj.view.subviews)
		{
            if([tmpObj isKindOfClass:[UIButton class]]) 
			{
                UIButton *btnObj = (UIButton *)tmpObj;
                int btn_tag = btnObj.tag;
                if ( btn_tag == 20001 ) 
				{
					if ([[[HBAppDelegate getGlobalInfo] valueForKey:@"is_ipad"]isEqualToString:@"Yes"]) 
					{
						[btnObj setBackgroundImage:[UIImage imageNamed:@"btn_search_s5_h_ipad.png"] forState:UIControlStateNormal];
					}
					else 
					{
						[btnObj setBackgroundImage:[UIImage imageNamed:@"btn_search1_h.png"] forState:UIControlStateNormal];
					}
				}
            }
        }
		HBMaster *obj1=[[HBMaster alloc]initWithNibName:[HBAppDelegate getNibFileName:@"HBMaster"] bundle:nil];
		obj1.sourceType=@"Online";
		obj1.sourceFile=@"";
		obj1.pListFile=[HBAppDelegate getPlistFileName:@"screen9.plist"];
		NSMutableDictionary *param=[[NSMutableDictionary alloc]init];
		obj1.sourceParams=param;
		[navController pushViewController:obj1 animated:YES];
		[HBAppDelegate maketransparentwebview_for_searchpage:obj1];
	}
	else if ([className isEqualToString:@"search_course_result"]) 
	{
		HBList *obj=[navController.viewControllers objectAtIndex:[navController.viewControllers count]-2];
		obj.sourceType=@"Online";
		obj.sourceFile=@"Directories.asmx/CourseList";
		obj.cacheInterval=@"0";
		obj.pListFile=[HBAppDelegate getPlistFileName:@"screen8.plist"];
		NSMutableDictionary *param =[[NSMutableDictionary alloc]init];
		param=[[HBAppDelegate getGlobalInfo]valueForKey:@"tmp_page_data"];
		[param setObject:[[HBAppDelegate getGlobalInfo] valueForKey:@"group_id"] forKey:@"group_id"];
		obj.sourceParams=param;
		for(id tmpObj in obj.view.subviews)
		{
            if([tmpObj isKindOfClass:[UIButton class]])
			{
                UIButton *btnObj = (UIButton *)tmpObj;
                int btn_tag = btnObj.tag;
                if ( btn_tag == 20001 ) 
				{
					if ([[[HBAppDelegate getGlobalInfo] valueForKey:@"is_ipad"]isEqualToString:@"Yes"]) 
					{
						[btnObj setBackgroundImage:[UIImage imageNamed:@"btn_search_s5_ipad.png"] forState:UIControlStateNormal];
					}
					else
					{
						[btnObj setBackgroundImage:[UIImage imageNamed:@"btn_search1s.png"] forState:UIControlStateNormal];
					}
				}
            }
        }
		
		[obj loadPageData];
		obj.reloadCell = YES;
		obj.reloadPageData  = YES;
		[obj.tblStart reloadData];
		[navController popViewControllerAnimated:YES];
	}
	else if ([className isEqualToString:@"Library"])
	{
		HBList *obj_list=[[HBList alloc]initWithNibName:[HBAppDelegate getNibFileName:@"HBList"] bundle:nil];
		obj_list.sourceType=@"Online";
		obj_list.sourceFile=@"Library.asmx/LibraryList";
		obj_list.cacheInterval=@"0";
		obj_list.pListFile=[HBAppDelegate getPlistFileName:@"screen11.plist"];
		NSMutableDictionary *tmpOtherPageSettings = [[NSMutableDictionary alloc] init];
		[tmpOtherPageSettings setObject:@"Yes" forKey:@"load_more_image"];
		if ([[[HBAppDelegate getGlobalInfo] valueForKey:@"is_ipad"]isEqualToString:@"Yes"]) 
		{
			[tmpOtherPageSettings setObject:@"strip_middel_ipad.png" forKey:@"list_background"];
			[tmpOtherPageSettings setObject:@"strip_middel_h_ipad.png" forKey:@"selected_background"];
			[tmpOtherPageSettings setObject:@"71" forKey:@"cell_height"];
		}
		else
		{
			[tmpOtherPageSettings setObject:@"strip_middel.png" forKey:@"list_background"];
			[tmpOtherPageSettings setObject:@"strip_middel_h.png" forKey:@"selected_background"];
			[tmpOtherPageSettings setObject:@"50" forKey:@"cell_height"];
		}
		obj_list.otherPageSettings = tmpOtherPageSettings;
		[tmpOtherPageSettings release];
		NSMutableDictionary *param=[[NSMutableDictionary alloc]init];
		[param setObject:[[HBAppDelegate getGlobalInfo] valueForKey:@"group_id"] forKey:@"group_id"];
		obj_list.sourceParams=param;
		[navController pushViewController:obj_list animated:YES];
	}
	else if ([className isEqualToString:@"Library_detail"]) 
	{
		HBList *obj_list=[[HBList alloc]initWithNibName:[HBAppDelegate getNibFileName:@"HBList"] bundle:nil];
		obj_list.sourceType=@"Online";
		obj_list.sourceFile=@"Library.asmx/SafetyDocuments";
		obj_list.cacheInterval=@"0";
		obj_list.pListFile=[HBAppDelegate getPlistFileName:@"screen12.plist"];
		NSMutableDictionary *tmpOtherPageSettings = [[NSMutableDictionary alloc] init];
		[tmpOtherPageSettings setObject:@"Yes" forKey:@"load_more_image"];
		[tmpOtherPageSettings setObject:@"strip_middel.png" forKey:@"list_background"];
		[tmpOtherPageSettings setObject:@"strip_middel_h.png" forKey:@"selected_background"];
		[tmpOtherPageSettings setObject:@"45" forKey:@"cell_height"];
		if ([[[HBAppDelegate getGlobalInfo] valueForKey:@"is_ipad"]isEqualToString:@"Yes"]) 
		{
			[tmpOtherPageSettings setObject:@"strip_middel_ipad.png" forKey:@"list_background"];
			[tmpOtherPageSettings setObject:@"strip_middel_h_ipad.png" forKey:@"selected_background"];
			[tmpOtherPageSettings setObject:@"71" forKey:@"cell_height"];
		}
		else
		{
			[tmpOtherPageSettings setObject:@"strip_middel.png" forKey:@"list_background"];
			[tmpOtherPageSettings setObject:@"strip_middel_h.png" forKey:@"selected_background"];
			[tmpOtherPageSettings setObject:@"45" forKey:@"cell_height"];
		}
		obj_list.otherPageSettings = tmpOtherPageSettings;
		[tmpOtherPageSettings release];
		NSMutableDictionary *param=[[NSMutableDictionary alloc]init];
		[param setObject:[[[HBAppDelegate getGlobalInfo]valueForKey:@"tmp_page_data"]valueForKey:@"lib_cate_id"] forKey:@"lib_cate_id"];
		[param setObject:[[[HBAppDelegate getGlobalInfo]valueForKey:@"tmp_page_data"]valueForKey:@"lib_cate_title"] forKey:@"lib_cate_title"];
		obj_list.sourceParams=param;
		[navController pushViewController:obj_list animated:YES];
		GoogleAnalyticsPlugin *obj1 = [[GoogleAnalyticsPlugin alloc]init];
		[param setObject:[NSString stringWithFormat:@"%@",[[HBAppDelegate getGlobalInfo] valueForKey:@"USERNAME"]] forKey:@"info"];
		[param setObject:@"Library clicked" forKey:@"clicked"];
		[param setObject:[param valueForKey:@"lib_cate_title"] forKey:@"label"];
		[obj1 trackEvent:nil withDict: param];
	}
	else if ([className isEqualToString:@"open_url"])
	{
		webpage *obj =[[webpage alloc]initWithNibName:[HBAppDelegate getNibFileName:@"webpage"] bundle:nil];
		[navController pushViewController:obj animated:YES];
	}
	else if([className isEqualToString:@"Back"])
	{
		HBList *obj = ([navController.viewControllers objectAtIndex:([navController.viewControllers count]-2)]);
		for(id tmpObj in obj.view.subviews)
		{
            if([tmpObj isKindOfClass:[UIButton class]]) 
			{
                UIButton *btnObj = (UIButton *)tmpObj;
                int btn_tag = btnObj.tag;
                if ( btn_tag == 20001 )
				{
					if ([[[HBAppDelegate getGlobalInfo] valueForKey:@"is_ipad"]isEqualToString:@"Yes"]) 
					{
						[btnObj setBackgroundImage:[UIImage imageNamed:@"btn_search_s5_ipad.png"] forState:UIControlStateNormal];
					}
					else
					{
						[btnObj setBackgroundImage:[UIImage imageNamed:@"btn_search1s.png"] forState:UIControlStateNormal];
					}
				}
            }
        }
		[navController popViewControllerAnimated:YES];
	}
	else if([className isEqualToString:@"BackImage"])
	{
		
		HBList *obj = ([navController.viewControllers objectAtIndex:([navController.viewControllers count]-1)]);
        for(id tmpObj in obj.view.subviews) {
            if([tmpObj isKindOfClass:[UIButton class]]) {
                UIButton *btnObj = (UIButton *)tmpObj;
                int btn_tag = btnObj.tag;
                if ( btn_tag == 0 ) {
					
					if ([[[HBAppDelegate getGlobalInfo] valueForKey:@"is_ipad"]isEqualToString:@"Yes"]) 
					{
						[btnObj setBackgroundImage:[UIImage imageNamed:@"btn_back_h_ipad.png"] forState:UIControlStateNormal];
						
					}else {
						[btnObj setBackgroundImage:[UIImage imageNamed:@"btn_back_h.png"] forState:UIControlStateNormal];
						
					}
				}
            }
        }
		[NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(changeimage:) userInfo:nil repeats:NO];
	}else if([className isEqualToString:@"Video"]){
		HBList *obj_list=[[HBList alloc]initWithNibName:[HBAppDelegate getNibFileName:@"HBList"] bundle:nil];
		obj_list.sourceType=@"Online";
		obj_list.sourceFile=@"Video.asmx/VideoList";
		obj_list.cacheInterval=@"0";
		obj_list.pListFile=[HBAppDelegate getPlistFileName:@"screen14.plist"];
		NSMutableDictionary *tmpOtherPageSettings = [[NSMutableDictionary alloc] init];
		[tmpOtherPageSettings setObject:@"Yes" forKey:@"load_more_image"];
		if ([[[HBAppDelegate getGlobalInfo] valueForKey:@"is_ipad"]isEqualToString:@"Yes"]) 
		{
			[tmpOtherPageSettings setObject:@"strip_middel_ipad.png" forKey:@"list_background"];
			[tmpOtherPageSettings setObject:@"strip_middel_h_ipad.png" forKey:@"selected_background"];
			[tmpOtherPageSettings setObject:@"71" forKey:@"cell_height"];			
		}
		else
		{
			[tmpOtherPageSettings setObject:@"strip_middel_s4.png" forKey:@"list_background"];
			[tmpOtherPageSettings setObject:@"strip_middel_s4_h.png" forKey:@"selected_background"];
			[tmpOtherPageSettings setObject:@"50" forKey:@"cell_height"];
			
		}
		obj_list.otherPageSettings = tmpOtherPageSettings;
		[tmpOtherPageSettings release];
		NSMutableDictionary *param=[[NSMutableDictionary alloc]init];
		[param setObject:[[HBAppDelegate getGlobalInfo] valueForKey:@"group_id"] forKey:@"group_id"];
		obj_list.sourceParams=param;
		[navController pushViewController:obj_list animated:YES];
	}else if([className isEqualToString:@"Videodetail"]){
		HBList *obj_list=[[HBList alloc]initWithNibName:[HBAppDelegate getNibFileName:@"AudioSearch"] bundle:nil];
		
		NSMutableDictionary *param=[[NSMutableDictionary alloc]init];
		param = [[HBAppDelegate getGlobalInfo]valueForKey:@"tmp_page_data"];
		[param setObject:[param valueForKey:@"video_cate_id"] forKey:@"video_cate_id"];
		[param setObject:[param valueForKey:@"video_cate_title"] forKey:@"video_cate_title"];
		obj_list.sourceType=@"Online";
		obj_list.sourceFile=@"Video.asmx/VideoCategory";
		obj_list.cacheInterval=@"0";
		obj_list.pListFile=[HBAppDelegate getPlistFileName:@"screen15.plist"];
	 	NSMutableDictionary *tmpOtherPageSettings = [[NSMutableDictionary alloc] init];
		[tmpOtherPageSettings setObject:@"Yes" forKey:@"load_more_image"];
		if ([[[HBAppDelegate getGlobalInfo] valueForKey:@"is_ipad"]isEqualToString:@"Yes"]) 
		{
			[tmpOtherPageSettings setObject:@"strip_middel_ipad.png" forKey:@"list_background"];
			[tmpOtherPageSettings setObject:@"strip_middel_h_ipad.png" forKey:@"selected_background"];
			[tmpOtherPageSettings setObject:@"71" forKey:@"cell_height"];
		}
		else
		{
			[tmpOtherPageSettings setObject:@"strip_middel_s4.png" forKey:@"list_background"];
			[tmpOtherPageSettings setObject:@"strip_middel_s4_h.png" forKey:@"selected_background"];
			[tmpOtherPageSettings setObject:@"50" forKey:@"cell_height"];
		}
		[tmpOtherPageSettings setObject:@"video_title" forKey:@"search_field"];
		obj_list.otherPageSettings = tmpOtherPageSettings;
		[tmpOtherPageSettings release];
		obj_list.sourceParams=param;
		[navController pushViewController:obj_list animated:YES];
	}else if([className isEqualToString:@"VideoPlay"]){
		NSMutableDictionary *param=[[NSMutableDictionary alloc]init];
		param = [[HBAppDelegate getGlobalInfo] valueForKey:@"tmp_page_data"];
		if([[param valueForKey:@"video_url"] isEqualToString:@"no-image.png"])
		{
		[AlertHandler ShowMessageBoxWithTitle:@"Message" Message:@"Video not found!" Button:@"Ok"];
		}
		else
		{
		CustomMoviePlayerViewController *mv = [[CustomMoviePlayerViewController alloc] init];
		[mv readyPlayer];
		[navController presentModalViewController:mv animated:YES];
		GoogleAnalyticsPlugin *obj1 = [[GoogleAnalyticsPlugin alloc]init];
		[param setObject:[NSString stringWithFormat:@"%@",[[HBAppDelegate getGlobalInfo] valueForKey:@"USERNAME"]] forKey:@"info"];
		[param setObject:@"Video clicked" forKey:@"clicked"];
		[param setObject:[NSString stringWithFormat:@"%@----%@",[param valueForKey:@"video_title"],[param valueForKey:@"video_url"]] forKey:@"label"];
		[obj1 trackEvent:nil withDict: param];
		}
		
	}else if([className isEqualToString:@"Audio"]){
		HBList *obj_list=[[HBList alloc]initWithNibName:[HBAppDelegate getNibFileName:@"HBList"] bundle:nil];
		obj_list.sourceType=@"Online";
		obj_list.sourceFile=@"Audio.asmx/AudioList";
		obj_list.cacheInterval=@"0";
		obj_list.pListFile=[HBAppDelegate getPlistFileName:@"screen17.plist"];
		NSMutableDictionary *tmpOtherPageSettings = [[NSMutableDictionary alloc] init];
		[tmpOtherPageSettings setObject:@"Yes" forKey:@"load_more_image"];
		if ([[[HBAppDelegate getGlobalInfo] valueForKey:@"is_ipad"]isEqualToString:@"Yes"]) 
		{
			[tmpOtherPageSettings setObject:@"strip_middel_ipad.png" forKey:@"list_background"];
			[tmpOtherPageSettings setObject:@"strip_middel_h_ipad.png" forKey:@"selected_background"];
			[tmpOtherPageSettings setObject:@"71" forKey:@"cell_height"];
		}
		else
		{
			[tmpOtherPageSettings setObject:@"strip_middel_s4.png" forKey:@"list_background"];
			[tmpOtherPageSettings setObject:@"strip_middel_s4_h.png" forKey:@"selected_background"];
			[tmpOtherPageSettings setObject:@"50" forKey:@"cell_height"];
		}
		obj_list.otherPageSettings = tmpOtherPageSettings;
		[tmpOtherPageSettings release];
		NSMutableDictionary *param=[[NSMutableDictionary alloc]init];
		[param setObject:[[HBAppDelegate getGlobalInfo] valueForKey:@"group_id"] forKey:@"group_id"];
		obj_list.sourceParams=param;
		[navController pushViewController:obj_list animated:YES];
	}else if([className isEqualToString:@"Audiodetail"]){
		HBList *obj_list=[[HBList alloc]initWithNibName:[HBAppDelegate getNibFileName:@"AudioSearch"] bundle:nil];
		NSMutableDictionary *param=[[NSMutableDictionary alloc]init];
		param = [[HBAppDelegate getGlobalInfo]valueForKey:@"tmp_page_data"];
		[param setObject:[param valueForKey:@"audio_cate_id"] forKey:@"audio_cate_id"];
		[param setObject:[param valueForKey:@"audio_cate_title"] forKey:@"audio_cate_title"];
		obj_list.sourceType=@"Online";
		obj_list.sourceFile=@"Audio.asmx/AudioCategory";
		obj_list.cacheInterval=@"0";
		obj_list.pListFile=[HBAppDelegate getPlistFileName:@"screen18.plist"];
		NSMutableDictionary *tmpOtherPageSettings = [[NSMutableDictionary alloc] init];
		[tmpOtherPageSettings setObject:@"Yes" forKey:@"load_more_image"];
		if ([[[HBAppDelegate getGlobalInfo] valueForKey:@"is_ipad"]isEqualToString:@"Yes"]) 
		{
			[tmpOtherPageSettings setObject:@"strip_middel_ipad.png" forKey:@"list_background"];
			[tmpOtherPageSettings setObject:@"strip_middel_h_ipad.png" forKey:@"selected_background"];
			[tmpOtherPageSettings setObject:@"71" forKey:@"cell_height"];
		}
		else
		{
			[tmpOtherPageSettings setObject:@"strip_middel_s4.png" forKey:@"list_background"];
			[tmpOtherPageSettings setObject:@"strip_middel_s4_h.png" forKey:@"selected_background"];
			[tmpOtherPageSettings setObject:@"50" forKey:@"cell_height"];
		}
		[tmpOtherPageSettings setObject:@"audio_title" forKey:@"search_field"];
		obj_list.otherPageSettings = tmpOtherPageSettings;
		[tmpOtherPageSettings release];
		obj_list.sourceParams=param;
		[navController pushViewController:obj_list animated:YES];
	}else if([className isEqualToString:@"AudioPlay"]){
		NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
		param = [[HBAppDelegate getGlobalInfo]valueForKey:@"tmp_page_data"];
		if ([[param valueForKey:@"audio_url"]isEqualToString:@"no-image.png"])
		{
				[AlertHandler ShowMessageBoxWithTitle:@"Message" Message:@"Audio not found!" Button:@"Ok"];
		}
		else
		{
			iPhoneStreamingPlayerViewController *obj = [[iPhoneStreamingPlayerViewController alloc] initWithNibName:[HBAppDelegate getNibFileName:@"iPhoneStreamingPlayerViewController"] bundle:nil];
			[navController pushViewController:obj animated:YES];
			GoogleAnalyticsPlugin *obj1 = [[GoogleAnalyticsPlugin alloc]init];
			[param setObject:[NSString stringWithFormat:@"%@",[[HBAppDelegate getGlobalInfo] valueForKey:@"USERNAME"]] forKey:@"info"];
			[param setObject:@"Audio clicked" forKey:@"clicked"];
			[param setObject:[NSString stringWithFormat:@"%@----%@",[param valueForKey:@"audio_title"],[param valueForKey:@"audio_url"]] forKey:@"label"];
			[obj1 trackEvent:nil withDict: param];
		}
	}else if([className isEqualToString:@"Search_event"]){
		HBList *obj = ([navController.viewControllers objectAtIndex:([navController.viewControllers count]-1)]);
        for(id tmpObj in obj.view.subviews) {
            if([tmpObj isKindOfClass:[UIButton class]]) {
                UIButton *btnObj = (UIButton *)tmpObj;
                int btn_tag = btnObj.tag;
                if ( btn_tag == 20001 ) {
					if ([[[HBAppDelegate getGlobalInfo] valueForKey:@"is_ipad"]isEqualToString:@"Yes"]) 
					{
						[btnObj setBackgroundImage:[UIImage imageNamed:@"btn_search_s5_h_ipad.png"] forState:UIControlStateNormal];
						
					}else {
						[btnObj setBackgroundImage:[UIImage imageNamed:@"btn_search1_h.png"] forState:UIControlStateNormal];
						
					}
				}
            }
        }
		HBMaster *obj1=[[HBMaster alloc]initWithNibName:[HBAppDelegate getNibFileName:@"HBMaster"] bundle:nil];
		obj1.sourceType=@"Online";
		obj1.sourceFile=@"";
		obj1.pListFile=[HBAppDelegate getPlistFileName:@"screen6.plist"];
		NSMutableDictionary *param=[[NSMutableDictionary alloc]init];
		obj1.sourceParams=param;
		[navController pushViewController:obj1 animated:YES];
		[HBAppDelegate maketransparentwebview_for_searchpage:obj1];
	}
	
	else if ([className isEqualToString:@"reload_event"]) {
		HBList *obj=[navController.viewControllers objectAtIndex:[navController.viewControllers count]-2];
		obj.sourceType=@"Online";
		obj.sourceFile=@"Directories.asmx/EventList";
		obj.cacheInterval=@"0";
		obj.pListFile=[HBAppDelegate getPlistFileName:@"Events.plist"];
		NSMutableDictionary *param =[[NSMutableDictionary alloc]init];
		param=[[[HBAppDelegate getGlobalInfo] valueForKey:@"tmp_page_data"] retain];
		NSDate *date = [[NSDate alloc]init];
		NSString *date_string = [param valueForKey:@"event_date"];
		NSDateFormatter *format = [[NSDateFormatter alloc]init];
		[format setDateFormat:@"yyyy-MM-dd HH:mm"];
		if(date_string == nil)
		{
		}
		else
		{
		date=[format dateFromString:[HBAppDelegate setDBINPUTFormate:date_string]];
		}
		NSDateFormatter *format1 =[[NSDateFormatter alloc]init];
		[format1 setDateFormat:@"yyyy-MM-dd"];
		NSString *date_final = [format1 stringFromDate:date];
		if ([date_final length] != 0) {
			[param setObject:date_final forKey:@"event_date"];
		}
		for(id tmpObj in obj.view.subviews) {
            if([tmpObj isKindOfClass:[UIButton class]]) {
                UIButton *btnObj = (UIButton *)tmpObj;
                int btn_tag = btnObj.tag;
                if ( btn_tag == 20001 ) {
					if ([[[HBAppDelegate getGlobalInfo] valueForKey:@"is_ipad"]isEqualToString:@"Yes"]) 
					{
						[btnObj setBackgroundImage:[UIImage imageNamed:@"btn_search_s5_ipad.png"] forState:UIControlStateNormal];
					}else {
						[btnObj setBackgroundImage:[UIImage imageNamed:@"btn_search1s.png"] forState:UIControlStateNormal];
					}
				}
            }
        }
		[param setObject:[[HBAppDelegate getGlobalInfo] valueForKey:@"group_id"] forKey:@"group_id"];
		obj.sourceParams=param;
		[obj loadPageData];
		obj.reloadCell = YES;
		obj.reloadPageData  = YES;
		[obj.tblStart reloadData];
		[navController popViewControllerAnimated:YES];
	}
}

+ (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error 
{    
    switch (result)
	{
        case MFMailComposeResultCancelled:
		{
			UIAlertView *alert= [[UIAlertView alloc] initWithTitle:@"Message" message:@"Mail canceled!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
			[alert show];
			[alert release];
			break;
		}
        case MFMailComposeResultSaved:
		{
			UIAlertView *alert1 = [[UIAlertView alloc] initWithTitle:@"Message" message:@"Mail saved!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
			[alert1 show];
			[alert1 release];
			break;
		}
        case MFMailComposeResultSent:
		{
			NSMutableDictionary *data = [[NSMutableDictionary alloc]init];
			data = [[HBAppDelegate getGlobalInfo] valueForKey:@"tmp_page_data"];
			[data setObject:[NSString stringWithFormat:@"%@",[[HBAppDelegate getGlobalInfo] valueForKey:@"USERNAME"]] forKey:@"info"];
			[data setObject:@"Button" forKey:@"clicked"];
			[data setObject:[data valueForKey:@"email"] forKey:@"label"];
			GoogleAnalyticsPlugin *obj1 = [[GoogleAnalyticsPlugin alloc]init];
			[obj1 trackEvent:nil withDict:data];
			UIAlertView *alert2 = [[UIAlertView alloc] initWithTitle:@"Message" message:@"Mail has been sent successfully!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
			[alert2 show];
			[alert2 release];
			break;
		}
        case MFMailComposeResultFailed:
		{
			UIAlertView *alert3 = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Mail failed" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
			[alert3 show];
			[alert3 release];
			break;
		}
        default:
		{
			UIAlertView *alert4 = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Mail not send" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
			[alert4 show];
			[alert4 release];
			break;
		}
	}
	
	[((HBAppDelegate *)[[UIApplication sharedApplication]delegate]).navigationController dismissModalViewControllerAnimated:YES];
}

+(void)changeimage:(id)sender
{
	[HBAppDelegate loadAppPage:@"Back" :((HBAppDelegate *)[[UIApplication sharedApplication]delegate]).navigationController];
}
+(void)ShowAlert{
    [self performSelectorInBackground:@selector(showAlertInBackground) withObject:nil];
}

+(void)showAlertInBackground{
    UIView *view = ((HBAppDelegate *)[[UIApplication sharedApplication]delegate]).window;
    if(activity == nil||loadingView==nil) {
        loadingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
        loadingView.backgroundColor =[UIColor blackColor];
		
        loadingView.backgroundColor = [UIColor clearColor];
        activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        if ([[[HBAppDelegate getGlobalInfo] valueForKey:@"is_ipad"]isEqualToString:@"Yes"]) 
		{
		activity.frame = CGRectMake(385, 475, 30, 30);	
		}
		else
		{
		activity.frame = CGRectMake(145, 265, 30, 30);
        }
		[activity setHidesWhenStopped:YES];
        [loadingView addSubview:activity];
		
        [view addSubview:loadingView];
    }
    [view bringSubviewToFront:loadingView];
    [activity startAnimating];
    loadingView.hidden = NO;
}


+(void)hideAlertInBackground1{
    if(activity != nil||loadingView!=nil) {
        loadingView.hidden= YES;
        [activity stopAnimating];
    }
	
}

+(void)hideAlertclass{
    [self performSelector:@selector(hideAlertInBackground1) withObject:nil afterDelay:0.5];
}

+(void)hideAlertcat{
    if(activity != nil||loadingView!=nil) {
        loadingView.hidden= YES;
        [activity stopAnimating];
    }
	
    [self performSelector:@selector(hideAlertInBackground1) withObject:nil afterDelay:0.1];
}


+(void)GetLangKey:(NSString *)Langkey
{
	NSString *tmpstr=[NSString stringWithFormat:@"%@",[[NSBundle mainBundle]pathForResource:@"LangResource" ofType:@"bundle"]]; 
	tmpstr =[tmpstr stringByAppendingString:@"/"];
	tmpstr=[tmpstr stringByAppendingString:Langkey];
	tmpstr =[tmpstr stringByAppendingString:@".lproj"];
	myLocalizedBundle=[NSBundle bundleWithPath:tmpstr];
	current_lang = Langkey;
}

+(NSString *)getCurrentLang {
	return current_lang;
}

+(NSString *)getDefaultLang {
	return default_lang;
}


+(NSString *)getLocalvalue:(NSString*)Key
{
	if ( myLocalizedBundle != nil ) {
		NSString *localValue=NSLocalizedStringFromTableInBundle(Key,@"Localizable",myLocalizedBundle,@"");
		return localValue;
		
	} else {
		return Key;
	}
}

+(NSString *)getNibFileName: (NSString *)nibFile {
	NSString *ipadNib=@"";
	@try {
		if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
			ipadNib = @"_ipad";
		}
	}@catch (NSException * e) {
		NSLog(@"Its Iphone");
	}
	NSString *oldNibFile = nibFile;
	nibFile = [nibFile stringByAppendingString:ipadNib];
	if (![HBLib resourceFileExists:nibFile :@"nib"]) {
		nibFile = oldNibFile;
	}
	return nibFile;
}

+(NSString *)setDBINPUTFormate:(NSString *) tmpstr {
	NSString *tmp = [[NSString alloc] init];
	tmp = [tmpstr stringByReplacingOccurrencesOfString: @"+" withString: @"%20"];
	tmp = [tmp stringByReplacingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
	tmp = [tmp stringByReplacingOccurrencesOfString:@"\n" withString:@"\\n"];
	tmp = [tmp stringByReplacingOccurrencesOfString:@"\"" withString:@"\"\""];
	return tmp;
}
+(NSString*)getPlistFileName:(NSString *)plistFile {
	
	NSString *ipadPlist=@"";
	NSArray *arrTemp = [plistFile componentsSeparatedByString:@".plist"];
	plistFile = [arrTemp objectAtIndex:0];
	ipadPlist = plistFile;
	if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
		ipadPlist = [plistFile stringByAppendingString:@"_ipad"];
	}
	plistFile = ipadPlist;
	plistFile = [plistFile stringByAppendingString:@".plist"];
	return plistFile;
}


+(NSString	*)getHTMLFileName:(NSString *)htmlFile {
	
	NSString *newHTMLFile;
	if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) {
		newHTMLFile = [htmlFile stringByAppendingString:@"_ipad"];
		if ( [HBLib resourceFileExists:newHTMLFile :@"html"] ) {
			htmlFile = newHTMLFile;
		}
	}
	return htmlFile;
}

- (void)dealloc {
	[[GANTracker sharedTracker] stopTracker];

	[navigationController release];
	[window release];
	[super dealloc];
}

+(HBAppDelegate *)sharedAppDelegate
{
    return (HBAppDelegate *)[UIApplication sharedApplication].delegate;
}

@end

