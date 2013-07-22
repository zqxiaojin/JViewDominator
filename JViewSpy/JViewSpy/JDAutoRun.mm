//
//  JDAutoRun.m
//  JViewSpy
//
//  Created by Liang Jin on 7/20/13.
//  Copyright (c) 2013 Liang Jin. All rights reserved.
//

#import "JDAutoRun.h"
#import "HookController.h"
#import "JDSypMain.h"
JDAutoRun spy;

JDAutoRun::JDAutoRun()
{
    [[HookController instance] hookWithDelegate:[JDSypMain instance]];
}