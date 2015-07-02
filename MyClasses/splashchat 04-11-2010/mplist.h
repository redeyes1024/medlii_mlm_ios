//
//  mplist.h
//  iProTraining
//
//  Created by hidden brains on 09/07/10.
//  Copyright 2010 hiddenbrains. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface mplist : NSObject {
	NSString *UserId, *UserName, *Password;
	NSString *DataPath;
}

@property (nonatomic,retain)NSString *UserId;
@property (nonatomic,retain)NSString *UserName;
@property (nonatomic,retain)NSString *Password;
@property (nonatomic,retain)NSString *DataPath;


-(void)mImportPlistSettings;
-(void)mWritePlistSettings;
-(void)mReadPlistSettings;
@end
