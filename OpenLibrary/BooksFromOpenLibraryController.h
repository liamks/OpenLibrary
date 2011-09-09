//
//  BooksFromOpenLibraryController.h
//  OpenLibrary
//
//  Created by Liam Kaufman Simpkins on 11-09-08.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SBJSON.h"


@class BooksFromOpenLibraryController;

@protocol BooksFromOpenLibraryDelegate 
-(void)bookSelected:(BooksFromOpenLibraryController *) requestor withBookKey:(NSString *) newBookKey;
@end


@interface BooksFromOpenLibraryController : UITableViewController{
    NSString *subject;
    NSMutableArray *books;
    NSMutableArray *authors;
    NSMutableArray *bookKeys;

    id <BooksFromOpenLibraryDelegate> delegate;
}


-(id) initWithSubject:(NSString *) newSubject style:(UITableViewStyle)style;
-(void)getBooksFromOpenLibrary;
-(void)getBooksFromOpenLibraryFirstTime;


@property (nonatomic, retain) NSString * subject;
@property (assign) id <BooksFromOpenLibraryDelegate> delegate;

@end
