//
//  ViewController.m
//  WhatsApp-IOS
//
//  Created by 葛帅琦 on 6/15/20.
//  Copyright © 2020 Shuaiqi Ge. All rights reserved.
//

#import "MainViewController.h"
#import "ChatTableViewCell.h"

@interface MainViewController ()

@end

NSString *cellId = @"cellId";

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self setupView];
    
}

- (void) setupView {
    [self.view setBackgroundColor: UIColor.whiteColor];
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
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: cellId forIndexPath: indexPath];
//    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
//    cell.textLabel.text = self.courses[indexPath.row].name;
//    cell.detailTextLabel.text = [self.courses[indexPath.row].numOfLesson stringValue];
//    cell.imageView.image = [UIImage imageNamed:@"redhouse"];
    ChatTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[ChatTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    return cell;
}

@end
