//
//  Tracks.m
//  URLImageView
//
//  Created by Guest User on 06/03/15.
//  Copyright (c) 2015 Thomas LEVY. All rights reserved.
//

#import "Tracks.h"

@interface Tracks () <NSURLConnectionDelegate, NSURLConnectionDataDelegate, NSXMLParserDelegate>

@property (nonatomic, strong) NSMutableArray *trackList;
@property (nonatomic, strong) NSURLConnection *connection;

@property (nonatomic, strong) NSMutableData *apiReturnXMLData;
@property (nonatomic, strong) NSXMLParser *xmlParser;
@property (nonatomic, strong) NSString *currentElement;
@property (nonatomic, strong) Track *currentTrack;

@end

@implementation Tracks

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.trackList = [[NSMutableArray alloc] init];
        NSURLRequest *request = [NSURLRequest requestWithURL: [NSURL URLWithString: @"http://apps.aim-data.com/data/abc/triplej/onair.xml"]];
        self.connection = [NSURLConnection connectionWithRequest: request delegate: self];
    }
    return self;
}

#pragma mark - NSURLConnectionDelegate

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [self.connection cancel];
    self.connection = nil;
    NSLog(@"error");
}

#pragma mark - NSURLConnectionDataDelegate

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.apiReturnXMLData appendData: data];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    self.apiReturnXMLData = [NSMutableData data];
    [self.apiReturnXMLData setLength: 0];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    self.xmlParser = [[NSXMLParser alloc] initWithData: self.apiReturnXMLData];
    
    [self.xmlParser setDelegate: self];
    
    [self.xmlParser parse];
    
    [self.connection cancel];
    self.connection = nil;
}

#pragma mark - NSXMLParserDelegate

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if( [elementName isEqualToString:@"Error"])
    {
        NSLog(@"Web API Error!");
    }
    
    if ([elementName isEqualToString: @"playoutItem"])
    {
        if (self.currentTrack != nil)
        {
            [self.trackList addObject: self.currentTrack];
        }
        self.currentTrack = [[Track alloc] init];
        self.currentTrack.album = [attributeDict objectForKey: @"album"];
        self.currentTrack.artist = [attributeDict objectForKey: @"artist"];
        self.currentTrack.imageURL = [attributeDict objectForKey: @"imageUrl"];
        self.currentTrack.title = [attributeDict objectForKey: @"title"];
        self.currentTrack.playing = [[attributeDict objectForKey: @"status"] isEqualToString: @"playing"];
    }
}

- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    self.apiReturnXMLData = nil;
    [self.delegate didFinishLoadingTrackList: self.trackList];
}

@end
