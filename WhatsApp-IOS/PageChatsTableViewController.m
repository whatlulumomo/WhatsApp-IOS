//
//  PageChatsTableViewController.m
//  WhatsApp-IOS
//
//  Created by 葛帅琦 on 6/18/20.
//  Copyright © 2020 Shuaiqi Ge. All rights reserved.
//

#import "PageChatsTableViewController.h"
#import "PageChatsTableViewCell.h"
#import "ChatViewController.h"
#import "Person.h"

@interface PageChatsTableViewController ()
@property (strong, nonatomic) NSMutableArray<Person *> * peopleData;
@end

NSString *PageChatsTableCellId = @"PageChatsTableCellId";


@implementation PageChatsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorColor = [UIColor clearColor]; // remove seprator
    _peopleData = [self readPeopleJson:@"Chats"];
}

- (NSMutableArray<Person *> *) readPeopleJson: (NSString*) jsonName {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:jsonName ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    NSMutableArray<Person *> *people = NSMutableArray.new;
    for (NSDictionary *PersonDict in json) {
        Person *person = Person.new;
        person.name = PersonDict[@"name"];
        person.imageUrl = PersonDict[@"imageUrl"];
        person.message = PersonDict[@"message"];
        person.time = PersonDict[@"time"];
        [people addObject:person];
    }
    return people;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ChatViewController *viewController = [[ChatViewController alloc] init];
    viewController.name = _peopleData[indexPath.row].name;
    [self.navigationController pushViewController:viewController animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_peopleData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PageChatsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:PageChatsTableCellId];
    if (cell == nil) {
        cell = [[PageChatsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:PageChatsTableCellId];
    }
    [cell.avatarImageView setImage:[UIImage imageNamed:_peopleData[indexPath.row].name]];
    cell.nameLabel.text = _peopleData[indexPath.row].name;
    cell.messageLabel.text = _peopleData[indexPath.row].message;
    cell.timeLabel.text = _peopleData[indexPath.row].time;
    if(indexPath.row == [_peopleData count] - 1){
        [cell.seperateLine removeFromSuperview];
    }
    return cell;
}


@end
