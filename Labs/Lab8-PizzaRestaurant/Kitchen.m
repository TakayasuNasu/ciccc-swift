//
//  Kitchen.m
//  Lab8-PizzaRestaurant
//
//  Created by Takayasu Nasu on 2021/03/01.
//

#import "Kitchen.h"

@implementation Kitchen

- (Pizza *) order:(NSArray *) orderOfUser
{
  PizzaSize *size = GetPizzaSize(orderOfUser[0]);
  if (size == NULL) {
    size = (NSInteger *)small;
  }
  NSArray *toppings = [self shiftArray:orderOfUser :1];

  if ([toppings[0] isEqualToString: @"pepperoni"]) {
    return [Pizza largePepperoni];
  }

  if ([toppings[0] isEqualToString: @"meat"]) {
    return [Pizza meatLoversWithSize:size];
  }
  return [self makePizzaWithSize:size toppings:toppings];
}

- (NSArray *) shiftArray: (NSArray *) array :(NSInteger) pos
{
  NSInteger length = [array count];
  NSArray *post = [array subarrayWithRange:(NSRange){ .location = length - pos, .length = pos }];
  NSArray *pre = [array subarrayWithRange:(NSRange){ .location = 0, .length = length - pos}];
  return [post arrayByAddingObjectsFromArray:pre];
}


- (Pizza *) makePizzaWithSize:(PizzaSize *) size toppings:(NSArray *) toppings
{
  BOOL shouldMake = [[self delegate] kitchen:self shouldMakePizzaOfSize:*size andToppings:toppings];
  if (!shouldMake) {
    //
  }

  BOOL shouldUpgradeOrder = [[self delegate] kitchenShouldUpgradeOrder: self];
  if (shouldUpgradeOrder) {
    size = (NSInteger *)large;
  }
  return [[Pizza alloc] initWitSize: size AndTopping: toppings];
}

@end
