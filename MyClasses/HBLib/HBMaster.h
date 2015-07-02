//
//  HBMaster.h
//  HBApp
//
//  Created by hbipl on 20/08/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "ASINetworkQueue.h"
#import "CustomAlertView.h"
#import "GoogleMap.h"

@interface HBMaster : UIViewController<UITextFieldDelegate> {
	
	UIAlertView *objAlert;
	NSArray *detailViewResponse;
	NSMutableDictionary *PageArray , *sourceParams , *buttonParams ;
	NSMutableArray *detailElements , *primaryParams , *listPageRecords , *formSelectVars ;
	int record_index , image_index_tag;
	NSString *sourceType , *sourceFile , *pListFile , *nextPage , *deleteSource , *cacheInterval , *actionFile , *htmlForm  , *primaryId , *json_response , *file_binary , *field_name , *sessionId , *currentOrientation;
	UIActionSheet *actionSheet1;
	IBOutlet UIImagePickerController *pickerPhoto;
	id temp_date_popover;
	UIWebView *currentWebView;
	ASINetworkQueue  *networkQueue;
	HBLib *libobj;
	BOOL reloadPageData;
}
-(IBAction)btnBackPressed:(id)sender;
-(IBAction) btnSendEmailPressed:(id)sender;
-(IBAction)btnCancelPressed:(id)sender;
-(void) reloadElements ;
-(void) generateElements :(NSMutableDictionary *) elementDetails : (id) parentView : (NSMutableDictionary *) SourceData;
-(void) loadDetailPageData;
-(UIImage *) scaleAndRotateImage: (UIImage *) image;
- (void)dateChange:(id)sender ;
- (void)dateDoneClicked;
- (void)dateCancelClicked;
- (void)getSuccessResponseArrayOfCall:(NSMutableArray *) dtlViewResponse;
-(void)imageFetchComplete:(ASIHTTPRequest *)request1;
-(void) reloadPageData;
@property(nonatomic,retain) NSArray *detailViewResponse;
@property(nonatomic,retain) NSMutableDictionary *PageArray , *sourceParams , *buttonParams;
@property(nonatomic,retain) NSMutableArray *primaryParams , *listPageRecords , *detailElements , *formSelectVars;
@property(nonatomic, nonatomic) int record_index , image_index_tag;
@property(nonatomic,retain) NSString *sourceType , *currentOrientation , *sourceFile , *pListFile , *nextPage , *deleteSource , *cacheInterval , *actionFile , *sessionId;
@property(nonatomic,retain) id temp_date_popover;
@property(nonatomic,retain) ASINetworkQueue  *networkQueue;
@property(nonatomic , nonatomic) BOOL reloadPageData;


@end
