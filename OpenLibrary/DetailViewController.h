//
//  DetailViewController.h
//  OpenLibrary
//
//  Created by Liam Kaufman Simpkins on 11-09-07.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BooksFromOpenLibraryController.h"

@interface DetailViewController : UIViewController <UIPopoverControllerDelegate, UISplitViewControllerDelegate, BooksFromOpenLibraryDelegate>{
    BooksFromOpenLibraryController *booksFromOpenLibraryController;
    NSString * bookKey;
}

@property (nonatomic, retain) NSString * bookKey;

@property (nonatomic, retain) IBOutlet UIToolbar *toolbar;
@property (nonatomic, retain) IBOutlet UIBarButtonItem * barButtonItemDownload;

@property (nonatomic, retain) id detailItem;

@property (nonatomic, retain) IBOutlet UILabel *detailDescriptionLabel;

@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *spinner;

-(IBAction)downloadMore:(UIBarButtonItem *)sender;



@end
