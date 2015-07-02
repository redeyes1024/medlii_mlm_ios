//
//  HealthAppDelegate.h
//  Health
//
//  Created by hbipl on 12/08/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reachability.h"
#import "HBMaster.h"
#import "mplist.h"
#import <MapKit/MapKit.h>
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

//-----for custom tab bar------//

@interface HBAppDelegate : NSObject <UIApplicationDelegate,MFMailComposeViewControllerDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate> {
    
	UIWindow *window;
    UINavigationController *navigationController;
	NSOperationQueue *downloadQueue;
	//------for tab bar-----//
	
}
+(NSMutableDictionary *)getGlobalInfo;
+(void) loadAppPage : (NSString *) className : (UINavigationController *) navController;
//-(void)GetPlistPath;
+(NSString *) getNibFileName: (NSString *)nibFile;
+(NSString *) getLocalvalue:(NSString*)Key;
+(void)GetLangKey:(NSString *)Langkey;
+(NSString *)getCurrentLang;
+(NSString *)getDefaultLang;
+(NSString	*)getHTMLFileName:(NSString *)htmlFile ;
//+(void)syncWithOnline;
+(NSString *)setDBINPUTFormate:(NSString *) tmpstr;
+(NSString*)getPlistFileName:(NSString *)plistFile;
+(void)hideAlertcat;
+(void)hideAlertInBackground1;
+(void)showAlertInBackground;
+(void)ShowAlert;
+(void)hideAlertclass;

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;
@property (nonatomic, retain) NSOperationQueue *downloadQueue;
@end

