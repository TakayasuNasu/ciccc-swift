//
//  DislikeAnchovieManager.m
//  Lab8-PizzaRestaurant
//
//  Created by Takayasu Nasu on 2021/03/02.
//

#import "DislikeAnchovieManager.h"

@implementation DislikeAnchovieManager

- (BOOL) kitchen:(Kitchen *)kitchen shouldMakePizzaOfSize:(PizzaSize *)size andToppings:(NSArray *)toppings
{
  BOOL shouldMake = true;
  for (NSString *topping in toppings) {
    if ([topping isEqualToString:@"anchovie"]) {
      shouldMake = false;
    }
  }
  return shouldMake;
}

- (BOOL) kitchenShouldUpgradeOrder:(Kitchen *)kitchen
{
  return false;
}

@end
