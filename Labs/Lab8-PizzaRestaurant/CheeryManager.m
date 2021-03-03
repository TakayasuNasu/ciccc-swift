//
//  CheeryManager.m
//  Lab8-PizzaRestaurant
//
//  Created by Takayasu Nasu on 2021/03/02.
//

#import "CheeryManager.h"

@implementation CheeryManager

- (BOOL) kitchen:(Kitchen *)kitchen shouldMakePizzaOfSize:(PizzaSize *)size andToppings:(NSArray *)toppings
{
  return true;
}

- (BOOL) kitchenShouldUpgradeOrder:(Kitchen *)kitchen
{
  NSLog(@"say");
  return true;
}


@end
