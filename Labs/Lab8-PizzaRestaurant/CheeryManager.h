//
//  CheeryManager.h
//  Lab8-PizzaRestaurant
//
//  Created by Takayasu Nasu on 2021/03/02.
//

#import <Foundation/Foundation.h>
#import "Kitchen.h"

NS_ASSUME_NONNULL_BEGIN

@interface CheeryManager : NSObject <KitchenDelegate>

- (BOOL) kitchen:(Kitchen *)kitchen shouldMakePizzaOfSize:(PizzaSize *)size andToppings:(NSArray *)toppings;
- (BOOL) kitchenShouldUpgradeOrder:(Kitchen *)kitchen;

@end

NS_ASSUME_NONNULL_END
