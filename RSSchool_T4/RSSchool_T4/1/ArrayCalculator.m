#import "ArrayCalculator.h"

@implementation ArrayCalculator
+ (NSInteger)maxProductOf:(NSInteger)numberOfItems itemsFromArray:(NSArray *)array {
    NSArray* filteredArray = [array filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id  _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
        return [evaluatedObject isKindOfClass:[NSNumber class]];
    }]];
    filteredArray = [filteredArray sortedArrayUsingSelector:@selector(compare:)];
    NSInteger sum = 0;
    
    // good luck
    return -1;
}
@end
