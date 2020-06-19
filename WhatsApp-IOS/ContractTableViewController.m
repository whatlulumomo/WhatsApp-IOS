//
//  ViewController.m
//  WhatsApp-IOS
//
//  Created by 葛帅琦 on 6/15/20.
//  Copyright © 2020 Shuaiqi Ge. All rights reserved.
//

#import "ContractTableViewController.h"
#import "ContractTableViewCell.h"
#import "FunctionTableViewCell.h"
#import "ChatViewController.h"
#import "UIHighlightButton.h"
#import "PopoverViewController.h"
#import "Color.h"
#import "Person.h"

@interface ContractTableViewController ()
@property (strong, nonatomic) NSMutableArray<Person *> * peopleData;
@end

NSString *cellId = @"cellId";
int tableviewCount = 5;

@implementation ContractTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _peopleData = [self readPeopleJson:@"Chats"];
    [self setupView];
}

- (void) setupView {
    [self.view setBackgroundColor: UIColor.whiteColor];
    self.tableView.separatorColor = [UIColor clearColor]; // remove seprator
    
    [self setupLeftNavigationBarItems];
    [self setupRightNavigationBarItems];
}

- (void) setupLeftNavigationBarItems {
    // back button
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithImage:[UIImage systemImageNamed:@"arrow.left"]
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self.navigationController
                                                                  action:@selector(popViewControllerAnimated:)];
    [backButton setTintColor: WhiteColor];
    // profile name
    UIBarButtonItem *nameLabelButton = [[UIBarButtonItem alloc] initWithTitle:@"皮卡丘"
                                                                     style:UIBarButtonItemStylePlain
                                                                    target:nil
                                                                    action:nil];
    [nameLabelButton setTintColor:WhiteColor];
    
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    [style setAlignment:NSTextAlignmentLeft];
    [style setLineBreakMode:NSLineBreakByWordWrapping];
    UIFont *font1 = [UIFont boldSystemFontOfSize:18];
    UIFont *font2 = [UIFont fontWithName:@"HelveticaNeue-Light"  size:12.0f];
    NSDictionary *dict1 = @{NSUnderlineStyleAttributeName:@(NSUnderlineStyleNone),
                            NSFontAttributeName:font1,
                            NSForegroundColorAttributeName: UIColor.whiteColor,
                            NSParagraphStyleAttributeName:style}; // Added line
    NSDictionary *dict2 = @{NSUnderlineStyleAttributeName:@(NSUnderlineStyleNone),
                            NSFontAttributeName:font2,
                            NSForegroundColorAttributeName: UIColor.whiteColor,
                            NSParagraphStyleAttributeName:style}; // Added line

    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] init];
    [attString appendAttributedString:[[NSAttributedString alloc] initWithString:@"Select contracts\n" attributes:dict1]];
    [attString appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%d contracts", tableviewCount] attributes:dict2]];
    [button setAttributedTitle:attString forState:UIControlStateNormal];
    [[button titleLabel] setNumberOfLines:0];
    [[button titleLabel] setLineBreakMode:NSLineBreakByWordWrapping];
    
    self.navigationItem.leftBarButtonItems = @[backButton, [[UIBarButtonItem alloc] initWithCustomView:button]];
}

- (void) setupRightNavigationBarItems {
    UIHighlightButton* seachButton = UIHighlightButton.new;
    [seachButton setTintColor:WhiteColor];
    seachButton.normalColor = DarkTealGreenColor;
    seachButton.highlightMaskColor = HighlightMaskColor;
    seachButton.rounded = YES;
    seachButton.frame = CGRectMake(0, 0, 25, 25);
    [seachButton setBackgroundImage:[UIImage systemImageNamed:@"magnifyingglass"] forState:UIControlStateNormal];
    UIBarButtonItem *searchBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:seachButton];
    
    
    UIHighlightButton* moreButton = UIHighlightButton.new;
    [moreButton addTarget:self action:@selector(tapPopoverMenu) forControlEvents:UIControlEventTouchUpInside];
    [moreButton setTintColor:WhiteColor];
    moreButton.normalColor = DarkTealGreenColor;
    moreButton.highlightMaskColor = HighlightMaskColor;
    moreButton.rounded = YES;
    moreButton.frame = CGRectMake(0, 0, 25, 25);
    UIImage *moreImage = [[UIImage imageNamed:@"icons-more"] imageWithRenderingMode: UIImageRenderingModeAlwaysTemplate];
    [moreImage imageWithTintColor: WhiteColor];
    [moreButton setBackgroundImage:moreImage forState:UIControlStateNormal];
    
    UIBarButtonItem *moreBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:moreButton];
    self.navigationItem.rightBarButtonItems = @[moreBarButtonItem, searchBarButtonItem];
}

- (IBAction) touchSearchButton:(id)sender {
    NSLog(@"click");
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_peopleData count] + 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 72;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row == 0){
        FunctionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (cell == nil) {
            cell = [[FunctionTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        cell.nameLabel.text = @"New group";
        [cell.avatarImageView setImage:[UIImage imageNamed:@"newgroup"]];
        return cell;
    }else if(indexPath.row == 1){
        FunctionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (cell == nil) {
            cell = [[FunctionTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        cell.nameLabel.text = @"New contract";
        [cell.avatarImageView setImage:[UIImage imageNamed:@"newgroup"]];
        return cell;
    }
    ContractTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[ContractTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.nameLabel.text = _peopleData[indexPath.row - 2].name;
        [cell.avatarImageView setImage:[UIImage imageNamed:_peopleData[indexPath.row - 2].name]];
    }
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row < 2){
        return;
    }
    ChatViewController *viewController = [[ChatViewController alloc] init];
    viewController.name = _peopleData[indexPath.row-2].name;
    [self.navigationController pushViewController:viewController animated:YES];
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

- (void) tapPopoverMenu {
    PopoverViewController* controller = PopoverViewController.new; // your initialization goes here
    controller.labelsArray = @[@"Invite a friend", @"Contracts", @"Refresh", @"Help"];
    // set modal presentation style to popover on your view controller
    // must be done before you reference controller.popoverPresentationController
    controller.modalPresentationStyle = UIModalPresentationPopover;
    controller.preferredContentSize = CGSizeMake(180, 40 * controller.labelsArray.count);

    // configure popover style & delegate
    UIPopoverPresentationController *popover =  controller.popoverPresentationController;
    popover.delegate = self;
    popover.sourceView = self.view;
    popover.sourceRect = CGRectMake(self.view.bounds.size.width,0,0,0);
    popover.permittedArrowDirections = 0;

    // display the controller in the usual way
    [self presentViewController:controller animated:YES completion:^{
        controller.view.superview.layer.cornerRadius = 0;
    }];
}

// overwrite UIModalPresentationStyle so popverview won't appear as a modal
- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller {
    return UIModalPresentationNone;
}

@end
