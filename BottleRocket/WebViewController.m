//
//  WebViewController.m
//  BottleRocket
//
//  Created by admin on 12/18/16.
//  Copyright © 2016 Jett Raines. All rights reserved.
//

#import "WebViewController.h"


@interface WebViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *backButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *refreshButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *forwardButton;

@end

@implementation WebViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.webView.delegate = self;
    self.searchBar.delegate = self;
    self.searchBar.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.searchBar.keyboardType = UIKeyboardTypeURL;
    self.searchBar.keyboardAppearance = UIKeyboardAppearanceDark;
    
    // Inital Bottle Rocket Request
    NSURL *url = [NSURL URLWithString:@"https://www.bottlerocketstudios.com"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    
    // If user doesn't enter https, add it and search.
    if ([searchBar.text containsString:@"https://"])
    {
        NSURL *url = [NSURL URLWithString: searchBar.text];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [self.webView loadRequest:request];
    }
    else
    {
        NSString *searchString = [NSString stringWithFormat:@"%@%@", @"https://", searchBar.text];
        NSURL *url = [NSURL URLWithString: searchString];
        NSLog(@"%@", searchString);
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [self.webView loadRequest:request];
    }
}
// Button Availibiliy
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    if([webView canGoBack])
    {
        [self.backButton setEnabled:YES];
    }
    else
    {
        [self.backButton setEnabled:NO];
    }
    if ([webView canGoForward])
    {
        [self.forwardButton setEnabled:YES];
    }
    else
    {
        [self.forwardButton setEnabled:NO];
    }
}

// Button Methods
- (IBAction)backButtonTapped:(id)sender
{
    [self.webView goBack];
}
- (IBAction)fowardButtonTapped:(id)sender
{
    [self.webView goForward];
}
- (IBAction)refreshButtonTapped:(id)sender
{
    [self.webView reload];
}



@end
