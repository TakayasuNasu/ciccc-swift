//
//  DateCalculator.m
//  Lab2
//
//  Created by Takayasu Nasu on 2021/02/23.
//

#import "DateCalculator.h"

@implementation DateCalculator {

}

- (instancetype)initWithName: (NSString *) name AndAge: (float) age
{
  self = [super init];
  if (self) {
    _name = name;
    _age = age;
  }
  return self;
}

- (BOOL) canDateAPersonWithAge: (float) age
{
  return (_age / 2 + 7) < age;
}

@end
