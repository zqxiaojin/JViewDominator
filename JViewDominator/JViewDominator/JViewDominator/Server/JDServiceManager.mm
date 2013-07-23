//
//  JDServiceManager.m
//  JViewDominator
//
//  Created by Liang Jin on 7/20/13.
//  Copyright (c) 2013 Liang Jin. All rights reserved.
//

#import "JDServiceManager.h"

#define DEBUG_LOG_NS

#ifdef DEBUG_LOG_NS
#define LOG_NS NSLog
#else /*DEBUG_LOG_NS*/
#define LOG_NS(...)
#endif/*DEBUG_LOG_NS*/

#define kWebServiceType @"_JVD._tcp."
#define kInitialDomain  @"local"



@interface JDServiceManager ()<NSNetServiceBrowserDelegate>

@property (nonatomic,strong)NSNetServiceBrowser* netService;

@end

@implementation JDServiceManager

@synthesize netService = m_netService;

- (id)init
{
    if (self = [super init])
    {
        self.netService = [[NSNetServiceBrowser alloc] init];
        [m_netService setDelegate:self];

    }
    return self;
}

- (void)start
{
    [m_netService searchForServicesOfType:kWebServiceType inDomain:kInitialDomain];
}

#pragma mark - for NSNetServiceBrowserDelegate
- (void)netServiceBrowser:(NSNetServiceBrowser *)aNetServiceBrowser didFindDomain:(NSString *)domainString moreComing:(BOOL)moreComing
{
    LOG_NS(@"%@ find domain:%@",aNetServiceBrowser, domainString);
}

- (void)netServiceBrowser:(NSNetServiceBrowser *)aNetServiceBrowser didFindService:(NSNetService *)aNetService moreComing:(BOOL)moreComing
{
    LOG_NS(@"%@ find service:%@",aNetServiceBrowser, aNetService);

}

- (void)netServiceBrowser:(NSNetServiceBrowser *)aNetServiceBrowser didRemoveDomain:(NSString *)domainString moreComing:(BOOL)moreComing;
{
    LOG_NS(@"%@ remove domain:%@",aNetServiceBrowser, domainString);

}

- (void)netServiceBrowser:(NSNetServiceBrowser *)aNetServiceBrowser didRemoveService:(NSNetService *)aNetService moreComing:(BOOL)moreComing
{
    LOG_NS(@"%@ remove service:%@",aNetServiceBrowser, aNetService);

}

- (void)netService:(NSNetService *)sender didNotResolve:(NSDictionary *)errorDict
{
    LOG_NS(@"%@ error service:%@",sender, errorDict);

}
@end
