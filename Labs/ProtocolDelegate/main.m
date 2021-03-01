//
//  main.m
//  ProtocolDelegate
//
//  Created by Takayasu Nasu on 2021/02/26.
//

#import <Foundation/Foundation.h>
#import "Boss.h"
#import "BadAccountant.h"
#import "GoodAccountant.h"


int main(int argc, const char * argv[]) {
  @autoreleasepool {
    Boss *boss = [Boss new];

    GoodAccountant *good = [GoodAccountant new];
    BadAccountant *bad = [BadAccountant new];
  }
  return 0;
}
