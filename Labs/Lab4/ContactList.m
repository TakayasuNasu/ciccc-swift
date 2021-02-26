//
//  ContactList.m
//  Lab4
//
//  Created by Takayasu Nasu on 2021/02/25.
//

#import "ContactList.h"

@implementation ContactList

- (instancetype)init
{
  self = [super init];
  if (self) {
    _contacts = [NSMutableArray array];
  }
  return self;
}

@end
