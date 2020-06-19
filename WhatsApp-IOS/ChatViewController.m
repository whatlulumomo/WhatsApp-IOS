//
//  ChatViewController.m
//  WhatsApp-IOS
//
//  Created by 葛帅琦 on 6/15/20.
//  Copyright © 2020 Shuaiqi Ge. All rights reserved.
//

#import "ChatViewController.h"
#import "UIHighlightButton.h"
#import "Color.h"

@interface ChatViewController ()

@end

@implementation ChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBarLeftButtons];
    [self setNavigationBarRightButtons];
    [self setupView];
}

- (void) setupView {
    [self.view setBackgroundColor: [UIColor colorWithRed:231/255.0 green:231/255.0 blue:231/255.0 alpha:1]];
}

- (void) setNavigationBarLeftButtons {
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
    [[UIImage imageNamed:_name] drawInRect:CGRectMake(0, 0, avatarButton.frame.size.width, avatarButton.frame.size.height)];
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    avatarButton.backgroundColor = [UIColor colorWithPatternImage: resultImage];
    avatarButton.layer.cornerRadius = 0.5 * avatarButton.bounds.size.width;
    [avatarButton addTarget:self.navigationController action:@selector(popViewControllerAnimated:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView:avatarButton];
    
    // profile name
    UIBarButtonItem *nameLabelButton = [[UIBarButtonItem alloc] initWithTitle:_name
                                                                     style:UIBarButtonItemStylePlain
                                                                    target:nil
                                                                    action:nil];
    [nameLabelButton setTintColor:WhiteColor];
    
    self.navigationItem.leftBarButtonItems = @[backButton, barButton, nameLabelButton];
}

- (void) setNavigationBarRightButtons {
    UIHighlightButton* voiceCallButton = UIHighlightButton.new;
    [voiceCallButton setTintColor:WhiteColor];
    voiceCallButton.normalColor = DarkTealGreenColor;
    voiceCallButton.highlightMaskColor = HighlightMaskColor;
    voiceCallButton.rounded = YES;
    voiceCallButton.frame = CGRectMake(0, 0, 20, 20);
    [voiceCallButton setBackgroundImage:[[UIImage imageNamed:@"voicecall_1"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    [voiceCallButton setContentMode: UIViewContentModeScaleAspectFit];
    [voiceCallButton setTintColor: WhiteColor];
    UIBarButtonItem *voiceCallBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:voiceCallButton];
    
    UIHighlightButton* videoCallButton = UIHighlightButton.new;
    [videoCallButton setTintColor:WhiteColor];
    videoCallButton.normalColor = DarkTealGreenColor;
    videoCallButton.highlightMaskColor = HighlightMaskColor;
    videoCallButton.rounded = YES;
    videoCallButton.frame = CGRectMake(0, 0, 20, 20);
    [videoCallButton setBackgroundImage:[[UIImage imageNamed:@"videocall_1"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    [videoCallButton setContentMode: UIViewContentModeScaleAspectFit];
    [videoCallButton setTintColor: WhiteColor];
    UIBarButtonItem *videoCallBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:videoCallButton];
    
    UIHighlightButton* moreButton = UIHighlightButton.new;
    [moreButton setTintColor:WhiteColor];
    moreButton.normalColor = DarkTealGreenColor;
    moreButton.highlightMaskColor = HighlightMaskColor;
    moreButton.rounded = YES;
    moreButton.frame = CGRectMake(0, 0, 20, 20);
    UIImage *moreImage = [[UIImage imageNamed:@"icons-more_1"] imageWithRenderingMode: UIImageRenderingModeAlwaysTemplate];
    [moreImage imageWithTintColor: WhiteColor];
    [moreButton setBackgroundImage:moreImage forState:UIControlStateNormal];
    UIBarButtonItem *moreBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:moreButton];
   
    self.navigationItem.rightBarButtonItems = @[moreBarButtonItem, voiceCallBarButtonItem, videoCallBarButtonItem];
}

@end
