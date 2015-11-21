@protocol BSXPCCoding <NSObject>
@end

@interface UISystemNavigationActionDestinationContext : NSObject <BSXPCCoding> {
    NSString *_bundleId;
    NSString *_title;
}

@property (nonatomic, copy) NSString *bundleId;
@property (nonatomic, copy) NSString *title;

+ (id)systemNavigationActionContextWithTitle:(NSString*)title bundleId:(NSString*)bundleId;

- (NSString*)bundleId;
- (void)setBundleId:(NSString*)bundleId;
- (void)setTitle:(NSString*)title;
- (NSString*)title;

@end

@interface LSApplicationWorkspace : NSObject
	- (BOOL)openApplicationWithBundleID:(id)arg1;
@end

@interface CPDistributedMessagingCenter : NSObject
	+ (id)centerNamed:(id)arg1;
	- (void)runServerOnCurrentThread;
	- (void)registerForMessageName:(id)arg1 target:(id)arg2 selector:(SEL)arg3;
	- (BOOL)sendMessageName:(id)arg1 userInfo:(id)arg2;
	- (void)sendMessageAndReceiveReplyName:(id)arg1 userInfo:(id)arg2 toTarget:(id)arg3 selector:(SEL)arg4 context:(void*)arg5;
	- (id)sendMessageAndReceiveReplyName:(id)arg1 userInfo:(id)arg2;
	- (BOOL)doesServerExist;
	- (id)sendMessageAndReceiveReplyName:(id)arg1 userInfo:(id)arg2 error:(id*)arg3;
@end
