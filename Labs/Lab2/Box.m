//
//  Box.m
//  Lab2
//
//  Created by Takayasu Nasu on 2021/02/23.
//

#import "Box.h"

@implementation Box
{

}

- (instancetype)initWithHeight: (float) height Width: (float) width AndLength: (float) length
{
  self = [super init];
  if (self) {
    _height = height;
    _width = width;
    _length = length;
  }
  return self;
}

- (float) calculateVolume
{
  return [self height] * [self width] * [self length];
}

- (int) countBoxWillFit: (Box *) otherBox
{
  return [self calculateVolume] / [otherBox calculateVolume];
}

@end
