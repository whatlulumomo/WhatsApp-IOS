//
//  ChatViewController.m
//  WhatsApp-IOS
//
//  Created by 葛帅琦 on 6/15/20.
//  Copyright © 2020 Shuaiqi Ge. All rights reserved.
//

#import "ChatViewController.h"
#import "Color.h"

@interface ChatViewController ()

@end

@implementation ChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
}

- (void) setupView {
    [self.view setBackgroundColor: [UIColor colorWithRed:231/255.0 green:231/255.0 blue:231/255.0 alpha:1]];
    // back button
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithImage:[UIImage systemImageNamed:@"arrow.left"]
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self.navigationController
                                                                  action:@selector(popViewControllerAnimated:)];
    [backButton setTintColor: WhiteColor];
    
    // profile avatar
    UIButton *avatarButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    // redraw the image to fit new size
    UIGraphicsBeginImageContextWithOptions(avatarButton.frame.size, NO, 0);
    [[UIImage imageNamed:@"pikachu"] drawInRect:CGRectMake(0, 0, avatarButton.frame.size.width, avatarButton.frame.size.height)];
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    avatarButton.backgroundColor = [UIColor colorWithPatternImage: resultImage];
    avatarButton.layer.cornerRadius = 0.5 * avatarButton.bounds.size.width;
    [avatarButton addTarget:self.navigationController action:@selector(popViewControllerAnimated:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView:avatarButton];
    
    // profile name
    UIBarButtonItem *nameLabelButton = [[UIBarButtonItem alloc] initWithTitle:@"皮卡丘"
                                                                     style:UIBarButtonItemStylePlain
                                                                    target:nil
                                                                    action:nil];
    [nameLabelButton setTintColor:WhiteColor];
    
    self.navigationItem.leftBarButtonItems = @[backButton, barButton, nameLabelButton];
    
    UIBarButtonItem *searchBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage systemImageNamed:@"magnifyingglass"]
                                                                  style:UIBarButtonItemStylePlain
                                                                 target:self
                                                                 action: nil];
    [searchBtn setTintColor: WhiteColor];
    self.navigationItem.rightBarButtonItem = searchBtn;
}

@end
