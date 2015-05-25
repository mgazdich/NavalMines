//
//  DetailViewController.m
//  NavalMines
//
//  Created by Mike_Gazdich_rMBP on 10/29/13.
//  Copyright (c) 2013 Mike Gazdich. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@property (strong, nonatomic) UIPopoverController *masterPopoverController;

- (void)configureView;

@end


@implementation DetailViewController

#pragma mark - Managing the Detail Item

/*
 We included the following in the header file: @property (strong, nonatomic) id detailItem;
 With this @property statement, we asked the compiler to create the getter and setter methods:
 
 Getter method is named: detailItem
 Setter method is named: setDetailItem:
 
 However, we need to override the Setter method for detailItem because we need to do more than the simple action of setting the value.
 */
- (void)setDetailItem:(id)newDetailItem
{
    /*
     If the new detailItem is not the same as the current one, then configure the view based on the new detailItem.
     
     WHY are we accessing the instance variable _detailItem's value DIRECTLY? We have to, because we cannot call
     the Getter method since it is locked and waiting for the completion of the Setter method's execution.
     If you change _detailItem to self.detailItem to use the Getter method, the code will go into an infinite loop!
     */
    
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
    
    if (self.masterPopoverController != nil) {
        [self.masterPopoverController dismissPopoverAnimated:YES];
    }
}


#pragma mark - View Life Cycle

- (void)viewDidLoad
{
    [self configureView];
    [super viewDidLoad];
}


- (void)configureView
{
    if (self.detailItem) {
        // Configure the view and show it in the Web View object
        
        NSString *topicTitle = [self.detailItem description];
        
        self.navigationItem.title = topicTitle;
        
        NSString *htmlFileName = [[NSString alloc] init];
        
        if ([topicTitle hasPrefix:@"Cla"]) {
            htmlFileName = @"Classification";
        }
        else if ([topicTitle hasPrefix:@"Cou"]) {
            htmlFileName = @"Countermeasures";
        }
        else if ([topicTitle hasPrefix:@"Moo"]) {
            htmlFileName = @"MooredContactMines";
        }
        else if ([topicTitle hasPrefix:@"Bot"]) {
            htmlFileName = @"BottomContactMines";
        }
        else if ([topicTitle hasPrefix:@"Dri"]) {
            htmlFileName = @"DriftingContactMines";
        }
        else if ([topicTitle hasPrefix:@"Tar"]) {
            htmlFileName = @"LimpetMines";
        }
        else if ([topicTitle hasPrefix:@"Inf"]) {
            htmlFileName = @"InfluenceMines";
        }
        else if ([topicTitle hasPrefix:@"Rem"]) {
            htmlFileName = @"RemotelyControlledMines";
        }
        
        NSURL *fileURL = [[NSBundle mainBundle] URLForResource:htmlFileName withExtension: @"html"];
        
        [self.webView loadRequest:[NSURLRequest requestWithURL:fileURL]];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UISplitViewControllerDelegate Protocol Methods

/*
 When iPad rotates from landscape to portrait orientation, our app hides the master view controller
 displaying the list of topics for naval mines on the left side of the split view.
 When this happens, the button and popover controller need to be reactivated so that
 the user can select a topic from the popover menu displayed by tapping the button.
 */
- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController
          withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    barButtonItem.title = @"Naval Mines";
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.masterPopoverController = popoverController;
}


/*
 When iPad rotates from portrait to landscape orientation, our app shows its hidden master view controller
 displaying the list of topics for naval mines on the left side of the split view.
 When this happens, the button and popover controller are no longer needed and they are deactivated.
 The deactivation is done by setting the object references to nil.
 */
- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController
  invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}


#pragma mark - UIWebView Delegate Methods

- (void)webViewDidStartLoad:(UIWebView *)webView {
    // Starting to load the web page. Show the animated activity indicator in the status bar
    // to indicate to the user that the UIWebVIew object is busy loading the web page.
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    // Finished loading the web page. Hide the activity indicator in the status bar.
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    
    // Ignore this error if the page is instantly redirected via javascript or in another way
    if([error code] == NSURLErrorCancelled) return;
    
    // An error occurred during the web page load. Hide the activity indicator in the status bar.
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    // Create the error message in HTML as a character string object pointed to by errorString
    NSString *errorString = [NSString stringWithFormat:
                             @"<html><font size=+2 color='red'><p>An error occurred: %@<br />Possible causes for this error:<br />- No network connection<br />- Wrong URL entered<br />- Server computer is down</p></font></html>",
                             error.localizedDescription];
    
    // Display the error message within the UIWebView object
    [self.webView loadHTMLString:errorString baseURL:nil];
}

@end
