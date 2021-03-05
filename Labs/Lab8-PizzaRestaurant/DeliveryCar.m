//
//  DeliveryCar.m
//  Lab8-PizzaRestaurant
//
//  Created by Takayasu Nasu on 2021/03/03.
//

#import "DeliveryCar.h"

@implementation DeliveryCar


-(void) deliverPizza:(Pizza *)pizza
{
    NSLog(@"Pizza with %@ is Delivered", [[pizza toppings] componentsJoinedByString:@", "]);
}


@end
