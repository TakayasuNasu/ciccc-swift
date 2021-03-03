//
//  Kitchen.m
//  Lab8-PizzaRestaurant
//
//  Created by Takayasu Nasu on 2021/03/01.
//

#import "Kitchen.h"
#import "CheeryManager.h"
#import "DislikeAnchovieManager.h"

@implementation Kitchen

- (instancetype)init
{
  self = [super init];
  if (self) {
    NSInteger randomNumber = arc4random_uniform(2);
    if (randomNumber == 0) {
      CheeryManager *manager = [[CheeryManager alloc] init];
      _delegate = manager;
    } else {
      DislikeAnchovieManager *manager = [[DislikeAnchovieManager alloc] init];
      _delegate = manager;
    }
  }
  return self;
}

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
  BOOL shouldMake = [[self delegate] kitchen:self shouldMakePizzaOfSize: size andToppings:toppings];
  if (!shouldMake) {
    //
  }

  BOOL shouldUpgradeOrder = [[self delegate] kitchenShouldUpgradeOrder: self];
  if (shouldUpgradeOrder) {
    size = (NSInteger *)large;
  }

  Pizza *pizza = [[Pizza alloc] initWitSize: size AndTopping: toppings];
  BOOL hasMethod = [[self delegate] respondsToSelector:@selector(kitchenDidMakePizza:)];
  if (hasMethod) {
    [[self delegate] kitchenDidMakePizza: pizza];
  }
  return pizza;
}

@end
