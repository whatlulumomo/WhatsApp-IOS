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
#import "PopoverViewController.h"


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
    UIBarButtonItem *moreButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icons-more"] style:UIBarButtonItemStylePlain target:self action:@selector(tapPopoverMenu:)];
    [moreButton setTintColor: UIColor.whiteColor];
    self.navigationItem.rightBarButtonItems = @[moreButton, searchButton];
}

- (void) initNavigatorView {
    _navigatorView = UIView.new;
    [_navigatorView.layer setBorderWidth: 0];
    [_navigatorView setBackgroundColor: [UIColor colorWithRed:6/255.0 green:95/255.0 blue:84/255.0 alpha:1.0]];
    [_navigatorView setTranslatesAutoresizingMaskIntoConstraints: NO];
    
    // setup shadow below the navigator view
    _navigatorView.layer.shadowColor = [UIColor grayColor].CGColor;
    _navigatorView.layer.shadowOffset = CGSizeMake(0, 1);
    _navigatorView.layer.shadowOpacity = 0.5;
    _navigatorView.layer.shadowRadius = 1.0;
    _navigatorView.layer.masksToBounds = NO;
    _navigatorView.layer.zPosition = 1;

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
    [self focusHighlightButtonView: 0];
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
//    [self focusHighlightButtonView: currentViewControllerIndex];
//    return currentViewControllerIndex;
//}
//
//- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {
//    return [_dataSources count];
//}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    ContractTableViewController *vc = (ContractTableViewController*)viewController;
    NSInteger currentIndex = vc.view.tag;
    currentIndex -= 1;
    if (currentIndex < 0) {
        return nil;
    }
    return [self detailViewControllerAt:currentIndex];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    ContractTableViewController *vc = (ContractTableViewController*)viewController;
    NSInteger currentIndex = vc.view.tag;
    currentIndex += 1;
    if (currentIndex == [_dataSources count]) {
        return nil;
    }
    return [self detailViewControllerAt:currentIndex];
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed {
    if (completed && pageViewController.viewControllers.count != 0){
        currentViewControllerIndex = pageViewController.viewControllers[0].view.tag;
        [self focusHighlightButtonView:currentViewControllerIndex];
    }
}

- (void) tapHighlightButton: (UITapGestureRecognizer*)sender {
    NSLog(@"%zd", currentViewControllerIndex);
    UIView *view = sender.view;
    NSInteger index = view.tag;
    if (index != currentViewControllerIndex){
        currentViewControllerIndex = index;
        UIViewController *vc = [self detailViewControllerAt: index];
        [pageViewController setViewControllers:@[vc] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    }
}

- (void) focusHighlightButtonView: (NSInteger) index {
    for(int i=0; i<[_navigatorButtonViews count]; i++){
        [_navigatorButtonViews[i].highlightLine setBackgroundColor:[UIColor colorWithRed:6/255.0 green:95/255.0 blue:84/255.0 alpha:1.0]];
    }
    [_navigatorButtonViews[index].highlightLine setBackgroundColor: UIColor.whiteColor];
}

- (void) tapPopoverMenu: (UITapGestureRecognizer*)sender {
    NSLog(@"Pop Over");
    UIViewController* controller = PopoverViewController.new; // your initialization goes here
//    [controller.view setBackgroundColor: UIColor.whiteColor];

    // set modal presentation style to popover on your view controller
    // must be done before you reference controller.popoverPresentationController
    controller.modalPresentationStyle = UIModalPresentationPopover;
    controller.preferredContentSize = CGSizeMake(180, 200);

    // configure popover style & delegate
    UIPopoverPresentationController *popover =  controller.popoverPresentationController;
    popover.delegate = self;
    popover.sourceView = sender.view;
    popover.sourceRect = CGRectMake(sender.view.center.x,sender.view.center.y,0,0);
    popover.permittedArrowDirections = 0;

    // display the controller in the usual way
    [self presentViewController:controller animated:YES completion:^{
        NSLog(@"finish");
        controller.view.superview.layer.cornerRadius = 0;
    }];
}

- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller {
    return UIModalPresentationNone;
}

@end
