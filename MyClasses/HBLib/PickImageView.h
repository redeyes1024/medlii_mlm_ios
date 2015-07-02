//
//  PickImageView.h
//  ImagePicker
//
//  Created by HB17 on 8/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NSString;

@interface NSData (MBBase64)

+ (NSData *) dataFromBase64String: (NSString *) base64String;
- (id) initWithBase64String: (NSString *) base64String;
- (NSString *) base64EncodedString;

@end


@interface PickImageView : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate> {
	UIImagePickerController *pickerPhoto;
	IBOutlet UIImageView *ImgPhoto;
	NSString *field_name;
}
@property(nonatomic,retain)UIImagePickerController *pickerPhoto;
@property(nonatomic,retain) NSString *field_name;
-(void)PickImageClick:(id)sender;
-(void)PickImage;
-(UIImage *) scaleAndRotateImage: (UIImage *) image;
@end
