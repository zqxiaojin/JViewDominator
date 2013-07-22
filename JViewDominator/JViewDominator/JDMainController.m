//
//  JDMainController.m
//  JViewDominator
//
//  Created by Liang Jin on 7/20/13.
//  Copyright (c) 2013 Liang Jin. All rights reserved.
//

#import "JDMainController.h"
#import "JDServiceManager.h"

@interface JDMainController ()

@property (nonatomic,strong)JDServiceManager* serviceManager;

@end

@implementation JDMainController

@synthesize serviceManager = m_serviceManager;

- (id)init
{
    self = [super init];
    if (self)
    {
        self.serviceManager = [[JDServiceManager alloc] init];
        [m_serviceManager start];
    }
    return self;
}

@end
