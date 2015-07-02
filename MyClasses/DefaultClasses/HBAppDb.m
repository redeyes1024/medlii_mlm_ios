//
//  HBAppDb.m
//  Health
//
//  Created by hbipl on 14/08/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "HBAppDb.h"


@implementation HBAppDb

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

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


+(NSMutableArray *) getData : (NSString *) actionType : (NSMutableDictionary *) data {
	NSMutableArray *db_result = [[NSMutableArray alloc] init];
	NSString *sql = [[NSString alloc] init];
	if ( [actionType isEqualToString:@"ProcessLogin"] ) {
		sql = [NSString stringWithFormat:@"select * from user where username = '%@' and password = '%@'" , [data valueForKey:@"username"] , [data valueForKey:@"password"]];
		db_result = [DBOperation selectData:sql];
		NSMutableDictionary *tmp_dict = [[NSMutableDictionary alloc] init];
		if ( [db_result count] > 0 ) {
			[tmp_dict setObject:[[db_result objectAtIndex:0] valueForKey:@"user_id"] forKey:@"id"];
			[tmp_dict setObject:@"Logged in successfully!" forKey:@"message"];
			[tmp_dict setObject:@"1" forKey:@"success"];
		} else {
			[tmp_dict setObject:@"0" forKey:@"id"];
			[tmp_dict setObject:@"Wrong username or password!" forKey:@"message"];
			[tmp_dict setObject:@"0" forKey:@"success"];
		}
		NSMutableArray *return_array = [[NSMutableArray alloc] init];
		[return_array addObject:tmp_dict];
		return return_array;
	}
	return db_result;
}

-(NSString *)setDBINPUTFormate:(NSString *) tmpstr {
	NSString *tmp = [[NSString alloc] init];
	tmp = [tmpstr stringByReplacingOccurrencesOfString: @"+" withString: @"%20"];
	tmp = [tmp stringByReplacingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
	tmp = [tmp stringByReplacingOccurrencesOfString:@"\n" withString:@"\\n"];
	tmp = [tmp stringByReplacingOccurrencesOfString:@"\"" withString:@"\"\""];
	return tmp;
}

@end
