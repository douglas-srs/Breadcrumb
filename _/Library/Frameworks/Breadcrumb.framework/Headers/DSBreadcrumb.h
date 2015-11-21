#import <UIKit/UIKit.h>
#import "headers.h"

@interface DSBreadcrumb : NSObject {
	NSString *_bundleId;
	NSString *_title;
	id /*block*/ _handler;
	UISystemNavigationActionDestinationContext *_navigationContext;
	UISystemNavigationAction *_navigationAction;
}

@property (nonatomic, retain) NSString *bundleId;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) id handler;
@property (nonatomic, retain) UISystemNavigationActionDestinationContext *navigationContext;
@property (nonatomic, retain) UISystemNavigationAction *navigationAction;
-(DSBreadcrumb*)initWithTitle:(NSString*)title andBundleId:(NSString*)bundleId;
-(DSBreadcrumb*)initWithTitle:(NSString*)title andBundleId:(NSString*)bundleId withHandler:(id/*block*/)handler;
-(DSBreadcrumb*)initWithVisibleBreadcrumb;
-(NSString*)bundleId;
-(void)setBundleId:(NSString*)bundleId;
-(NSString*)title;
-(void)setTitle:(NSString*)title;
-(id)handler;
-(UISystemNavigationActionDestinationContext*)navigationContext;
-(void)setNavigationContext:(UISystemNavigationActionDestinationContext*)navigationContext;
-(UISystemNavigationAction*)navigationAction;
-(void)setNavigationAction:(UISystemNavigationAction*)navigationAction;
-(bool)isShowing;
-(void)showBreadcrumb;
-(void)hideBreadcrumb;

@end
