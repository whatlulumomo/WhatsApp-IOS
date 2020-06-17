//
//  HomeViewController.m
//  WhatsApp-IOS
//
//  Created by 葛帅琦 on 6/16/20.
//  Copyright © 2020 Shuaiqi Ge. All rights reserved.
//

#import "HomeViewController.h"
#import "HighlightButtonView.h"
#import "PageViewController.h"
#import "ContractTableViewController.h"

@interface HomeViewController ()
@property UIView* navigatorView;
@property UIView* displayView;
@property NSArray<NSString *> *dataSources;
@property NSArray<HighlightButtonView *> *navigatorButtonViews;
@end

@implementation HomeViewController

NSInteger currentViewControllerIndex = 0;
PageViewController *pageViewController;

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
}

- (void) setupView {
    [self.view setBackgroundColor: UIColor.whiteColor];
    [self.navigationController.navigationBar setValue:@(YES) forKeyPath:@"hidesShadow"];    // remove the bottom line of navigation bar
    
    [self setNavigationBarLeftButtons];  // navigation Whatsapp leftBarButtonItem
    [self setNavigationBarRightButtons]; // navigation rightBarButtonItems
    
    [self initNavigatorView];
    [self initDisplayView];
    [self configConstrains];
}

- (void) setNavigationBarLeftButtons {
    UILabel* label = UILabel.new;
    [label setText: @"WhatsApp"];
    [label setTextColor: UIColor.whiteColor];
    [label setFont: [UIFont boldSystemFontOfSize:22]];
    label.textAlignment = NSTextAlignmentLeft;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:label];
}

- (void) setNavigationBarRightButtons {
    UIBarButtonItem *searchButton = [[UIBarButtonItem alloc] initWithImage:[UIImage systemImageNamed:@"magnifyingglass"] style:UIBarButtonItemStylePlain target:self action:nil];
    [searchButton setTintColor: UIColor.whiteColor];
    UIBarButtonItem *moreButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icons-more"] style:UIBarButtonItemStylePlain target:self action:nil];
    [moreButton setTintColor: UIColor.whiteColor];
    self.navigationItem.rightBarButtonItems = @[moreButton, searchButton];
}

- (void) initNavigatorView {
    _navigatorView = UIView.new;
    [_navigatorView.layer setBorderWidth: 0];
    [_navigatorView setBackgroundColor: [UIColor colorWithRed:6/255.0 green:95/255.0 blue:84/255.0 alpha:1.0]];
    [_navigatorView setTranslatesAutoresizingMaskIntoConstraints: NO];
    [self.view addSubview:_navigatorView];
    
    HighlightButtonView *navigatorCameraButtonView = HighlightButtonView.new;
    [navigatorCameraButtonView.labelButton setImage:[UIImage systemImageNamed:@"camera"] forState:UIControlStateNormal];
    [navigatorCameraButtonView.labelButton setTintColor:UIColor.whiteColor];
    [navigatorCameraButtonView setTranslatesAutoresizingMaskIntoConstraints: NO];
    
    HighlightButtonView *navigatorChatsButtonView = HighlightButtonView.new;
    [navigatorChatsButtonView.labelButton setTitle:@"CHATS" forState:UIControlStateNormal];
    [navigatorChatsButtonView setTranslatesAutoresizingMaskIntoConstraints: NO];
    
    HighlightButtonView *navigatorStatusButtonView = HighlightButtonView.new;
    [navigatorStatusButtonView.labelButton setTitle:@"STATUS" forState:UIControlStateNormal];
    [navigatorStatusButtonView setTranslatesAutoresizingMaskIntoConstraints: NO];
    
    HighlightButtonView *navigatorCallsButtonView = HighlightButtonView.new;
    [navigatorCallsButtonView.labelButton setTitle:@"CALLS" forState:UIControlStateNormal];
    [navigatorCallsButtonView setTranslatesAutoresizingMaskIntoConstraints: NO];
    
    [_navigatorView addSubview: navigatorCameraButtonView];
    [_navigatorView addSubview: navigatorChatsButtonView];
    [_navigatorView addSubview: navigatorStatusButtonView];
    [_navigatorView addSubview: navigatorCallsButtonView];
    
    _navigatorButtonViews = @[navigatorCameraButtonView, navigatorChatsButtonView, navigatorStatusButtonView, navigatorCallsButtonView];
    for(int i=0; i<[_navigatorButtonViews count]; i++){
        UITapGestureRecognizer *singleFingerTap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                action:@selector(tapHighlightButton:)];
        [_navigatorButtonViews[i].labelButton addGestureRecognizer:singleFingerTap];
        _navigatorButtonViews[i].labelButton.tag = i;
    }
    
    [_navigatorView addConstraint:[NSLayoutConstraint constraintWithItem:navigatorCameraButtonView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0 constant:42]];
    [_navigatorView addConstraint:[NSLayoutConstraint constraintWithItem:navigatorCameraButtonView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:_navigatorView attribute:NSLayoutAttributeHeight multiplier:1 constant:0]];
    [_navigatorView addConstraint:[NSLayoutConstraint constraintWithItem:navigatorCameraButtonView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:_navigatorView attribute:NSLayoutAttributeLeading multiplier:1 constant:0]];
    
    [_navigatorView addConstraint:[NSLayoutConstraint constraintWithItem:navigatorChatsButtonView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:_navigatorView attribute:NSLayoutAttributeWidth multiplier:1/3.0 constant:-14]];
    [_navigatorView addConstraint:[NSLayoutConstraint constraintWithItem:navigatorChatsButtonView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:_navigatorView attribute:NSLayoutAttributeHeight multiplier:1 constant:0]];
    [_navigatorView addConstraint:[NSLayoutConstraint constraintWithItem:navigatorChatsButtonView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:navigatorCameraButtonView attribute:NSLayoutAttributeTrailing multiplier:1 constant:0]];
    
    [_navigatorView addConstraint:[NSLayoutConstraint constraintWithItem:navigatorStatusButtonView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:_navigatorView attribute:NSLayoutAttributeWidth multiplier:1/3.0 constant:-14]];
    [_navigatorView addConstraint:[NSLayoutConstraint constraintWithItem:navigatorStatusButtonView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:_navigatorView attribute:NSLayoutAttributeHeight multiplier:1 constant:0]];
    [_navigatorView addConstraint:[NSLayoutConstraint constraintWithItem:navigatorStatusButtonView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:navigatorChatsButtonView attribute:NSLayoutAttributeTrailing multiplier:1 constant:0]];
    
    [_navigatorView addConstraint:[NSLayoutConstraint constraintWithItem:navigatorCallsButtonView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:_navigatorView attribute:NSLayoutAttributeWidth multiplier:1/3.0 constant:-14]];
    [_navigatorView addConstraint:[NSLayoutConstraint constraintWithItem:navigatorCallsButtonView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:_navigatorView attribute:NSLayoutAttributeHeight multiplier:1 constant:0]];
    [_navigatorView addConstraint:[NSLayoutConstraint constraintWithItem:navigatorCallsButtonView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:navigatorStatusButtonView attribute:NSLayoutAttributeTrailing multiplier:1 constant:0]];
}

