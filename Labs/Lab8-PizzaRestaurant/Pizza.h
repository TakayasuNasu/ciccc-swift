//
//  Pizza.h
//  Lab8-PizzaRestaurant
//
//  Created by Takayasu Nasu on 2021/03/01.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


typedef NS_ENUM(NSInteger, PizzaSize) {
  small,
  medium,
  large
};

#define GetPizzaSizeText(size) PizzaSizeTextList[size]
#define GetPizzaSize(sizeText) (PizzaSize *)[PizzaSizeTextList indexOfObject:sizeText]
#define PizzaSizeTextList @[@"small",@"medium",@"large"]

@interface Pizza : NSObject

@property PizzaSize *size;
@property NSArray *toppings;

+ (Pizza *) largePepperoni;
+ (Pizza *) meatLoversWithSize: (PizzaSize *) size;
- (instancetype)initWitSize: (PizzaSize *) size AndTopping: (NSArray *)toppings;

@end

NS_ASSUME_NONNULL_END
