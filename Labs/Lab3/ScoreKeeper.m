//
//  ScoreKeeper.m
//  Lab3
//
//  Created by Takayasu Nasu on 2021/02/24.
//

#import "ScoreKeeper.h"

@implementation ScoreKeeper

- (instancetype)init
{
  self = [super init];
  if (self) {
    _right = 0;
    _wrong = 0;
  }
  return self;
}

@end
