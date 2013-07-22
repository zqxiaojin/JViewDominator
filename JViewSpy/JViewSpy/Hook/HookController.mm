//
//  HookController.m
//  MemShower
//
//  Created by JinHackintosh on 13-5-8.
//
//

#import "HookController.h"
#import "CocoaHook.h"
#import <UIKit/UIKit.h>



@implementation HookController

+ (HookController*)instance
{
	static HookController* g_m = [[HookController alloc] init];
	return g_m;
}

- (id)init
{
	self = [super init];
	
	if (self)
	{
		
	}
	return self;
}

- (BOOL)isTarget:(id<UIApplicationDelegate>)application
{
    return YES;
}

- (void)start
{
	id<UIApplicationDelegate> appdelegate = [[UIApplication sharedApplication] delegate];
	
	if ([self isTarget:appdelegate])
	{
		OBJC_EXCHANGE_NEWCLASS_METHOD_AUTO(object_getClassName([appdelegate class]),"application:didFinishLaunchingWithOptions:"
										   ,"HookController","_application:didFinishLaunchingWithOptions:");
	}
}

- (BOOL)hookWithDelegate:(id<HookControllerDelegate>)delegate
{
    BOOL result = OBJC_EXCHANGE_NEWCLASS_METHOD_AUTO("UIApplication"
                                       ,"setDelegate:"
                                       ,"HookController"
                                       ,"setUIApplicationDelegate:");
    assert(result);
    if (result)
    {
        self.delegate = delegate;
    }
    return result;
}

- (void)setUIApplicationDelegate:(id)delegate
{
    [self setUIApplicationDelegate:delegate];
    
    [[HookController instance] start];
}


- (BOOL)_application:(id)application didFinishLaunchingWithOptions:(id)launchOptions
{
	BOOL result = [self _application:application didFinishLaunchingWithOptions:launchOptions];
	
    [[[HookController instance] delegate] application:application didFinishLaunchingWithOptions:launchOptions];
    
	return result;
}





@end


