#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "ASINetworkQueue.h"
#import "CustomAlertView.h"
#import <CommonCrypto/CommonDigest.h>

#import "HBAppDb.h"
//#import "AlertHandler.h"


@protocol HBLibDeligate;
@interface HBLib : NSObject {
	CustomAlertView *custView;
}


+(void) setBaseURL :(NSString*)base;
+(NSString *) getBaseURL;
+(void) checkCalled ;
+(void) checkDevice;
+(NSMutableDictionary *) urlStringToArr : (NSString *) stringData;
+(NSString *) convertDate :(NSString *) inputFormat : (NSString *) outputFormat  :(NSString *) date;
+(NSString *) md5:(NSString*)input;
+(BOOL) resourceFileExists :(NSString*)file_name;
+(BOOL) resourceFileExists:(NSString *)file_name :(NSString *)file_type ;
+(NSString *) getLangImage:(NSString*)imageName;
+(void) updateElementByLang:(NSArray *) viewArray;

+(NSMutableArray *) getArrayFromURL : (NSString *)URL;
+(NSMutableArray *) getArrayFromURL : (NSString *)URL :(NSDictionary *) postData;
+(NSMutableArray *) getArrayFromURL : (NSString *)URL caching:(BOOL)caching :(int) timeInterval;
+(NSMutableArray *) getArrayFromURL : (NSString *)URL setData:(NSDictionary *) postData setCache:(BOOL)caching;
+(NSMutableArray *) getArrayFromURL : (NSString *)URL :(NSDictionary *) postData : (BOOL) caching : (int) timeInterval;

-(void) getArrayFromURLASYNS : (NSString *)URL;
-(void) getArrayFromURLASYNS : (NSString *)URL :(NSDictionary *) postData;
-(void) getArrayFromURLASYNS : (NSString *)URL caching:(BOOL)caching :(int) timeInterval;
-(void) getArrayFromURLASYNS : (NSString *)URL setData:(NSDictionary *) postData setCache:(BOOL)caching;
-(void) getArrayFromURLASYNS : (NSString *)URL :(NSDictionary *) postData : (BOOL) caching : (int) timeInterval;
-(void) processRequestString : (NSString *) responseString;
+(NSMutableArray *) getArrayFromDB : (NSString *)actionType :(NSMutableDictionary *) postData;
+(NSMutableArray *) getArrayFromDB : (NSString *)actionType; 
+(UIImage *) getImageFromURL :(NSString*)image_url;
-(NSString *) getURLString : (NSString *)URL :(NSDictionary *) postData;

-(void) showAlertWithMessage : (NSString *) strMsg ;
-(void) showAlertWithMessage : (NSString *) strMsg : (NSString *) strTitle ;
-(void) hideAlert ;

@property (nonatomic, assign) id <HBLibDeligate> delegate;
@property (nonatomic, retain) CustomAlertView *custView;
@end

@protocol HBLibDeligate <NSObject>
@optional
- (void)getSuccessResponseArrayOfCall:(NSMutableArray *) responseArray;
- (void)getFailourResponseCall:(NSString *) err_message;
@end