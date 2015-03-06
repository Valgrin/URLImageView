//
//  Tracks.h
//  URLImageView
//
//  Created by Guest User on 06/03/15.
//  Copyright (c) 2015 Thomas LEVY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Track.h"

@protocol TracksDelegate <NSObject>

- (void)didFinishLoadingTrackList:(NSArray *)trackList;

@end

@interface Tracks : NSObject

@property (nonatomic, weak) id<TracksDelegate> delegate;

@end
