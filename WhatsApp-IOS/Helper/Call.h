//
//  Call.h
//  WhatsApp-IOS
//
//  Created by 葛帅琦 on 6/19/20.
//  Copyright © 2020 Shuaiqi Ge. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Call : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *imageUrl;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *callType;
@property (nonatomic, strong) NSString *time;

@end

NS_ASSUME_NONNULL_END
