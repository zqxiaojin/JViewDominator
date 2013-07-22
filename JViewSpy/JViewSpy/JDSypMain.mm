//
//  JDSypMain.m
//  JViewSpy
//
//  Created by Liang Jin on 7/20/13.
//  Copyright (c) 2013 Liang Jin. All rights reserved.
//

#import "JDSypMain.h"
#import <UIKit/UIKit.h>
#import "JDNetClient.h"

@interface JDSypMain ()
@property (nonatomic,strong)JDNetClient* netClient;
@end

@implementation JDSypMain

+ (JDSypMain*)instance
{
    static JDSypMain* ins = [[JDSypMain alloc] init];
    return ins;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        
    }
    return self;
}

#pragma mark - for HookControllerDelegate

- (void)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
//    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Hack success"
//                                                    message:[[NSBundle mainBundle] bundleIdentifier]
//                                                   delegate:nil
//                                          cancelButtonTitle:@"OK"
//                                          otherButtonTitles:nil , nil];
//	
//    [alert show];
    self.netClient = [[JDNetClient alloc] init];
    [self.netClient start];
}


@end
