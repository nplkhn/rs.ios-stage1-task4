#import "ArrayCalculator.h"

@implementation ArrayCalculator
+ (NSInteger)maxProductOf:(NSInteger)numberOfItems itemsFromArray:(NSArray *)array {
    NSArray *filteredArray = [NSArray arrayWithArray:[self filterArray:array]];
    int product = 1;
    if (!filteredArray.count) {
        return 0;
    } else if (numberOfItems >= filteredArray.count) {
        for (int i = 0; i < filteredArray.count; i++) {
            product *= [filteredArray[i] intValue];
        }
        return product;
    }
    
    NSMutableArray *positiveArray = [NSMutableArray arrayWithArray:[self separatePositiveNumbers:YES fromArray:filteredArray]];
    NSMutableArray *negativeArray = [NSMutableArray arrayWithArray:[self separatePositiveNumbers:NO fromArray:filteredArray]];
    [positiveArray sortUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"self" ascending:NO]]];
    [negativeArray sortUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"self" ascending:YES]]];
    
    int maxProduct = INT_MIN;
    for (int searches = 0; searches < floor(numberOfItems/2); searches++) {
        product = 1;
        product *= [self searchForNegativeNumbersFrom:negativeArray thatGreaterThan:[positiveArray[searches*2 + 1] intValue]];
        product *= [self productOfNumber:numberOfItems - searches*2 elementsOfArray:positiveArray];
        if (product > maxProduct) {
            maxProduct = product;
        }
    }
    return maxProduct;
}

+ (NSArray*)filterArray:(NSArray*)array {
    NSMutableArray *result = [NSMutableArray new];
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[NSNumber class]]) {
            [result addObject:obj];
        }
    }];
    return result;
}

+ (NSArray*)separatePositiveNumbers:(BOOL)isPositive fromArray:(NSArray*)array {
    NSMutableArray *filteredArray = [NSMutableArray new];
    if (isPositive) {
        [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj intValue] >= 0) {
                [filteredArray addObject:obj];
            }
        }];
    } else {
        [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj intValue] < 0) {
                [filteredArray addObject:obj];
            }
        }];
    }
    return filteredArray;
}

+ (NSInteger)searchForNegativeNumbersFrom:(NSArray*)array thatGreaterThan:(NSInteger)number {
    NSMutableArray *negativeNumbers = [NSMutableArray new];
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (abs([obj intValue]) >= number) {
            [negativeNumbers addObject:obj];
        }
    }];
    if (negativeNumbers.count % 2 != 0) {
        [negativeNumbers removeLastObject];
    }
    __block int product = 1;
    [negativeNumbers enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        product *= [obj intValue];
    }];
    return product;
}

+ (NSInteger)productOfNumber:(NSInteger)number elementsOfArray:(NSArray*)array {
    __block int product = 1;
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx + 1 <= number) {
            product *= [obj intValue];
        }
    }];
    return product;
}

@end
