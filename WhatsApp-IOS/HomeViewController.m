//
//  HomeViewController.m
//  WhatsApp-IOS
//
//  Created by 葛帅琦 on 6/16/20.
//  Copyright © 2020 Shuaiqi Ge. All rights reserved.
//

#import "HomeViewController.h"
#import "HighlightButtonView.h"
#import "UIHighlightButton.h"
#import "ContractTableViewController.h"
#import "PageChatsTableViewController.h"
#import "PageStatusTableViewController.h"
#import "PageCallsTableViewController.h"
#import "PopoverViewController.h"
#import "Color.h"
#import "TBDFullScreenViewController.h"


@interface HomeViewController ()
@property UIView* navigatorView;
@property UIView* displayView;
@property NSArray<NSString *> *pageStatus;
@property NSArray<HighlightButtonView *> *navigatorButtonViews;
@end

@implementation HomeViewController

NSInteger currentViewControllerIndex = 1;
UIPageViewController *pageViewController;
UIHighlightButton *button;

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
}

- (void)viewWillLayoutSubviews {
    for(int i=0; i<[_navigatorButtonViews count]; i++){
        _navigatorButtonViews[i].labelButton.boundSize = _navigatorButtonViews[i].bounds;
    }
}

- (void) setupView {
    [self.view setBackgroundColor: WhiteColor];
    [self.navigationController.navigationBar setValue:@(YES) forKeyPath:@"hidesShadow"];    // remove the bottom line of navigation bar
    
    [self setNavigationBarLeftButtons];  // navigation Whatsapp leftBarButtonItem
    [self setNavigationBarRightButtons]; // navigation rightBarButtonItems
    
    [self initNavigatorView];
    [self initPageControllerView];
    [self configConstrains];
    [self setFloatButton];
}

- (void) setFloatButton {
    const NSInteger radius = 30;
    button = UIHighlightButton.new;
    // set default image
    [button setImage:[UIImage imageNamed:@"ic_message"] forState: UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"ic_message"] forState: UIControlStateHighlighted];
    [button setImageEdgeInsets: UIEdgeInsetsMake(15, 15, 15, 15)];
    [button setFrame: CGRectMake(0, 0, radius*2, radius*2)];
    button.rounded = YES;
    // set color
    [button setBackgroundColor: LightGreenColor];
    button.normalColor = LightGreenColor;
    button.highlightMaskColor = HighlightMaskColor;
    [button setTintColor: WhiteColor];
    // set zposition of view and corner radius
    [button.layer setZPosition: 1];
    button.layer.cornerRadius = radius;
    // add shadow of button
    [button.layer setShadowOffset:CGSizeMake(2, 2)];
    [button.layer setShadowColor:[[UIColor grayColor] CGColor]];
    [button.layer setShadowOpacity:0.4];
    // set target and action of button
    [button addTarget:self action:@selector(tapFloatButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview: button];
    [button setTranslatesAutoresizingMaskIntoConstraints: NO];
    [self.view addConstraint: [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:radius*2]];
    [self.view addConstraint: [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:radius*2]];
    [self.view addConstraint: [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1 constant:-30]];
    [self.view addConstraint: [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1 constant:-30]];
}

- (void) setNavigationBarLeftButtons {
    UILabel* label = UILabel.new;
    [label setText: @"WhatsApp"];
    [label setTextColor: WhiteColor];
    [label setFont: [UIFont boldSystemFontOfSize:22]];
    label.textAlignment = NSTextAlignmentLeft;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:label];
}

