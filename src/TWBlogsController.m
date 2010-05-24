//
//  TWBlogsController.m
//  DrTeeth
//
//  Created by Giles Alexander on 22/05/10.
//  Copyright 2010 Silverbrook Research. All rights reserved.
//

#import "TWBlogsController.h"
#import "GDataXMLNode.h"

@interface NSObject (Maybe)

@property (nonatomic, readonly) id maybe;

@end

@implementation NSObject (Maybe)

- (id)maybe
{
  if (self == [NSNull null])
    return nil;
  else
    return self;
}

@end

@interface GDataXMLElement (Convenience)

- (GDataXMLElement *)firstElementWithLocalName:(NSString *)localName URI:(NSString *)uri;

@end

@implementation GDataXMLElement (Convenience)

- (GDataXMLElement *)firstElementWithLocalName:(NSString *)localName URI:(NSString *)uri
{
  NSArray *elements = [self elementsForLocalName:localName
                                             URI:uri];
  if ([elements count] > 0)
    return [elements objectAtIndex:0];
  else
    return nil;
}

@end

@interface TWBlogsController ()
- (void)updateBlogEntries:(NSArray *)entries;
@end

@implementation TWBlogsController

@synthesize entries;

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad
{
  [super viewDidLoad];

  [
    [ UIApplication sharedApplication ]
    .delegate addObserver: self forKeyPath: @"blogEntries" options:(NSKeyValueObservingOptionNew | NSKeyValueObservingOptionInitial) context:NULL
  ];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
  if( [keyPath isEqualToString: @"blogEntries"] )
  {
    [self performSelectorOnMainThread: @selector(updateBlogEntries:) withObject:[[change objectForKey: NSKeyValueChangeNewKey] maybe] waitUntilDone: NO];
  }
}

- (void)updateBlogEntries:(NSArray *)entries
{
  NSLog(@"Blog count: %d", entries.count);
  self.entries = entries;
  [tableView reloadData];
}
/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}
*/


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Override to allow orientations other than the default portrait orientation.
    return YES;
}

- (void)close:(id)sender
{
	[self dismissModalViewControllerAnimated: YES];
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
//    return <#number of sections#>;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return entries.count;
//    return <#number of rows in section#>;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *CellIdentifier = @"Cell";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }

    // Configure the cell...
    id entry = [entries objectAtIndex:indexPath.row];
    GDataXMLElement *title = [entry firstElementWithLocalName:@"title" URI:@"http://www.w3.org/2005/Atom"];
    GDataXMLElement *author = [entry firstElementWithLocalName:@"author" URI:@"http://www.w3.org/2005/Atom"];
    GDataXMLElement *name = [author firstElementWithLocalName:@"name" URI:@"http://www.w3.org/2005/Atom"];
    cell.textLabel.text = [title stringValue];
    cell.detailTextLabel.text = [name stringValue];
//     NSArray *values = [entry elementsForLocalName:@"title" URI:@"http://www.w3.org/2005/Atom"];
//     NSArray *values = [entry nodesForXPath:@"//atom:entry/atom:title" namespaces:[NSDictionary dictionaryWithObject:@"http://www.w3.org/2005/Atom" forKey:@"atom"] error:nil];
    
//     cell.textLabel.text = [entry localName];

    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {

    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
	/*
	 <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
	 [self.navigationController pushViewController:detailViewController animated:YES];
	 [detailViewController release];
	 */
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];

    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end

