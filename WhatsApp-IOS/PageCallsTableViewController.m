//
//  PageCallsTableViewController.m
//  WhatsApp-IOS
//
//  Created by 葛帅琦 on 6/18/20.
//  Copyright © 2020 Shuaiqi Ge. All rights reserved.
//

#import "PageCallsTableViewController.h"
#import "PageCallsTableViewCell.h"
#import "Call.h"
#import "Color.h"

@interface PageCallsTableViewController ()

@property (strong, nonatomic) NSMutableArray<Call *> * Calls;

@end

NSString* PageCallsTableCeilId = @"PageCallsTableCeilId";

@implementation PageCallsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorColor = [UIColor clearColor]; // remove seprator
     _Calls = [self readCallJson:@"Calls"];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_Calls count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PageCallsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:PageCallsTableCeilId];
    if (cell == nil) {
        cell = [[PageCallsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:PageCallsTableCeilId];
    }
    [cell.avatarImageView setImage:[UIImage imageNamed: _Calls[indexPath.row].name]];
    cell.nameLabel.text = _Calls[indexPath.row].name;
    cell.timeLabel.text = _Calls[indexPath.row].time;
    if([_Calls[indexPath.row].type isEqualToString:@"Incall"]){
        [cell.inOutLabel setImage: [[UIImage imageNamed:@"incall"] imageWithRenderingMode: UIImageRenderingModeAlwaysTemplate]];
        [cell.inOutLabel setTintColor: LightGreenColor];
    }else if([_Calls[indexPath.row].type isEqualToString:@"Outcall"]){
        [cell.inOutLabel setImage: [[UIImage imageNamed:@"outcall"] imageWithRenderingMode: UIImageRenderingModeAlwaysTemplate]];
        [cell.inOutLabel setTintColor: LightGreenColor];
    }else{
        [cell.inOutLabel setImage: [[UIImage imageNamed:@"misscall"] imageWithRenderingMode: UIImageRenderingModeAlwaysTemplate]];
        [cell.inOutLabel setTintColor: UIColor.redColor];
    }
    
    if([_Calls[indexPath.row].callType isEqualToString:@"Voicecall"]){
        [cell.callTypeLabel setImage: [[UIImage imageNamed:@"voicecall"] imageWithRenderingMode: UIImageRenderingModeAlwaysTemplate]];
        [cell.callTypeLabel setTintColor: DarkTealGreenColor];
    }else{
        [cell.callTypeLabel setImage: [[UIImage imageNamed:@"videocall"] imageWithRenderingMode: UIImageRenderingModeAlwaysTemplate]];
        [cell.callTypeLabel setTintColor: DarkTealGreenColor];
    }
    
    if(indexPath.row == [_Calls count] - 1){
        [cell.seperateLine removeFromSuperview];
    }
    return cell;
}

- (NSMutableArray<Call *> *) readCallJson: (NSString*) jsonName {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:jsonName ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    NSMutableArray<Call *> *Calls = NSMutableArray.new;
    for (NSDictionary *CallDict in json) {
        Call *call = Call.new;
        call.name = CallDict[@"name"];
        call.imageUrl = CallDict[@"imageUrl"];
        call.type = CallDict[@"type"];
        call.callType = CallDict[@"callType"];
        call.time = CallDict[@"time"];
        [Calls addObject:call];
    }
    return Calls;
}

@end
