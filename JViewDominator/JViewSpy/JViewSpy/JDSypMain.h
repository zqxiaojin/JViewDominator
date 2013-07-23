//
//  JDSypMain.h
//  JViewSpy
//
//  Created by Liang Jin on 7/20/13.
//  Copyright (c) 2013 Liang Jin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HookController.h"


@interface JDSypMain : NSObject<HookControllerDelegate>

+ (JDSypMain*)instance;


@end
