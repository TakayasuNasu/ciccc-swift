//
//  main.m
//  Lab9
//
//  Created by Takayasu Nasu on 2021/03/03.
//

#import <Foundation/Foundation.h>
#import "Chef.h"
#import "Cook.h"

int main(int argc, const char * argv[]) {
  @autoreleasepool {

    FoodTruck *truckBao = [[FoodTruck alloc] initWithName:@"Take a Bao" andFoodType:@"bao"];
    FoodTruck *truckShortons = [[FoodTruck alloc] initWithName:@"Tim Shortons" andFoodType:@"shortbread"];
    Chef *chef = [[Chef alloc] init];
    Cook *cook = [[Cook alloc] init];

    [truckBao setDelegate:chef];
    [truckShortons setDelegate:chef];

    [truckBao serve:10];
    [truckShortons serve:5];
    
    [truckBao cashOut];
    [truckShortons cashOut];

    [truckBao setDelegate:cook];
    [truckShortons setDelegate:cook];

    [truckBao serve:10];
    [truckShortons serve:5];

    [truckBao cashOut];
    [truckShortons cashOut];

  }
  return 0;
}
