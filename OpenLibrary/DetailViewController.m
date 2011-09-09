//
//  DetailViewController.m
//  OpenLibrary
//
//  Created by Liam Kaufman Simpkins on 11-09-07.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DetailViewController.h"
#import "RootViewController.h"


@interface DetailViewController ()
@property (nonatomic, retain) UIPopoverController *popoverController;
- (void)configureView;
@end

@implementation DetailViewController

@synthesize toolbar = _toolbar;
@synthesize detailItem = _detailItem;
@synthesize detailDescriptionLabel = _detailDescriptionLabel;
@synthesize popoverController = _myPopoverController;

@synthesize bookKey;
@synthesize barButtonItemDownload;
@synthesize spinner;

-(void)bookSelected:(BooksFromOpenLibraryController *) requestor withBookKey:(NSString *) newBookKey{
    if(requestor == booksFromOpenLibraryController){
        self.bookKey = newBookKey;
        self.barButtonItemDownload.enabled = YES;
    }
}

#pragma mark - Managing the detail item

/*
 When setting the detail item, update the view and dismiss the popover controller if it's showing.
 */
- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        [_detailItem release];
        _detailItem = [newDetailItem retain];
        
        // Update the view.
        [self configureView];
    }

    if (self.popoverController != nil) {
        [self.popoverController dismissPopoverAnimated:YES];
    }        
}

-(void)viewDidLoad{
    booksFromOpenLibraryController = [[BooksFromOpenLibraryController alloc] initWithSubject:self.detailItem
                                                                                       style:UITableViewStylePlain];
    booksFromOpenLibraryController.delegate = self;

    booksFromOpenLibraryController.tableView.frame = CGRectMake(0, 44,
                                                                 self.view.frame.size.width, 
                                                                 self.view.frame.size.height);
    
    [self.view addSubview:booksFromOpenLibraryController.view];
}

- (void)configureView
{

    self.spinner.hidden = NO;
    
    [booksFromOpenLibraryController setSubject:self.detailItem];
    [booksFromOpenLibraryController getBooksFromOpenLibraryFirstTime];

    self.spinner.hidden = YES;

}

-(IBAction)downloadMore:(UIBarButtonItem *)sender{
    [booksFromOpenLibraryController getBooksFromOpenLibrary];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

#pragma mark - Split view support

- (void)splitViewController:(UISplitViewController *)svc willHideViewController:(UIViewController *)aViewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController: (UIPopoverController *)pc
{
    barButtonItem.title = @"Subjects";
    NSMutableArray *items = [[self.toolbar items] mutableCopy];
    [items insertObject:barButtonItem atIndex:0];
    [self.toolbar setItems:items animated:YES];
    [items release];
    self.popoverController = pc;
}

// Called when the view is shown again in the split view, invalidating the button and popover controller.
- (void)splitViewController:(UISplitViewController *)svc willShowViewController:(UIViewController *)aViewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    NSMutableArray *items = [[self.toolbar items] mutableCopy];
    [items removeObjectAtIndex:0];
    [self.toolbar setItems:items animated:YES];
    [items release];
    self.popoverController = nil;
}

/*
 // Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
 */

- (void)viewDidUnload
{
	[super viewDidUnload];

	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
	self.popoverController = nil;
}

#pragma mark - Memory management

- (void)didReceiveMemoryWarning
{
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)dealloc
{
    [_myPopoverController release];
    [_toolbar release];
    [_detailItem release];
    [_detailDescriptionLabel release];
    [super dealloc];
}

@end
