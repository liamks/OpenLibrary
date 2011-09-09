//
//  BooksFromOpenLibraryController.m
//  OpenLibrary
//
//  Created by Liam Kaufman Simpkins on 11-09-08.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BooksFromOpenLibraryController.h"

@implementation BooksFromOpenLibraryController

@synthesize subject;
@synthesize delegate;


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}


-(id) initWithSubject:(NSString *) newSubject style:(UITableViewStyle)style{
    self = [super initWithStyle:style];
    if (self) {
        self.subject = newSubject;
    }
    books = [[NSMutableArray alloc] init];
    authors = [[NSMutableArray alloc] init];
    bookKeys = [[NSMutableArray alloc] init];
    
    return self;
}

-(NSNumber *) getOffset{
    NSNumber * inter = [[NSNumber alloc] initWithUnsignedInt:20];
    
    NSNumber * offset = [[NSNumber alloc] initWithInt:0];
    
    NSLog(@"Number of books: %d", [books count]);
    if ([books count] > 0) {
        offset = [[NSNumber alloc] initWithFloat:((float)[books count]/(float)[inter intValue])];
        NSLog(@"offset: %f", [offset floatValue]);
        offset = [[NSNumber alloc] initWithInt:([offset intValue] + 1) * [inter intValue]];
    }
    
    return offset;
}




-(void)getBooksFromOpenLibraryFirstTime{
    [books removeAllObjects];
    [authors removeAllObjects];
    [bookKeys removeAllObjects];
    [self getBooksFromOpenLibrary];
}

-(void)getBooksFromOpenLibrary{
    
    NSNumber *offset = [self getOffset];
    NSString *urlString =
    [NSString stringWithFormat:@"http://openlibrary.org/subjects/%@.json?ebooks=true&limit=20&offset=%@", self.subject, offset];
    NSLog(urlString);
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    //NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    /*
     Asynchronous connection above did not work, since it loads data in parts and breaks
     JSON parser. temporarily using synchronous request below.
     */
    
    NSURLResponse *response = [[NSURLResponse alloc] init];
    NSError *error = [[NSError alloc] init];
    
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:response error:error];
    
    NSURLConnection *c = [[NSURLConnection alloc] init];
    [self connection:c didReceiveData:data];
    [request release];
}




-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];

    NSDictionary *results = [jsonString JSONValue];

    NSArray *rawBooks = [results objectForKey:@"works"];

    for (NSDictionary *work in rawBooks) {
        
        NSString *title = [work objectForKey:@"title"];
        NSString *key = [work objectForKey:@"key"];
        
        NSString *author = [[[work objectForKey:@"authors"] objectAtIndex:0] objectForKey:@"name"];
        
        [books addObject:title];
        [authors addObject:author];
        [bookKeys addObject:key];
        
        
    }
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
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

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [books count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
    cell.textLabel.text = [books objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = [authors objectAtIndex:indexPath.row];
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
    NSString *key = [bookKeys objectAtIndex:indexPath.row];
    [self.delegate bookSelected:self withBookKey:key];
}

@end
