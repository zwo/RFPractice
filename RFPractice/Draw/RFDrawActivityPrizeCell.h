// 已开奖的cell展示

typedef void(^HandleFoldAction)(NSIndexPath *indexPath, BOOL fold); // yes to fold, no to unfold
@interface RFDrawActivityPrizeCell : UITableViewCell

@property (nonatomic,copy) HandleFoldAction handleFoldAction;
@property (nonatomic,copy) NSIndexPath *indexPath;
- (void)hideDashLine:(BOOL)hide;
+ (CGFloat)cellHeight;

@end

typedef void(^HandleIMBlock)(); 
typedef void(^HandlePhoneBlock)(); 

@interface RFDrawActivityPrizeHeaderCell : UITableViewCell

@property (nonatomic,copy) HandleIMBlock handleIMBlock;
@property (nonatomic,copy) HandlePhoneBlock handlePhoneBlock;
+ (CGFloat)cellHeight;

@end

@interface RFDrawActivityPrizeDetailCell : UITableViewCell

- (void)setupUIWithArray:(NSArray *)array;
+ (CGFloat)cellHeightWithItemsCount:(NSInteger)count;

@end