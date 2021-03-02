//
//  Pizza.m
//  Lab8-PizzaRestaurant
//
//  Created by Takayasu Nasu on 2021/03/01.
//

#import "Pizza.h"

@implementation Pizza

- (instancetype)initWitSize: (PizzaSize *) size AndTopping: (NSArray *)toppings
{
  self = [super init];
  if (self) {
    _size = size;
    _toppings = toppings;
  }
  return self;
}

+ (Pizza *) largePepperoni
{
  PizzaSize *size = (NSInteger *)large;
  return [[self alloc] initWitSize:size AndTopping:@[@"pepperoni"]];
}

+ (Pizza *) meatLoversWithSize: (PizzaSize *) size
{
  return [[self alloc] initWitSize:size AndTopping:@[@"meat"]];
}

@end
