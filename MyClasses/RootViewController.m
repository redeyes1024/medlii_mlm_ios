//
//  RootViewController.m
//  Health
//
//  Created by hbipl on 12/08/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "RootViewController.h"
#import "HBAppDelegate.h"


@implementation RootViewController
@synthesize activityIndicator;
#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
	self.navigationController.navigationBarHidden =  YES;
	[activityIndicator startAnimating];
	[NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(gotologin) userInfo:nil repeats:NO];
}
-(void)gotologin
{
	[activityIndicator stopAnimating];
	[HBAppDelegate loadAppPage:nil :self.navigationController];
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
    return UIInterfaceOrientationIsPortrait(toInterfaceOrientation);
}

#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
}

- (void)dealloc {
    [super dealloc];
}

@end

