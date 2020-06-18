//
//  PageChatsTableViewController.m
//  WhatsApp-IOS
//
//  Created by 葛帅琦 on 6/18/20.
//  Copyright © 2020 Shuaiqi Ge. All rights reserved.
//

#import "PageChatsTableViewController.h"
#import "PageChatsTableViewCell.h"

@interface PageChatsTableViewController ()

@end

NSString *PageChatsTableCellId = @"PageChatsTableCellId";


@implementation PageChatsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorColor = [UIColor clearColor]; // remove seprator
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PageChatsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:PageChatsTableCellId];
    if (cell == nil) {
        cell = [[PageChatsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:PageChatsTableCellId];
    }
    [cell.avatarImageView setImage:[UIImage imageNamed:@"pikachu"]];
    return cell;
}

@end
