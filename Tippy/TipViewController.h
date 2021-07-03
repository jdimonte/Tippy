//
//  TipViewController.h
//  Tippy
//
//  Created by Jacqueline DiMonte on 6/22/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TipViewController : UIViewController

@property (strong, nonatomic) NSNumber *customPercent;
@property (strong, nonatomic) NSNumber *customTip;
@property bool customPercentOn;
@property bool customTipOn;

@end

NS_ASSUME_NONNULL_END