- (void) configConstrains {
    NSDictionary *binding = @{
        @"nav" : _navigatorView,
        @"view" : _displayView
    };
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[nav]-0-|" options:0 metrics:nil views:binding]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[view]-0-|" options:0 metrics:nil views:binding]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[nav(==54)]-0-[view]-0-|" options:0 metrics:nil views:binding]];
}


- (void) initDisplayView {
    _dataSources = @[@"Camera", @"Chats", @"Status", @"Calls"];
    
    _displayView = UIView.new;
    [_displayView setBackgroundColor:[UIColor redColor]];
    [_displayView setTranslatesAutoresizingMaskIntoConstraints: NO];
    [self.view addSubview:_displayView];
    
    pageViewController = [[PageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    pageViewController.delegate = self;
    pageViewController.dataSource = self;
    
    [self addChildViewController: pageViewController];
    [pageViewController didMoveToParentViewController: self];
    [pageViewController.view setTranslatesAutoresizingMaskIntoConstraints: NO];
    [_displayView addSubview:pageViewController.view];
    
    [_displayView addConstraint: [NSLayoutConstraint constraintWithItem:pageViewController.view attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:_displayView attribute:NSLayoutAttributeWidth multiplier:1 constant:0]];
    [_displayView addConstraint: [NSLayoutConstraint constraintWithItem:pageViewController.view attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:_displayView attribute:NSLayoutAttributeHeight multiplier:1 constant:0]];
    [_displayView addConstraint: [NSLayoutConstraint constraintWithItem:pageViewController.view attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:_displayView attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    [_displayView addConstraint: [NSLayoutConstraint constraintWithItem:pageViewController.view attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_displayView attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
    
    ContractTableViewController *startingViewController = (ContractTableViewController*)[self detailViewControllerAt:currentViewControllerIndex];
    startingViewController.view.tag = 0;
    if(startingViewController == nil){
        return;
    }
    [pageViewController setViewControllers:@[startingViewController] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
}


- (UIViewController *) detailViewControllerAt: (NSInteger) index {
    if(index >= [_dataSources count]){
        return nil;
    }
    
    ContractTableViewController *detailViewController = ContractTableViewController.new;
    if(detailViewController == nil){
        return nil;
    }
    
    detailViewController.view.tag = index;
    
    return detailViewController;
}
// The page control is only displayed if the datasource implements the following two methods:

//- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController {
//    return currentViewControllerIndex;
//}
//
//- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {
//    return [_dataSources count];
//}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    ContractTableViewController *vc = (ContractTableViewController*)viewController;
    NSInteger currentIndex = vc.view.tag;
    if (currentIndex == 0) {
        return nil;
    }
    currentIndex -= 1;
    currentViewControllerIndex = currentIndex;
    return [self detailViewControllerAt:currentIndex];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    ContractTableViewController *vc = (ContractTableViewController*)viewController;
    NSInteger currentIndex = vc.view.tag;
    if (currentIndex == [_dataSources count]) {
        return nil;
    }
    currentIndex += 1;
    currentViewControllerIndex = currentIndex;
    return [self detailViewControllerAt:currentIndex];
}

- (void) tapHighlightButton: (UITapGestureRecognizer*)sender {
    UIView *view = sender.view;
    UIViewController *vc = [self detailViewControllerAt:view.tag];
    [pageViewController setViewControllers:@[vc] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
}

@end
