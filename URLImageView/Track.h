//
//  Track.h
//  URLImageView
//
//  Created by Guest User on 06/03/15.
//  Copyright (c) 2015 Thomas LEVY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Track : NSObject

@property (nonatomic, strong) NSString *imageURL;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *artist;
@property (nonatomic, strong) NSString *album;
@property (nonatomic, assign) BOOL playing;

@end
