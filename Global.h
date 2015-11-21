#define prefFile "/var/mobile/Library/Preferences/net.douglassoares.libBreadcrumb.plist"
#ifndef IN_SPRINGBOARD
#define IN_SPRINGBOARD ([[NSBundle mainBundle].bundleIdentifier isEqualToString:@"com.apple.springboard"])
#endif
#import "headers.h"
#import <RocketBootstrap/rocketbootstrap.h>