//
//  ViewController.m
//  WhatsApp-IOS
//
//  Created by 葛帅琦 on 6/15/20.
//  Copyright © 2020 Shuaiqi Ge. All rights reserved.
//

#import "ContractTableViewController.h"
#import "ContractTableViewCell.h"
#import "ChatViewController.h"

@interface ContractTableViewController ()
@end

NSString *cellId = @"cellId";

@implementation ContractTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
}

- (void) setupView {
    [self.view setBackgroundColor: UIColor.whiteColor];
    self.tableView.separatorColor = [UIColor clearColor]; // remove seprator
    self.tableView.rowHeight = 80;
    
    UILabel* label = UILabel.new;
    [label setText: @"WhatsApp"];
    [label setTextColor: UIColor.whiteColor];
    [label setFont: [UIFont boldSystemFontOfSize:22]];
    label.textAlignment = NSTextAlignmentLeft;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:label];
    
    UIBarButtonItem *searchBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage systemImageNamed:@"magnifyingglass"] style:UIBarButtonItemStylePlain target:self action:@selector(touchSearchButton:)];
    [searchBtn setTintColor: UIColor.whiteColor];
    self.navigationItem.rightBarButtonItem = searchBtn;
}

- (IBAction) touchSearchButton:(id)sender {
    NSLog(@"click");
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ContractTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[ContractTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    [cell.avatarImageView setImage:[UIImage imageNamed:@"pikachu"]];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%zd", indexPath.row);
    ChatViewController *viewController = [[ChatViewController alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
}

@end
