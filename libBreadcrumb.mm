#define LHBLog(fmt, ...) NSLog((@"%s[libBreadcrumb] " fmt @"%s"), "\e[1;35m", ##__VA_ARGS__, "\x1B[0m")

%hook SBMainDisplaySceneManager
	
	- (_Bool)_shouldBreadcrumbApplication:(SBWorkspaceApplication *)arg1 withTransitionContext:(id)arg2 {
		LHBLog(@"HOOK OK");
		return NO;
	}

%end

%ctor
	LHBLog(@"Testando ctor!!!");
%end
