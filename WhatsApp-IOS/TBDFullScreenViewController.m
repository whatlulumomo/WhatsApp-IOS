//
//  TBDFullScreenViewController.m
//  WhatsApp-IOS
//
//  Created by 葛帅琦 on 6/19/20.
//  Copyright © 2020 Shuaiqi Ge. All rights reserved.
//

#import "TBDFullScreenViewController.h"

@interface TBDFullScreenViewController ()

@end

@implementation TBDFullScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
    [self setupGestures];
}

- (void) setupView {
    UILabel* hintLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 300, 100)];
    NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    [style setAlignment:NSTextAlignmentCenter];
    [style setLineBreakMode:NSLineBreakByWordWrapping];

//    UIFont *font1 = [UIFont boldSystemFontOfSize:40];
    UIFont *font1 = [UIFont fontWithName:@"Chalkduster"  size:35];
    UIFont *font2 = [UIFont fontWithName:@"Chalkduster"  size:25];
    NSDictionary *dict1 = @{NSUnderlineStyleAttributeName:@(NSUnderlineStyleNone),
                            NSFontAttributeName:font1,
                            NSForegroundColorAttributeName: UIColor.whiteColor,
                            NSParagraphStyleAttributeName:style}; // Added line
    NSDictionary *dict2 = @{NSUnderlineStyleAttributeName:@(NSUnderlineStyleNone),
                            NSFontAttributeName:font2,
                            NSForegroundColorAttributeName: UIColor.whiteColor,
                            NSParagraphStyleAttributeName:style}; // Added line
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] init];
    [attString appendAttributedString:[[NSAttributedString alloc] initWithString:@"The view is TBD\n\n" attributes:dict1]];
    [attString appendAttributedString:[[NSAttributedString alloc] initWithString:@"Swipe to return" attributes:dict2]];
    [hintLabel setAttributedText:attString];
    [hintLabel setNumberOfLines: 0];
    [hintLabel setTranslatesAutoresizingMaskIntoConstraints: NO];
    [self.view addSubview:hintLabel];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:hintLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:hintLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1 constant:150]];
   
    
    
    UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:@"bg9"] drawInRect:self.view.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [self.view setBackgroundColor: [UIColor colorWithPatternImage: image]];
}

- (void) setupGestures {
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeToDissmiss)];
    [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeToDissmiss)];
    [swipeRight setDirection:UISwipeGestureRecognizerDirectionLeft];
    [self.view addGestureRecognizer:swipeRight];
    [self.view addGestureRecognizer:swipeLeft];
}

- (void) swipeToDissmiss {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
