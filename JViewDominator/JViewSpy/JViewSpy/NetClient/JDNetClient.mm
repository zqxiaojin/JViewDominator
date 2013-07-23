//
//  JDNetClient.m
//  JViewSpy
//
//  Created by Liang Jin on 7/20/13.
//  Copyright (c) 2013 Liang Jin. All rights reserved.
//
#import "JDNetClient.h"
#include <sys/socket.h>
#include <netinet/in.h>


#define kWebServiceType @"_JVD._tcp."
#define kInitialDomain  @"local."

@interface JDNetClient ()<NSNetServiceDelegate>

@property (nonatomic,strong)NSNetService* netService;

@end

@implementation JDNetClient

- (id)init
{
    self = [super init];
    if (self)
    {
        int                 err = EAFNOSUPPORT;
        int                 fdForListening;
        int                 chosenPort;
        socklen_t           namelen;
        
//        assert( ! self.isRunning );
//        assert(_listeningSocket == NULL);
        assert(self.netService == nil);
        
        chosenPort = -1;        // quieten assert
        
        // Here, create the socket from traditional BSD socket calls, and then set up a CFSocket with that to listen for
        // incoming connections.
        
        // Start by trying to do everything with IPv6.  This will work for both IPv4 and IPv6 clients
        // via the miracle of mapped IPv4 addresses.
        
//        if (self->_debugOptions & kDebugOptionMaskForceIPv4) {
//            // This allows us to test IPv4 support on an IPv6-capable kernel.
//            fdForListening = -1;
//            err = EAFNOSUPPORT;
//        } else {
//            err = 0;
//            fdForListening = socket(AF_INET6, SOCK_STREAM, 0);
//            if (fdForListening < 0) {
//                err = errno;
//            }
//        }
        if (err == 0) {
            struct sockaddr_in6 serverAddress6;
            
            // If we created an IPv6 socket, bind it to a kernel-assigned port and then use
            // getsockname to determine what port we got.
            
            memset(&serverAddress6, 0, sizeof(serverAddress6));
            serverAddress6.sin6_family = AF_INET6;
            serverAddress6.sin6_len    = sizeof(serverAddress6);
            
            err = bind(fdForListening, (const struct sockaddr *) &serverAddress6, sizeof(serverAddress6));
            if (err < 0) {
                err = errno;
            }
            if (err == 0) {
                namelen = sizeof(serverAddress6);
                err = getsockname(fdForListening, (struct sockaddr *) &serverAddress6, &namelen);
                if (err < 0) {
                    err = errno;
                    assert(err != 0);       // quietens static analyser
                } else {
                    chosenPort = ntohs(serverAddress6.sin6_port);
                }
            }
        } else if (err == EAFNOSUPPORT) {
            struct sockaddr_in  serverAddress;
            
            // IPv6 is not available (this can happen, for example, on the iPhone OS 3 kerne).
            // Let's fall back to IPv4.  Create an IPv4 socket, bind it to a kernel-assigned port
            // and then use getsockname to determine what port we got.
            
            err = 0;
            fdForListening = socket(AF_INET, SOCK_STREAM, 0);
            if (fdForListening < 0) {
                err = errno;
            }
            
            if (err == 0) {
                memset(&serverAddress, 0, sizeof(serverAddress));
                serverAddress.sin_family = AF_INET;
                serverAddress.sin_len    = sizeof(serverAddress);
                
                err = bind(fdForListening, (const struct sockaddr *) &serverAddress, sizeof(serverAddress));
                if (err < 0) {
                    err = errno;
                }
            }
            if (err == 0) {
                namelen = sizeof(serverAddress);
                err = getsockname(fdForListening, (struct sockaddr *) &serverAddress, &namelen);
                if (err < 0) {
                    err = errno;
                    assert(err != 0);       // quietens static analyser
                } else {
                    chosenPort = ntohs(serverAddress.sin_port);
                }
            }
        }
        
        // Listen for connections on our socket, then create a CFSocket to route any connections
        // to a run loop based callback.
        
//        if (err == 0) {
//            err = listen(fdForListening, 5);
//            if (err < 0) {
//                err = errno;
//            } else {
//                CFSocketContext     context = {0, self, NULL, NULL, NULL};
//                CFRunLoopSourceRef  rls;
//                
//                self->_listeningSocket = CFSocketCreateWithNative(NULL, fdForListening, kCFSocketAcceptCallBack, ListeningSocketCallback, &context);
//                if (self->_listeningSocket != NULL) {
//                    assert( CFSocketGetSocketFlags(self->_listeningSocket) & kCFSocketCloseOnInvalidate );
//                    fdForListening = -1;        // so that the clean up code doesn't close it
//                    
//                    rls = CFSocketCreateRunLoopSource(NULL, self->_listeningSocket, 0);
//                    assert(rls != NULL);
//                    
//                    CFRunLoopAddSource(CFRunLoopGetCurrent(), rls, kCFRunLoopDefaultMode);
//                    
//                    CFRelease(rls);
//                }
//            }
//        }
        NSString* name = [NSString stringWithFormat:@"%@, %d" ,@"JViewSpy" ,arc4random()];
        self.netService = [[NSNetService alloc] initWithDomain:kInitialDomain type:kWebServiceType name:name port:chosenPort];
    }
    return self;
}

