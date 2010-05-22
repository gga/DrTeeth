//
//  NSObject+fileDownload.m
//  palea
//
//  Created by Giles Alexander on 30/08/09.
//

#import "NSObject+fileDownload.h"

@implementation NSObject (fileDownload)

- (void)downloader:(FileDownloader *)downloader
           gotData:(NSData *)data
{
}

- (void)downloader:(FileDownloader *)downloader
           gotData:(NSData *)data
          withInfo:(void*)info
{
}

- (void)downloader:(FileDownloader *)downloader
            failed:(NSString *)error
{
}

- (void)downloaderDidComplete:(FileDownloader *)downloader
{
}

@end
