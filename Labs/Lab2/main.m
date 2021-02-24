//
//  main.m
//  Lab2
//
//  Created by Takayasu Nasu on 2021/02/22.
//

#import <Foundation/Foundation.h>
#import "DateCalculator.h"
#import "Box.h"

int main(int argc, const char * argv[]) {
  @autoreleasepool {
    DateCalculator *dc = [[DateCalculator alloc] initWithName: @"Adriano" AndAge: 30];
    if ([dc canDateAPersonWithAge: 23]) {
      NSLog(@"Yes %@", [dc name]);
    } else {
      NSLog(@"No");
    }

    Box *baseBox = [[Box alloc] initWithHeight: 10 Width: 10 AndLength: 10];
    NSLog(@"%f]", [baseBox calculateVolume]);
    for (int i = 0; i < 5; i++) {
      float height = arc4random() % 100 / 10.f;
      float width = arc4random() % 100 / 10.f;
      float length = arc4random() % 100 / 10.f;
      Box *newBox = [[Box alloc] initWithHeight: height Width: width AndLength: length];
      NSLog(@"%d", [baseBox countBoxWillFit: newBox]);
    }
  }
  return 0;
}
