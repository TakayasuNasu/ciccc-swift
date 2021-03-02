//
//  Kitchen.h
//  Lab8-PizzaRestaurant
//
//  Created by Takayasu Nasu on 2021/03/01.
//

#import <Foundation/Foundation.h>
#import "Pizza.h"

NS_ASSUME_NONNULL_BEGIN

@class Kitchen;

@protocol KitchenDelegate <NSObject>

@required

- (BOOL) kitchen:(Kitchen *)kitchen shouldMakePizzaOfSize:(PizzaSize)size andToppings:(NSArray *)toppings;
- (BOOL) kitchenShouldUpgradeOrder:(Kitchen *)kitchen;

@optional

- (void) kitchenDidMakePizza:(Pizza *) pizza;

@end

@interface Kitchen : NSObject

@property (weak, nonatomic) id <KitchenDelegate> delegate;

- (Pizza *) order:(NSArray *) orderOfUser;
- (Pizza *) makePizzaWithSize:(PizzaSize *) size toppings:(NSArray *)toppings;

@end

NS_ASSUME_NONNULL_END
