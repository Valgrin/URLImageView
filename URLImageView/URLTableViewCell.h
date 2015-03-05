//
//  URLTableViewCell.h
//  URLImageView
//
//  Created by Guest User on 05/03/15.
//  Copyright (c) 2015 Thomas LEVY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "URLImageView.h"

@interface URLTableViewCell : UITableViewCell

@property (nonatomic, strong) IBOutlet URLImageView *urlImageView;
@property (nonatomic, strong) IBOutlet UILabel *label;

@end
