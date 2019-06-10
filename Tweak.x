#import "PZHURLProtocol.h"

// 去掉『市场』tab
%hook  ZHInitialTabBarController

- (NSArray *)tabs
{
	NSArray *ret = %orig;
	NSMutableArray *mutRet = [NSMutableArray array];
	[mutRet removeObjectAtIndex:2];
	return mutRet.copy;
}

%end


// 去掉开屏广告
%hook ZHADStartupItem

- (void)handleUIApplicationDidBecomeActiveNotification:(id)arg1
{
	return ;
}
- (void)setupLaunchingAD:(id)arg1
{
	return;
}
- (void)setupFocusAD:(id)arg1
{
	return;
}
- (void)registerListADInitializer
{
	return ;
}
- (void)setupCanvasVideoAutoPlay
{
	return ;
}

%end

// 去掉 FEED 流广告

%hook ZHFeedADWrap

- (id)initWithProperties:(id)arg1
{
	return nil;
}

%end

// // 去掉FEED流里的 LIVE 推荐
// %hook ZHKMFeed

// - (id)init
// {
// 	return nil;
// }

// %end

// 去掉答案后边的广告
%hook ZHAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	[NSURLProtocol registerClass:NSClassFromString(@"PZHURLProtocol")];
	//注册scheme
    Class cls = NSClassFromString(@"WKBrowsingContextController");
    SEL sel = NSSelectorFromString(@"registerSchemeForCustomProtocol:");
    if ([cls respondsToSelector:sel]) {
		#pragma clang diagnostic push
		#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [cls performSelector:sel withObject:@"http"];
        [cls performSelector:sel withObject:@"https"];
		#pragma clang diagnostic pop
    }
	BOOL result = %orig;
	return result;
}

%end

// 去掉评论中的广告
%hook ZHCommentViewController

- (void)fetchADWithSignal:(id)arg1
{
    return ;
}

%end
