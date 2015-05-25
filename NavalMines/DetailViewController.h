//
//  DetailViewController.h
//  NavalMines
//
//  Created by Mike_Gazdich_rMBP on 10/29/13.
//  Copyright (c) 2013 Mike Gazdich. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController <UISplitViewControllerDelegate, UIWebViewDelegate>

@property (strong, nonatomic) id detailItem;


@property (strong, nonatomic) IBOutlet UIWebView *webView;

@end
