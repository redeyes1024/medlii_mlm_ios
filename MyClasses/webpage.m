//
//  webpage.m
//  HBApp
//
//  Created by hb ipl on 07/03/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "webpage.h"
#import "GoogleAnalyticsPlugin.h"
@implementation webpage

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
	lbl.text=[[[HBAppDelegate getGlobalInfo]valueForKey:@"tmp_page_data"]valueForKey:@"doc_name"];
	NSMutableDictionary *data = [[NSMutableDictionary alloc]init];
	data = [[HBAppDelegate getGlobalInfo] valueForKey:@"tmp_page_data"];
	
	NSURL *url=[NSURL URLWithString:[[[HBAppDelegate getGlobalInfo]valueForKey:@"tmp_page_data"]valueForKey:@"doc_url"]];
	if(url == nil) {
		url = [NSURL URLWithString:@"http://www.apple.com/"];
	}

	NSURLRequest *urlrequest =[NSURLRequest requestWithURL:url];
	webpageName.delegate=self;
	[webpageName loadRequest:urlrequest];
	
	[actView startAnimating];
	actView.hidesWhenStopped = YES;
	
	[webpageName setScalesPageToFit:YES];
    UIScrollView *sv = [webpageName.subviews objectAtIndex:0];
    [sv setZoomScale:110.0 animated:YES];
	
	GoogleAnalyticsPlugin *obj1 = [[GoogleAnalyticsPlugin alloc]init];
	[data setObject:[NSString stringWithFormat:@"%@",[[HBAppDelegate getGlobalInfo] valueForKey:@"USERNAME"]] forKey:@"info"];
	[data setObject:@"Documnet list clicked" forKey:@"clicked"];
	[data setObject:[NSString stringWithFormat:@"%@----%@",[data valueForKey:@"doc_name"],[data valueForKey:@"doc_url"]] forKey:@"label"];
	[obj1 trackEvent:nil withDict: data];
	
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
	[actView stopAnimating];
}
-(IBAction)btnBackPressed:(id)sender
{
	[self.navigationController popViewControllerAnimated:YES];

}
-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
    return UIInterfaceOrientationIsPortrait(toInterfaceOrientation);
}

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
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
