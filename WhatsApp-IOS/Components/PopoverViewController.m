//
//  PopoverViewController.m
//  WhatsApp-IOS
//
//  Created by 葛帅琦 on 6/16/20.
//  Copyright © 2020 Shuaiqi Ge. All rights reserved.
//

#import "PopoverViewController.h"

@interface PopoverViewController ()

@end

#define labelsArray @[@"New group", @"New broadcase", @"WhatsApp Web", @"Starred messages", @"Settings"]
NSString *menuCellId = @"popoverCellId";

@implementation PopoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [labelsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:menuCellId];
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:menuCellId];
    }
    cell.textLabel.text = labelsArray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

@end
