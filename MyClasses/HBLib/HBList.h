//
//  HBList.h
//  HBLib
//
//  Created by hbipl on 03/03/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
#import "HBAppDb.h"
#import "ASINetworkQueue.h"
#import "CustomAlertView.h"
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
#import <UIKit/UIKit.h>
//
//
//@interface CustomImageView : UIImageView {
//	BOOL isImageLoaded;
//}
//
//@end


@interface HBList : UIViewController <UITableViewDelegate,UITableViewDataSource,HBLibDeligate>{
	IBOutlet UITableView *tblStart;
	IBOutlet UISearchBar *searchBar;
	IBOutlet UIButton *dismisSearch;
	ASINetworkQueue  *networkQueue;
	HBLib *libobj;
	NSMutableArray *listViewResponse , *primaryParams , *searchedArray , *otherParamsArray , *sectionArray;
	NSMutableDictionary *ListArray , *HeaderArray , *FooterArray , *buttonParams , *sourceParams , *cellActParams , *ListPageParams , *otherPageSettings;
	bool caching , deleteCell , pageReloaded , reloadCell , searching , letUserSelectRow , reloadPageData , sectionEnabled , sectionDisplay , indexEnabled;
	int current_page , prev_count;
	NSInteger displayed_records , image_index_tag;
	NSString *sourceType , *sourceFile , *pListFile , *nextPage , *deleteSource , *removeRecord , *cacheInterval , *has_next_page , *currentOrientation1 ;
}

//-(NSString *) convertDate :(NSString *) inputFormat : (NSString *) outputFormat  :(NSString *) date;
-(void) generateElements :(NSMutableDictionary *) elementDetails : (id) parentView : (NSMutableDictionary *) SourceData : (BOOL)saveObjectInArray;
//-(IBAction)btnLogoutPressed:(id)sender;
-(void) loadMoreData :(id) sender;
-(void) loadPageData_OLD;
-(void) loadPageData;
-(void) searchTableView;
-(void) changeObjectPositionsByOrientation;
-(void) generateOhterParams : (BOOL) isWSParams ;
-(void) reloadPageData;
-(void) reloadPageData : (BOOL)loadingPage;
-(void)imageFetchComplete:(ASIHTTPRequest *)request1;
@property(nonatomic,retain) NSMutableArray *listViewResponse , *searchedArray , *primaryParams , *sectionArray;
@property(nonatomic,retain) NSMutableDictionary *ListArray , *HeaderArray , *FooterArray , *buttonParams , *sourceParams , *otherParamsArray , *cellActParams , *ListPageParams , *otherPageSettings;
@property(nonatomic,retain) NSString *sourceType , *removeRecord , *sourceFile , *pListFile , *nextPage , *deleteSource , *cacheInterval , *has_next_page , *currentOrientation1;
@property(nonatomic,retain) UITableView *tblStart;
@property(nonatomic,retain) HBLib *libobj;
@property(nonatomic,retain) ASINetworkQueue  *networkQueue;
@property(nonatomic,nonatomic) NSInteger displayed_records , image_index_tag;
@property(nonatomic , nonatomic) int prev_count , current_page;
@property(nonatomic , nonatomic) bool reloadCell , searching , letUserSelectRow , reloadPageData, sectionEnabled , sectionDisplay , indexEnabled;
@end
