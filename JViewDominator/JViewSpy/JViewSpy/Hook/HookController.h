//
//  HookController.h
//  MemShower
//
//  Created by JinHackintosh on 13-5-8.
//
//

#import <Foundation/Foundation.h>

@class UIApplication;
@protocol HookControllerDelegate <NSObject>

- (void)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;

@end

@interface HookController : NSObject

+ (HookController*)instance;


@property (nonatomic,assign)id<HookControllerDelegate> delegate;

- (BOOL)hookWithDelegate:(id<HookControllerDelegate>)delegate;

@end
