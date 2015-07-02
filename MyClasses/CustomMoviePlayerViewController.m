//
//  CustomMoviePlayerViewController.m
//
//  Copyright iOSDeveloperTips.com All rights reserved.
//

#import "CustomMoviePlayerViewController.h"

@implementation CustomMoviePlayerViewController

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	
	return NO;
	
}

- (void) moviePlayerLoadStateChanged:(NSNotification*)notification {
	
	if ( [mp loadState] != MPMovieLoadStateUnknown ) {
    [[NSNotificationCenter 	defaultCenter] 
								removeObserver:self
                         		name:MPMoviePlayerLoadStateDidChangeNotification 
                         		object:nil];

	 
		 [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationLandscapeRight animated:NO];
		if ([[[HBAppDelegate getGlobalInfo] valueForKey:@"is_ipad"]isEqualToString:@"Yes"]) 
		{
			[[self view] setBounds:CGRectMake(0, 0, 1024, 768)];
			[[self view] setCenter:CGPointMake(384, 512)];
			[[self view] setTransform:CGAffineTransformMakeRotation(M_PI / 2)]; 
			[[mp view] setFrame:CGRectMake(0, 0, 1024, 768)];
			
			
		}else {
			[[self view] setBounds:CGRectMake(0, 0, 480, 320)];
			[[self view] setCenter:CGPointMake(160, 240)];
			[[self view] setTransform:CGAffineTransformMakeRotation(M_PI / 2)]; 
			[[mp view] setFrame:CGRectMake(0, 0, 460, 320)];
			
			
		}
	  [[self view] addSubview:[mp view]];   
	  [mp play];
	}
	
}

- (void) moviePreloadDidFinish:(NSNotification*)notification {
	
	//[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
//	[[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationPortrait animated:NO];
	[[UIApplication sharedApplication] setStatusBarHidden:NO];
	[[NSNotificationCenter 	defaultCenter] 
	 removeObserver:self
	 name:MPMoviePlayerContentPreloadDidFinishNotification
	 object:nil];
	[mp play];
	
}


- (void) moviePlayBackDidFinish:(NSNotification*)notification {   
	
	//[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
	//[[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationPortrait animated:NO];
	//UIApplication *application = [UIApplication sharedApplication];
	//[application setStatusBarStyle:statusBarStyle];
	[[UIApplication sharedApplication] setStatusBarHidden:NO];
    [[NSNotificationCenter defaultCenter] 
  												removeObserver:self
  		                   	name:MPMoviePlayerPlaybackDidFinishNotification 
      		               	object:nil];
	[self dismissModalViewControllerAnimated:YES];	
	
}

- (void) readyPlayer {
	NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
	data = [[HBAppDelegate getGlobalInfo] valueForKey:@"tmp_page_data"];
	NSString *url = [[NSString alloc] init];
	url = [CustomMoviePlayerViewController setDBINPUTFormate:[data valueForKey:@"video_url"]];
	
	movieURL = [NSURL URLWithString:url];
 	mp =  [[MPMoviePlayerController alloc] initWithContentURL:movieURL];

	if ( [mp respondsToSelector:@selector(loadState)] ) {
		[mp setControlStyle:MPMovieControlStyleFullscreen];
		[mp setFullscreen:YES];
		[mp prepareToPlay];
		[[NSNotificationCenter defaultCenter] addObserver:self 
						   selector:@selector(moviePlayerLoadStateChanged:) 
						   name:MPMoviePlayerLoadStateDidChangeNotification 
						   object:nil];
	} else {
		[[NSNotificationCenter defaultCenter] addObserver:self 
							 selector:@selector(moviePreloadDidFinish:) 
							 name:MPMoviePlayerContentPreloadDidFinishNotification 
							 object:nil];
	}
		[[NSNotificationCenter defaultCenter] addObserver:self 
							selector:@selector(moviePlayBackDidFinish:) 
							name:MPMoviePlayerPlaybackDidFinishNotification 
							object:nil];
}

- (void) loadView {
	
	[self setView:[[[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]] autorelease]];
	[[self view] setBackgroundColor:[UIColor blackColor]];

}


		   
+(NSString *)setDBINPUTFormate:(NSString *) tmpstr {
  
	NSString *tmp = [[NSString alloc] init];
   tmp = [tmpstr stringByReplacingOccurrencesOfString: @"+" withString: @"%20"];
   tmp = [tmp stringByReplacingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
   tmp = [tmp stringByReplacingOccurrencesOfString:@"\n" withString:@"\r\n"];
   tmp = [tmp stringByReplacingOccurrencesOfString:@"\"" withString:@"\"\""];
   return tmp;
	
}

- (void)dealloc {
	
	[mp release];
    [movieURL release];
	[super dealloc];
	
}

@end
