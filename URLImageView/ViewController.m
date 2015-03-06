//
//  ViewController.m
//  URLImageView
//
//  Created by Guest User on 05/03/15.
//  Copyright (c) 2015 Thomas LEVY. All rights reserved.
//

#import "ViewController.h"
#import "URLImageView.h"
#import "Tracks.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate, TracksDelegate>

@property (nonatomic, strong) NSArray *trackList;

@end

@implementation ViewController

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder: aDecoder];
    if (self)
    {
        Tracks *tracks = [[Tracks alloc] init];
        tracks.delegate = self;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.contentInset = UIEdgeInsetsMake(20.0f, 0.0f, 0.0f, 0.0f);
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.trackList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: CellIdentifier];
    }
    Track *track = [self.trackList objectAtIndex: indexPath.row];
    URLImageView *imageView = (URLImageView *)[cell viewWithTag: 100];
    imageView.imageURL = track.imageURL;
    
    UILabel *titleAndArtistLabel = (UILabel *)[cell viewWithTag: 101];
    titleAndArtistLabel.text = [NSString stringWithFormat: @"%@ - %@", track.title, track.artist];

    UILabel *albumLabel = (UILabel *)[cell viewWithTag: 102];
    albumLabel.text = track.album;
    
    UIImageView *playImageView = (UIImageView *)[cell viewWithTag: 103];
    playImageView.hidden = !track.playing;
    
    [imageView bringSubviewToFront: playImageView];

    return cell;
}

#pragma mark - TracksDelegate

- (void)didFinishLoadingTrackList:(NSArray *)trackList
{
    self.trackList = trackList;
    [self.tableView reloadData];
}

@end