- (void)start
{
//    NSRunLoop* runLoop = [NSRunLoop currentRunLoop];
//    [self.netService scheduleInRunLoop:runLoop forMode:[runLoop currentMode]];
    [self.netService setDelegate:self];
    [self.netService publish];
}

/* Sent to the NSNetService instance's delegate prior to advertising the service on the network. If for some reason the service cannot be published, the delegate will not receive this message, and an error will be delivered to the delegate via the delegate's -netService:didNotPublish: method.
 */
- (void)netServiceWillPublish:(NSNetService *)sender;
{
    
}
/* Sent to the NSNetService instance's delegate when the publication of the instance is complete and successful.
 */
- (void)netServiceDidPublish:(NSNetService *)sender;
{
    
}
/* Sent to the NSNetService instance's delegate when an error in publishing the instance occurs. The error dictionary will contain two key/value pairs representing the error domain and code (see the NSNetServicesError enumeration above for error code constants). It is possible for an error to occur after a successful publication.
 */
- (void)netService:(NSNetService *)sender didNotPublish:(NSDictionary *)errorDict;
{
    
}
/* Sent to the NSNetService instance's delegate prior to resolving a service on the network. If for some reason the resolution cannot occur, the delegate will not receive this message, and an error will be delivered to the delegate via the delegate's -netService:didNotResolve: method.
 */
- (void)netServiceWillResolve:(NSNetService *)sender;
{
    
}
/* Sent to the NSNetService instance's delegate when one or more addresses have been resolved for an NSNetService instance. Some NSNetService methods will return different results before and after a successful resolution. An NSNetService instance may get resolved more than once; truly robust clients may wish to resolve again after an error, or to resolve more than once.
 */
- (void)netServiceDidResolveAddress:(NSNetService *)sender;
{
    
}
/* Sent to the NSNetService instance's delegate when an error in resolving the instance occurs. The error dictionary will contain two key/value pairs representing the error domain and code (see the NSNetServicesError enumeration above for error code constants).
 */
- (void)netService:(NSNetService *)sender didNotResolve:(NSDictionary *)errorDict;
{
    
}
/* Sent to the NSNetService instance's delegate when the instance's previously running publication or resolution request has stopped.
 */
- (void)netServiceDidStop:(NSNetService *)sender;
{
    
}
/* Sent to the NSNetService instance's delegate when the instance is being monitored and the instance's TXT record has been updated. The new record is contained in the data parameter.
 */
- (void)netService:(NSNetService *)sender didUpdateTXTRecordData:(NSData *)data;
{
    
}
@end
