//
//  FBCustomLoginDialog.m
//  WiFi Map Social
//
//  Created by Victoria Babakina on 22.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FBCustomLoginDialog.h"

@implementation FBCustomLoginDialog

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request
 navigationType:(UIWebViewNavigationType)navigationType {
    NSURL* url = request.URL;
    if ([[url absoluteString] rangeOfString:@"login"].location==NSNotFound) {
        [self dialogDidSucceed:url];
        return NO;
    }else if (url!=nil){
        [_spinner startAnimating];
        [_spinner setHidden:NO];
        return YES;
    }
    return NO;
}
@end