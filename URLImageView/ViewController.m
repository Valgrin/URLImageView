//
//  ViewController.m
//  URLImageView
//
//  Created by Guest User on 05/03/15.
//  Copyright (c) 2015 Thomas LEVY. All rights reserved.
//

#import "ViewController.h"
#import "URLImageView.h"
#import "URLTableViewCell.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation ViewController

- (void)loadView
{
    [super loadView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    URLTableViewCell *cell = [[URLTableViewCell alloc] init];
    switch (indexPath.row) {
        case 1:
            cell.urlImageView.imageURL = @"http://www.abc.net.au/triplej/feeds/iphone/programs/mid_dawn/background.jpg";
            cell.label.text = @"1";
            break;
        case 2:
            cell.urlImageView.imageURL = @"http://www.abc.net.au/triplej/feeds/iphone/programs/mid_dawn/background.jpg";
            cell.label.text = @"2";
            break;
        default:
            break;
    }
    return cell;
}

@end
