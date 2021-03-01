//
//  Dice.m
//  Lab6
//
//  Created by Takayasu Nasu on 2021/02/28.
//

#import "Dice.h"

@implementation Dice

- (instancetype)init
{
  self = [super init];
  if (self) {
    _value = 0;
  }
  return self;
}

- (NSString *) description
{
  return [NSString stringWithFormat:@"Dice: %d",(int)[self value]];
}

- (NSString *) generateDiceIcon
{
  NSArray *diceIcons = @[@"⚀", @"⚁", @"⚂", @"⚃", @"⚄", @"⚅"];

  return diceIcons[[self value] -1];
}
@end
