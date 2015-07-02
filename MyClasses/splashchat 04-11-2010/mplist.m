//
//  mplist.m
//  iProTraining
//
//  Created by hidden brains on 09/07/10.
//  Copyright 2010 hiddenbrains. All rights reserved.
//
#import "mplist.h"

@implementation mplist
@synthesize UserId,UserName,Password,DataPath;


// Must be call this Method before other Methodes call
-(void)mImportPlistSettings{
	NSString *resourcePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Settings.plist"];
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	self.DataPath = [[NSString alloc]init];
	self.DataPath = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"Settings.plist"];
	
	NSFileManager *fileManager = [NSFileManager defaultManager];
	
	//see if Data.plist exists in the Documents directory
	if (![fileManager fileExistsAtPath:self.DataPath]) {
		[fileManager copyItemAtPath:resourcePath toPath:self.DataPath error:nil];
		//NSLog(@"\n===================\nPlist Successfulyy copied\n===================\n");
	}
	//END OF CHECK TO SEE IF FILE EXISTS
	
	self.UserId = 0;
	
}

-(void)mWritePlistSettings{
	
	NSMutableDictionary *dic_plist = [[NSMutableDictionary alloc]initWithContentsOfFile:self.DataPath];
	
	
	[dic_plist setValue:self.UserId forKey:@"UserId"];
	[dic_plist setValue:self.UserName forKey:@"UserName"];
	[dic_plist setValue:self.Password forKey:@"Password"];

	
	[dic_plist writeToFile:self.DataPath atomically:YES];
	
}

-(void)mReadPlistSettings{
	//Load Data.plist from documents directory
	NSString *errorDesc = nil;
	NSPropertyListFormat format;
	NSData *plistXML = [[NSFileManager defaultManager] contentsAtPath:self.DataPath];
	NSDictionary *tempDict = (NSDictionary *)[NSPropertyListSerialization propertyListFromData:plistXML mutabilityOption:NSPropertyListMutableContainersAndLeaves format:&format errorDescription:&errorDesc];
	
	self.UserId = [tempDict valueForKey:@"UserId"];
	self.UserName = [tempDict valueForKey:@"UserName"];
	self.Password = [tempDict valueForKey:@"Password"];
	
	
}

@end
