@interface DSGlobal : NSObject {
	bool _shouldHideBreadcrumb;
}
@property (assign) bool shouldHideBreadcrumb;
+(id)sharedInstance;
-(bool)shouldHideBreadcrumb;
-(void)setShouldHideBreadcrumb:(bool)shouldHideBreadcrumb;
-(void)setShouldHideBreadcrumb:(NSString *)name userInfo:(NSDictionary *)userinfo;
-(NSDictionary*)shouldHideBreadcrumb:(NSString *)name userInfo:(NSDictionary *)userInfo;
@end