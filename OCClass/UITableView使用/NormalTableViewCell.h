//
//  NormalTableViewCell.h
//  OCClass
//
//  Created by mac on 2021/3/3.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol NormalTableCellDelegate <NSObject>

- (void)tableViewCell:(UITableViewCell *)tableViewCell clickDeleteButton:(UIButton *)deleteButton;

@end

@interface NormalTableViewCell : UITableViewCell

@property(nonatomic, weak, readwrite) id<NormalTableCellDelegate> delegate;

- (void)layoutTableViewCell;

@end

NS_ASSUME_NONNULL_END
