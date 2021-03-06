#define LHBLog(fmt, ...) NSLog((@"%s[Breadcrumb] " fmt @"%s"), "\e[1;35m", ##__VA_ARGS__, "\x1B[0m")
#import <substrate.h>
#import <Global.h>
#import <DSGlobal.h>

%hook SBMainDisplaySceneManager
	- (_Bool)_shouldBreadcrumbApplication:(id)arg1 withTransitionContext:(id)arg2 {
		if (IN_SPRINGBOARD){
			if ([[DSGlobal sharedInstance] shouldHideBreadcrumb]){
				[[DSGlobal sharedInstance] setShouldHideBreadcrumb:NO];
				return NO;
			}
			else
				return %orig;
		}
		else {
			CPDistributedMessagingCenter *messagingCenter = [NSClassFromString(@"CPDistributedMessagingCenter") centerNamed:@"net.douglassoares.Breadcrumb"];
			rocketbootstrap_distributedmessagingcenter_apply(messagingCenter);
			LHBLog(@"will try to sendMessage and receiveReply");
			NSDictionary* reply = [messagingCenter sendMessageAndReceiveReplyName:@"shouldHideBreadcrumb" userInfo:nil error:nil];
			LHBLog(@"dictionary %@", reply);
			if ([[reply objectForKey:@"shouldHideBreadcrumb"] boolValue]){
				NSDictionary *userInfo = [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:NO] forKey:@"shouldHideBreadcrumb"];
				[messagingCenter sendMessageName:@"setShouldHideBreadcrumb" userInfo:userInfo];
				return NO;
			} else
				return %orig;
		}
	}
%end

%ctor {

	if (IN_SPRINGBOARD){
		[DSGlobal sharedInstance];
	}

	LHBLog(@"Everything looks good.");
}
