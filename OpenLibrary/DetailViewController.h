//
//  DetailViewController.h
//  OpenLibrary
//
//  Created by Liam Kaufman Simpkins on 11-09-07.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController <UIPopoverControllerDelegate, UISplitViewControllerDelegate>

@property (nonatomic, retain) IBOutlet UIToolbar *toolbar;

@property (nonatomic, retain) id detailItem;

@property (nonatomic, retain) IBOutlet UILabel *detailDescriptionLabel;

@end
