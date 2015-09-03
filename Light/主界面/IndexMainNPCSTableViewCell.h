//
//  IndexMainNPCSTableViewCell.h
//  Light
//
//  Created by 郑来贤 on 15/8/30.
//  Copyright (c) 2015年 Light. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LightNPC.h"

@protocol IndexMainNPCSTableViewCellDelegate;
@interface IndexMainNPCSTableViewCell : UITableViewCell

@property (weak , nonatomic) id<IndexMainNPCSTableViewCellDelegate > delegate;

+ (instancetype)initFromNib;

- (void)disPlayWithNPCS:(NSArray * )npcs;

@end

@protocol IndexMainNPCSTableViewCellDelegate <NSObject>

- (void)cell:(IndexMainNPCSTableViewCell *)cell didSelectedUser:(LightNPC *)npc;

@end
