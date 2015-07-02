//
//  SearchDetail.h
//  HealthCalendar
//
//  Created by HB14 on 03/08/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface HBDetail : UIViewController<UITextFieldDelegate> {
	UIAlertView *objAlert;
	NSArray *detailViewResponse;
	NSMutableDictionary *PageArray;
	NSMutableDictionary *sourceParams , *buttonParams ;
	NSMutableArray *detailElements ;
	NSMutableArray *primaryParams ;
	NSMutableArray *listPageRecords ;
	int record_index;
	NSString *sourceType , *sourceFile , *pListFile , *nextPage , *deleteSource , *cacheInterval , *currentOrientation;
    
}

-(IBAction)btnBackPressed:(id)sender;
-(IBAction) btnSendEmailPressed:(id)sender;
-(IBAction)btnCancelPressed:(id)sender;
-(void) reloadElements ;
-(void) generateElements :(NSMutableDictionary *) elementDetails : (id) parentView : (NSMutableDictionary *) SourceData;
-(void) loadDetailPageData;

@property(nonatomic,retain) NSArray *detailViewResponse;
@property(nonatomic,retain) NSMutableDictionary *PageArray;
@property(nonatomic,retain) NSMutableDictionary *sourceParams;
@property(nonatomic,retain) NSMutableDictionary *buttonParams;
@property(nonatomic,retain) NSMutableArray *primaryParams , *listPageRecords , *detailElements;
@property(nonatomic, nonatomic) int record_index;
@property(nonatomic,retain) NSString *sourceType;
@property(nonatomic,retain) NSString *sourceFile;
@property(nonatomic,retain) NSString *pListFile;
@property(nonatomic,retain) NSString *nextPage;
@property(nonatomic,retain) NSString *deleteSource , *cacheInterval , *currentOrientation;

@end