- (void) setNavigationBarRightButtons {
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

- (void) initNavigatorView {
    _navigatorView = UIView.new;
    [_navigatorView.layer setBorderWidth: 0];
    [_navigatorView setBackgroundColor: DarkTealGreenColor];
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
    [navigatorCameraButtonView.labelButton setTintColor: WhiteColor];
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
        _navigatorButtonViews[i].labelButton.rounded = NO;
        _navigatorButtonViews[i].labelButton.normalColor = DarkTealGreenColor;
        _navigatorButtonViews[i].labelButton.highlightMaskColor = HighlightMaskColor;
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


- (void) initPageControllerView {
    _pageStatus = @[@"Camera", @"Chats", @"Status", @"Calls"];
    
    _displayView = UIView.new;
    [_displayView setBackgroundColor: WhiteColor];
    [_displayView setTranslatesAutoresizingMaskIntoConstraints: NO];
    [self.view addSubview:_displayView];
    
    pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
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
    
    UIViewController *startingViewController = [self detailViewControllerAt:currentViewControllerIndex];
    startingViewController.view.tag = currentViewControllerIndex;
    [self focusHighlightButtonView: currentViewControllerIndex];
    if(startingViewController == nil){
        return;
    }
    [pageViewController setViewControllers:@[startingViewController] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
}


- (UIViewController *) detailViewControllerAt: (NSInteger) index {
    if(index >= [_pageStatus count]){
        return nil;
    }
    
    UIViewController *detailViewController;
    if(index == 0){
        detailViewController = TBDFullScreenViewController.new;
    }else if(index == 2){
        detailViewController = PageStatusTableViewController.new;
    }else if(index == 3){
        detailViewController = PageCallsTableViewController.new;
    }else{
        detailViewController = PageChatsTableViewController.new;
    }
    
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
    PageChatsTableViewController *vc = (PageChatsTableViewController*)viewController;
    NSInteger currentIndex = vc.view.tag;
    currentIndex -= 1;
    if (currentIndex < 0) {
        return nil;
    }
    if (currentIndex == 0){
        [self showTBDController];
        currentViewControllerIndex = 1;
        return [self detailViewControllerAt:1];
    }
    return [self detailViewControllerAt:currentIndex];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    PageChatsTableViewController *vc = (PageChatsTableViewController*)viewController;
    NSInteger currentIndex = vc.view.tag;
    currentIndex += 1;
    if (currentIndex == [_pageStatus count]) {
        return nil;
    }
    return [self detailViewControllerAt:currentIndex];
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed {
    if (completed && pageViewController.viewControllers.count != 0){
        currentViewControllerIndex = pageViewController.viewControllers[0].view.tag;
        [self updateFloatButton];
        [self focusHighlightButtonView:currentViewControllerIndex];
    }
}

- (void)showTBDController {
    TBDFullScreenViewController *vc = TBDFullScreenViewController.new;
    vc.modalPresentationStyle = UIModalPresentationFullScreen; //or .overFullScreen for transparency
    [self presentViewController:vc animated:NO completion:nil];
}

- (void)updateFloatButton {
    if([_pageStatus[currentViewControllerIndex] isEqualToString:@"Status"]) {
        [button setImage:[UIImage imageNamed:@"ic_camera"] forState: UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"ic_camera"] forState: UIControlStateHighlighted];
    } else if ([_pageStatus[currentViewControllerIndex] isEqualToString:  @"Calls"]) {
        [button setImage:[UIImage imageNamed:@"ic_full_call"] forState: UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"ic_full_call"] forState: UIControlStateHighlighted];
    } else {
        [button setImage:[UIImage imageNamed:@"ic_message"] forState: UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"ic_message"] forState: UIControlStateHighlighted];
    }
}

- (void) tapHighlightButton: (UITapGestureRecognizer*)sender {
//    NSLog(@"%zd", currentViewControllerIndex);
    UIView *view = sender.view;
    NSInteger index = view.tag;
    if(index == 0){
        [self showTBDController];
        index = 1;
    }
    if (index != currentViewControllerIndex){
        // page moving direction depends on relative position of current page and target page
        UIPageViewControllerNavigationDirection direction = index > currentViewControllerIndex ?
        UIPageViewControllerNavigationDirectionForward : UIPageViewControllerNavigationDirectionReverse;
        currentViewControllerIndex = index;
        UIViewController *vc = [self detailViewControllerAt: index];
        [self focusHighlightButtonView:currentViewControllerIndex];
        [self updateFloatButton];
        [pageViewController setViewControllers:@[vc] direction:direction animated:YES completion:nil];
    }
}

- (void) tapFloatButton: (UITapGestureRecognizer*)sender {
    if(currentViewControllerIndex == 1){
        ContractTableViewController *viewController = [[ContractTableViewController alloc] init];
        [self.navigationController pushViewController:viewController animated:YES];
    }else{
        TBDFullScreenViewController *vc = TBDFullScreenViewController.new;
        vc.modalPresentationStyle = UIModalPresentationFullScreen; //or .overFullScreen for transparency
        [self presentViewController:vc animated:YES completion:nil];
    }
}

- (void) focusHighlightButtonView: (NSInteger) index {
    for(int i=0; i<[_navigatorButtonViews count]; i++){
        [_navigatorButtonViews[i].highlightLine setBackgroundColor: DarkTealGreenColor];
    }
    [_navigatorButtonViews[index].highlightLine setBackgroundColor: WhiteColor];
}

- (void) tapPopoverMenu {
    PopoverViewController* controller = PopoverViewController.new; // your initialization goes here
    controller.labelsArray = @[@"New group", @"New broadcase", @"WhatsApp Web", @"Starred messages", @"Settings"];
    // set modal presentation style to popover on your view controller
    // must be done before you reference controller.popoverPresentationController
    controller.modalPresentationStyle = UIModalPresentationPopover;
    controller.preferredContentSize = CGSizeMake(180, 200);

    // configure popover style & delegate
    UIPopoverPresentationController *popover =  controller.popoverPresentationController;
    popover.delegate = self;
    popover.sourceView = self.view;
    popover.sourceRect = CGRectMake(self.view.bounds.size.width,0,0,0);
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
