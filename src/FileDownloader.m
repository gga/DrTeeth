//
//  FileDownloader.m
//  palea
//
//  Created by Giles Alexander on 30/08/09.
//  Copyright 2009 Silverbrook Research. All rights reserved.
//

#import "FileDownloader.h"
#import "NSObject+fileDownload.h"


@implementation FileDownloader

- (id)initWithOwner:(id)a_owner
                url:(NSURL *)url
{
  if (self = [super init])
  {
    owner = [a_owner retain];
    failed = NO;
    content = [[NSMutableData data] retain];
  }
  return self;
}

- (void)dealloc
{
  [owner release];
  [source release];
  [content release];
  [connection release];
  [super dealloc];
}

- (void)cancel
{
  [connection cancel];
}

- (void)download
{
  request = [[NSURLRequest alloc] initWithURL:source
                                  cachePolicy:NSURLRequestReturnCacheDataElseLoad
                              timeoutInterval:60.0];
  connection = [[NSURLConnection connectionWithRequest:request
                                delegate:self] retain];
}

- (void)generalFailure:(NSString *)additional
{
  NSString *l_msg;
  if (additional)
  {
    l_msg = [NSString stringWithFormat:@"Could not download %@, because %@", [source absoluteString], additional];
  }
  else
  {
    l_msg = [NSString stringWithFormat:@"Could not download %@", [source absoluteString]];
  }
  [owner downloader:self
             failed:l_msg];
}

- (void)connection:(NSURLConnection *)connection
    didReceiveData:(NSData *)data
{
  [content appendData:data];
}

- (void)connection:(NSURLConnection *)connection
didReceiveResponse:(NSURLResponse *)response
{
  // Cache this response
//  [[NSURLCache sharedURLCache] storeCachedResponse:[[NSCachedURLResponse alloc] initWithResponse:response
//                                                                                            data:content]
//                                        forRequest:request];
  // Don't want that old request any more
  [request release];

  if ([response isKindOfClass:[NSHTTPURLResponse class]])
  {
    NSHTTPURLResponse *l_httpResp = (NSHTTPURLResponse *)response;
    if ([l_httpResp statusCode] >= 400)
    {
      // This request has failed
      failed = YES;
      [self generalFailure:nil];
    }
  }
}

- (void)connection:(NSURLConnection *)connection
  didFailWithError:(NSError *)error
{
  failed = YES;
  [self generalFailure:[error localizedDescription]];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
  if (!failed)
  {
    [owner downloader:self gotData:content];
    [owner downloaderDidComplete:self];
  }
}

@end
