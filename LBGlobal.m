#import <UIKit/UIKit.h>
#import "Global.h"
#import "LBGlobal.h"
#include <objc/runtime.h>
#define LHBLog(fmt, ...) NSLog((@"%s[Breadcrumb] " fmt @"%s"), "\e[1;35m", ##__VA_ARGS__, "\x1B[0m")

@implementation LBGlobal

+(id)sharedInstance {
	static id sharedInstance = nil;
	static dispatch_once_t token = 0;
	dispatch_once(&token, ^{
		sharedInstance = [self new];
		CPDistributedMessagingCenter *messagingCenter;
		messagingCenter = [NSClassFromString(@"CPDistributedMessagingCenter") centerNamed:@"net.douglassoares.Breadcrumb"];
		rocketbootstrap_distributedmessagingcenter_apply(messagingCenter);
		[messagingCenter runServerOnCurrentThread];
		 
		[messagingCenter registerForMessageName:@"setShouldHideBreadcrumb" target:sharedInstance selector:@selector(setShouldHideBreadcrumb:userInfo:)];
		[messagingCenter registerForMessageName:@"shouldHideBreadcrumb" target:sharedInstance selector:@selector(shouldHideBreadcrumb:userInfo:)];
	});
	return sharedInstance;
}

-(bool)shouldHideBreadcrumb {
	return _shouldHideBreadcrumb;
}

-(void)setShouldHideBreadcrumb:(bool)shouldHideBreadcrumb {
	_shouldHideBreadcrumb = shouldHideBreadcrumb;
}

-(void)setShouldHideBreadcrumb:(NSString *)name userInfo:(NSDictionary *)userinfo {
	if([name isEqualToString:@"setShouldHideBreadcrumb"]){
		[self setShouldHideBreadcrumb:[[userinfo objectForKey:@"shouldHideBreadcrumb"] boolValue]];
	}
}

-(NSDictionary*)shouldHideBreadcrumb:(NSString *)name userInfo:(NSDictionary *)userInfo {
	if([name isEqualToString:@"shouldHideBreadcrumb"]){
		NSDictionary *info = [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:[self shouldHideBreadcrumb]] forKey:@"shouldHideBreadcrumb"];
		return info;
	} else
		return nil;
}

@end