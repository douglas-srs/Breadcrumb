#import "DSBreadcrumb.h"
#import "Global.h"

@implementation DSBreadcrumb

-(DSBreadcrumb*)initWithTitle:(NSString*)title andBundleId:(NSString*)bundleId {
	[self setTitle:title];
	[self setBundleId:bundleId];
	[self setNavigationContext:[NSClassFromString(@"UISystemNavigationActionDestinationContext") systemNavigationActionContextWithTitle:title bundleId:bundleId]];
	
	id switchAppBlock = ^ void () {
		CPDistributedMessagingCenter *messagingCenter = [NSClassFromString(@"CPDistributedMessagingCenter") centerNamed:@"net.douglassoares.Breadcrumb"];
		rocketbootstrap_distributedmessagingcenter_apply(messagingCenter);
		NSDictionary *userInfo = [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:YES] forKey:@"shouldHideBreadcrumb"];
		[messagingCenter sendMessageName:@"setShouldHideBreadcrumb" userInfo:userInfo];
		LSApplicationWorkspace *work = [NSClassFromString(@"LSApplicationWorkspace") new];
		[work openApplicationWithBundleID:_bundleId];
	};
	[self setHandler:switchAppBlock];

	UISystemNavigationAction *tempNavigation = [[NSClassFromString(@"UISystemNavigationAction") alloc] init];
	[self setNavigationAction:[[NSClassFromString(@"UISystemNavigationAction") alloc] initWithInfo:tempNavigation.info timeout:0 forResponseOnQueue:nil withHandler:switchAppBlock]];
	[self.navigationAction.info _setObject:_navigationContext forSetting:1];

	return self;
}

-(DSBreadcrumb*)initWithTitle:(NSString*)title andBundleId:(NSString*)bundleId withHandler:(id/*block*/)handler {
	[self setTitle:title];
	[self setBundleId:bundleId];
	[self setNavigationContext:[NSClassFromString(@"UISystemNavigationActionDestinationContext") systemNavigationActionContextWithTitle:title bundleId:bundleId]];
	
	DSBreadcrumb *context = self;

	id switchAppBlock = ^ void () {
		handler();
		[context hideBreadcrumb];
	};

	[self setHandler:switchAppBlock];

	UISystemNavigationAction *tempNavigation = [[NSClassFromString(@"UISystemNavigationAction") alloc] init];
	[self setNavigationAction:[[NSClassFromString(@"UISystemNavigationAction") alloc] initWithInfo:tempNavigation.info timeout:0 forResponseOnQueue:nil withHandler:switchAppBlock]];
	[self.navigationAction.info _setObject:_navigationContext forSetting:1];

	return self;
}

-(DSBreadcrumb*)initWithVisibleBreadcrumb {
	UISystemNavigationAction *currentBreadcrumb = [[UIApplication sharedApplication] _systemNavigationAction];
	UISystemNavigationActionDestinationContext *currentDestinationContext = [[currentBreadcrumb info] objectForSetting:1];

	[self setTitle:[currentDestinationContext title]];
	[self setBundleId:[currentDestinationContext bundleId]];
	[self setNavigationContext:currentDestinationContext];

	return self;
}

-(NSString*)bundleId {
	return _bundleId;
}

-(void)setBundleId:(NSString*)bundleId {
	_bundleId = bundleId;
	[_navigationContext setBundleId:bundleId];
}

-(NSString*)title {
	return _title;
}

-(void)setTitle:(NSString*)title {
	_title = title;
	[_navigationContext setTitle:title];
}

-(id)handler {
	return _handler;
}

-(void)setHandler:(id)handler {
	_handler = handler;
}

-(UISystemNavigationActionDestinationContext*)navigationContext {
	return _navigationContext;
}

-(void)setNavigationContext:(UISystemNavigationActionDestinationContext*)navigationContext{
	_navigationContext = navigationContext;
}

-(UISystemNavigationAction*)navigationAction {
	return _navigationAction;
}

-(void)setNavigationAction:(UISystemNavigationAction*)navigationAction{
	_navigationAction = navigationAction;
}

-(bool)isShowing {
	if ([[UIApplication sharedApplication] _systemNavigationAction])
		return YES;
	else
		return NO;
}

-(void)showBreadcrumb {
	[[UIApplication sharedApplication] _setSystemNavigationAction:_navigationAction];
}

-(void)hideBreadcrumb {
	[[UIApplication sharedApplication] _setSystemNavigationAction:nil];
}

@end