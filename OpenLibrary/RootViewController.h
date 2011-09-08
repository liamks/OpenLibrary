//
//  RootViewController.h
//  OpenLibrary
//
//  Created by Liam Kaufman Simpkins on 11-09-07.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailViewController;

@interface RootViewController : UITableViewController{
    NSDictionary *subjects;
    DetailViewController *detailViewController;
}

@property (nonatomic, retain) IBOutlet DetailViewController *detailViewController;

@end
