//
//  CGPopoverTableController.h
//  CGPopoverController
//
//  Created by 徐晨光 on 2018/9/3.
//

#import "CGPopoverController.h"

typedef void(^CGPopoverTableDidSelectBlock)(NSIndexPath *indexPath);

@interface CGPopoverTableController : CGPopoverController

@property (nonatomic, assign) CGFloat rowHeight;// default is 40
@property (nonatomic, copy) CGPopoverTableDidSelectBlock didSelectRowBlock;
@property (nonatomic, readonly) NSArray *items;

/**
 init
 
 @param items NSString or NSAttributedText
 @return CGPopoverTableController
 */
- (instancetype)initWithItems:(NSArray *)items;

/**
 reload

 @param items NSString or NSAttributedText
 */
- (void)reloadTableViewForItems:(NSArray *)items;

@end
