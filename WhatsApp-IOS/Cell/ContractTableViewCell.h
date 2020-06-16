//
//  ChatTableViewCell.h
//  WhatsApp-IOS
//
//  Created by 葛帅琦 on 6/15/20.
//  Copyright © 2020 Shuaiqi Ge. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ContractTableViewCell : UITableViewCell {
    NSString *reuseID;
}

@property UIImageView *avatarImageView;
@property UILabel *nameLabel;
@property UILabel *messageLabel;

@end

NS_ASSUME_NONNULL_END
