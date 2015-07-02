//
//  HBForm.h
//  HealthCalendar
//
//  Created by hbipl on 11/08/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PickImageView.h"
#import "Base64.h"

@interface HBForm : UIViewController < UIActionSheetDelegate > {
	IBOutlet UIWebView *webRegi;
	NSString *sourceFile , *actionFile , *sourceType , *htmlForm , *nextPage , *primaryId , *json_response , *file_binary , *field_name , *sessionId;
	NSMutableDictionary *sourceParams;
	NSMutableArray *listViewResponse;
	NSMutableArray *formSelectVars;
	UIActionSheet *actionSheet1;
	IBOutlet UIImagePickerController *pickerPhoto;
//	UIPopoverController * temp_date_popover;
	id temp_date_popover;
}
-(UIImage *) scaleAndRotateImage: (UIImage *) image;
-(IBAction) btnBackPressed:(id)sender;
- (void)dateChange:(id)sender ;
- (void)dateDoneClicked;
- (void)dateCancelClicked;
@property(nonatomic,retain) NSMutableArray *listViewResponse;
@property(nonatomic,retain) NSMutableDictionary *sourceParams;
@property(nonatomic,retain) NSString *sourceFile;
@property(nonatomic,retain) NSString *actionFile;
@property(nonatomic,retain) NSString *sourceType;
@property(nonatomic,retain) NSString *htmlForm;
@property(nonatomic,retain) NSString *primaryId;
@property(nonatomic,retain) NSString *json_response;
@property(nonatomic,retain) NSString *nextPage;
@property(nonatomic,retain) NSString *file_binary;
@property(nonatomic,retain) NSString *field_name;
@property(nonatomic,retain) NSString *sessionId;
@property(nonatomic,retain) NSMutableArray *formSelectVars;
//@property(nonatomic,retain) UIPopoverController *temp_date_popover;
@property(nonatomic,retain) id temp_date_popover;
@end
