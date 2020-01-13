//
//  PZHURLProtocol.m
//  PureZhiHuDylib
//
//  Created by tylinux on 2019/6/2.
//  Copyright © 2019 tylinux. All rights reserved.
//

NSString *const kPZHURLProtocolKey = @"com.tylinux.purezhihu.request.key";

#import "PZHURLProtocol.h"

@interface PZHURLProtocol ()

@property (nonatomic) NSURLConnection *connection;

@end

@implementation PZHURLProtocol

+ (BOOL)canInitWithRequest:(NSURLRequest *)request
{
    NSLog(@"PureZhihu: URL: %@", request.URL.absoluteString);
    if ([NSURLProtocol propertyForKey:kPZHURLProtocolKey inRequest:request]) {
        return NO;
    }

    return YES;
}

+ (NSURLRequest *)canonicalRequestForRequest:(NSURLRequest *)request
{
    NSLog(@"PureZhihu: URL: %@", request.URL.absoluteString);
    NSMutableURLRequest *mutableReqeust = [request mutableCopy];
    [NSURLProtocol setProperty:@YES
                        forKey:kPZHURLProtocolKey
                     inRequest:mutableReqeust];
    return [mutableReqeust copy];
}

- (void)startLoading
{
    NSLog(@"PureZhihu: URL: %@", self.request.URL.absoluteString);
    NSString *regex = @"https://api.zhihu.com/appview/api/v4/answers/.*/recommendations";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if ([predicate evaluateWithObject:self.request.URL.absoluteString]) {
        [self.client URLProtocolDidFinishLoading:self];
        [self.connection cancel];
        self.connection = nil;
        return;
    }
    self.connection = [NSURLConnection connectionWithRequest:[PZHURLProtocol canonicalRequestForRequest:self.request]
                                                    delegate:self];
}

- (void)stopLoading
{
    [self.connection cancel];
    self.connection = nil;
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [self.client URLProtocol:self didReceiveResponse:response cacheStoragePolicy:NSURLCacheStorageNotAllowed];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.client URLProtocol:self didLoadData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [self.client URLProtocolDidFinishLoading:self];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [self.client URLProtocol:self didFailWithError:error];
}


@end
