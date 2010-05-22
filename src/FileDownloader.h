//
//  FileDownloader.h
//  palea
//
//  Created by Giles Alexander on 30/08/09.
//  Copyright 2009 Silverbrook Research. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileDownloader : NSObject
{
  id owner;
  NSURL *source;

  NSMutableData *content;
  NSURLRequest *request;
  NSURLConnection *connection;
  BOOL failed;
}

- (id)initWithOwner:(id)a_owner
                url:(NSURL *)url;

- (void)download;
- (void)cancel;

@end
