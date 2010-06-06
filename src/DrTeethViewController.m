//
//  DrTeethViewController.m
//  DrTeeth
//
//  Created by Giles Alexander on 22/05/10.
//  Copyright Silverbrook Research 2010. All rights reserved.
//

#import "DrTeethViewController.h"
#import "TWBlogsController.h"

@interface UIView (extended)
- (void) startHeartbeat: (SEL) aSelector inRunLoopMode: (id) mode;
- (void) stopHeartbeat: (SEL) aSelector;
@end

@interface DrTeethViewController ()

- (void) coverFlowStart;
- (void) coverFlowStop;

- (void)rightToLeftSwipe;
- (void)leftToRightSwipe;

@end

@implementation DrTeethViewController

@synthesize covers;
@synthesize cfView;


/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

// - (SEL)selector
// {
//   return @selector(apply);
// }

// - (void)apply
// {
//   void (^block)(void) = (id)self;
//   block();
// }

// - (id)initWithBlock:(BasicBlock)block
// {
//   if (self = [super init])
//     [self initWithTarget:block action:block.selector];
//   return self;
// }

- (void)viewDidLoad
{
  [super viewDidLoad];
  [meContainer addSubview: credentials];

	[self.cfView setUserInteractionEnabled:YES];

	[self.cfView.cfLayer selectCoverAtIndex:2];
	[self.cfView.cfLayer setDelegate:self];
	[self.cfView.cfLayer setDisplayedOrientation: UIInterfaceOrientationPortrait animate:NO];

  // Attach the swipe recognizers
//   ^(id recog){
//     recog.direction = UISwipeGestureRecognizerDirectionLeft;
//     [self.view addGestureRecognizer:recog];
//   }(
//   UISwipeGestureRecognizer *rtl = [[UISwipeGestureRecognizer alloc] initWithBlock:^{
//       NSLog(@"Right to left swipe detected.");
//     }]
  UISwipeGestureRecognizer *rtl = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(rightToLeftSwipe)];
  rtl.direction = UISwipeGestureRecognizerDirectionLeft;
//   [self.view addGestureRecognizer:rtl];
  UISwipeGestureRecognizer *ltr = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(leftToRightSwipe)];
  ltr.direction = UISwipeGestureRecognizerDirectionRight;
//   [self.view addGestureRecognizer:ltr];
}

- (void)viewWillAppear:(BOOL)animated
{
	[self coverFlowStart];
}

- (void)viewDidDisappear:(BOOL)animated
{
  [self coverFlowStop];
}

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];

    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

- (void)showBlogs:(id)sender
{
  TWBlogsController *blogs = [[[TWBlogsController alloc] initWithNibName:@"TWBlogsController"
                                                                  bundle:nil] autorelease];
  [self presentModalViewController:blogs animated:YES];
}

- (void)showCollateral
{
  unsigned int selectedCollateral = [self.cfView.cfLayer indexOfSelectedCover];
  NSString *dirPath = [NSString stringWithFormat:@"portfolios/%d", selectedCollateral];
  NSString *hrefFile = [[NSBundle mainBundle] pathForResource:@"href" ofType:nil inDirectory:dirPath];
  NSString *href = [NSString stringWithContentsOfFile:hrefFile
                                             encoding:NSUTF8StringEncoding
                                                error:NULL];
}

- (void)signIn:(id)sender
{
  NSLog(@"signIn boyo");
}

- (void)dealloc {
  [super dealloc];
}


- (void) coverFlowStart
{
	[self.cfView startHeartbeat: @selector(tick) inRunLoopMode: (id)kCFRunLoopDefaultMode];
	[self.cfView.cfLayer transitionIn:1.0f];
}

- (void) coverFlowStop
{
	[self.cfView.cfLayer transitionOut:1.0f];
	[self.cfView stopHeartbeat: @selector(tick)];
}

/*
  CoverFlowHost methods
 */
- (int) coverCount
{
	if (self.covers == nil)
	{
		self.covers = [NSArray array];
		// Load the images
		for (int i = 0; i < 6; ++i)
		{
			NSString *imgPath = [NSString stringWithFormat:@"portfolios/%d/thumbnail.jpg", i];
			UIImage *img = [UIImage imageNamed:imgPath];
			self.covers = [self.covers arrayByAddingObject: img];
		}
	}
	return [self.covers count];
}

- (void) doubleTapCallback
{
  [self showCollateral];
}

- (void)rightToLeftSwipe
{
  NSLog(@"Right to left swipe detected.");
}

- (void)leftToRightSwipe
{
  NSLog(@"Left to right swipe detected.");
}

// *********************************************
// Coverflow delegate methods
//
- (void) coverFlow: (id) coverFlow selectionDidChange: (int) index
{
//	self.whichItem = index;
//	[self.cfView.label setText:[self.titles objectAtIndex:index]];
}

// Detect the end of the flip -- both on reveal and hide
- (void) coverFlowFlipDidEnd: (UICoverFlowLayer *)coverFlow
{
//	if (flipOut)
//		[[[UIApplication sharedApplication] keyWindow] addSubview:flippedView];
//	else
//		[flippedView removeFromSuperview];
}


/* Cover flow datasource
 */
- (void) coverFlow:(id)coverFlow requestImageAtIndex: (int)index quality: (int)quality
{
	UIImage *whichImg = [self.covers objectAtIndex:index];
	[coverFlow setImage:[whichImg CGImage]  atIndex:index type:quality];
}

// Return a flip layer, one that preferably integrates into the flip presentation
- (id) coverFlow: (UICoverFlowLayer *)coverFlow requestFlipLayerAtIndex: (int) index
{
//	if (flipOut) [flippedView removeFromSuperview];
//	flipOut = !flipOut;
//
//	// Prepare the flip text
//	[flippedView setText:[NSString stringWithFormat:@"%@\n%@", [self.titles objectAtIndex:index], [self.colorDict objectForKey:[self.titles objectAtIndex:index]]]];
//
//	// Flip with a simple blank square
//	UIView *view = [[[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 140.0f, 140.0f)] autorelease];
//	[view setBackgroundColor:[UIColor clearColor]];
//
//	return [view layer];
	return nil;
}
@end
