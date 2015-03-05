//
//  URLImageView.m
//  URLImageView
//
//  Created by Guest User on 05/03/15.
//  Copyright (c) 2015 Thomas LEVY. All rights reserved.
//

#import "URLImageView.h"

@interface URLImageView () <NSURLConnectionDelegate, NSURLConnectionDataDelegate>

@property (nonatomic, strong) NSURLConnection *URLConnection;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;
@property (nonatomic, strong) NSMutableData *data;
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation URLImageView

- (id)initWithFrame:(CGRect)aRect
{
    self = [super initWithFrame:aRect];
    if (self)
    {
        [self addSubview: self.activityIndicator];
        self.imageView = [[UIImageView alloc] init];
        [self addSubview: self.imageView];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.activityIndicator.frame = self.imageView.frame = self.frame;
}

#pragma mark - Accessors

- (UIActivityIndicatorView *)activityIndicator
{
    if (_activityIndicator == nil)
    {
        _activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _activityIndicator.hidesWhenStopped = YES;
    }
    return _activityIndicator;
}

- (NSMutableData *)data
{
    if (_data == nil)
    {
        _data = [[NSMutableData alloc] init];
    }
    return _data;
}

- (void)setImageURL:(NSString *)imageURL
{
    _imageURL = imageURL;
    self.imageView.image = nil;
    [self startDownloadImage: imageURL];
}

#pragma mark - NSURLConnectionDelegate

- (void)connectionDidFinishLoading:(NSURLConnection*)theConnection
{
    [self.activityIndicator stopAnimating];
    self.URLConnection = nil;
    self.imageView.image = [UIImage imageWithData: self.data];
    self.data = nil;
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [self.activityIndicator stopAnimating];
    self.data = nil;
}

#pragma mark - NSURLConnectionDataDelegate

- (void)connection:(NSURLConnection *)theConnection didReceiveData:(NSData *)data
{
    [self.data appendData: data];
}

#pragma mark - Private

- (void)startDownloadImage:(NSString *)imageURL
{
    [self.URLConnection cancel];
    self.URLConnection = nil;
    NSURLRequest *request = [NSURLRequest requestWithURL: [NSURL URLWithString: imageURL]];
    self.URLConnection = [NSURLConnection connectionWithRequest: request delegate: self];
    [self.activityIndicator startAnimating];
}

@end