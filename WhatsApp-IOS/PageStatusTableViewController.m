//
//  PageStatusTableViewController.m
//  WhatsApp-IOS
//
//  Created by 葛帅琦 on 6/18/20.
//  Copyright © 2020 Shuaiqi Ge. All rights reserved.
//

#import "PageStatusTableViewController.h"
#import "PageChatsTableViewCell.h"

@interface PageStatusTableViewController ()

@end

NSString* PageStatusTableCeilId = @"PageStatusTableCeilId";

@implementation PageStatusTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorColor = [UIColor clearColor]; // remove seprator
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PageChatsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:PageStatusTableCeilId];
    if (cell == nil) {
        cell = [[PageChatsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:PageStatusTableCeilId];
    }
    [cell.avatarImageView setImage:[UIImage imageNamed:@"BestOreo"]];
    cell.nameLabel.text = @"BestOreo";
    cell.messageLabel.text = @"Tap to add status update.";
    cell.timeLabel.text = @"";
    [cell.seperateLine removeFromSuperview];
    return cell;
}

@end
