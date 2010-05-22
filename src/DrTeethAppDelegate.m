//
//  DrTeethAppDelegate.m
//  DrTeeth
//
//  Created by Giles Alexander on 22/05/10.
//  Copyright Silverbrook Research 2010. All rights reserved.
//

#import "DrTeethAppDelegate.h"
#import "DrTeethViewController.h"
#import "FileDownloader.h"
#import "GDataXMLNode.h"

@implementation DrTeethAppDelegate

@synthesize window;
@synthesize viewController;
@synthesize blogEntries;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

  FileDownloader *blog = [[[FileDownloader alloc] initWithOwner: self
                                                            url:[NSURL URLWithString:@"http://blogs.thoughtworks.com/atom.xml"]] autorelease];
  [blog download];

  // Override point for customization after app launch
  [window addSubview:viewController.view];
  [window makeKeyAndVisible];

  return YES;
}


- (void)dealloc {
  [blogEntries release];
  [viewController release];
  [window release];
  [super dealloc];
}


- (void)downloader:(FileDownloader *)downloader
           gotData:(NSData *)data
{
  NSError *err;
  GDataXMLDocument *doc = [[[GDataXMLDocument alloc] initWithData:data options:0 error:&err] autorelease];
  self.blogEntries = [doc nodesForXPath:@"/atom:feed/atom:entry" namespaces:[NSDictionary dictionaryWithObject:@"http://www.w3.org/2005/Atom" forKey:@"atom"] error:nil];
}

- (void)downloader:(FileDownloader *)downloader
            failed:(NSString *)error
{
	NSLog(@"downloader failed: %@.", error);
}

- (void)downloaderDidComplete:(FileDownloader *)downloader
{
}

@end
