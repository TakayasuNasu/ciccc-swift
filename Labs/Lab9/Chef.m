//
//  Chef.m
//  Lab9
//
//  Created by Takayasu Nasu on 2021/03/03.
//

#import "Chef.h"

@implementation Chef


- (double) foodTruck:(FoodTruck *)truck priceForFood:(NSString *)food
{
    if([food isEqualTo:@"bao"]) {
        return 5.0;
    }

    if([food isEqualTo:@"Tim Shortons"]) {
        return 10.5;
    }

    return 100;
}


@end
