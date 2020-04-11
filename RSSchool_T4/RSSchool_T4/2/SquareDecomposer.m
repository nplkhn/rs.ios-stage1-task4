#import "SquareDecomposer.h"

@implementation SquareDecomposer
- (NSArray <NSNumber*>*)decomposeNumber:(NSNumber*)number {
    NSMutableArray<NSNumber*> *result = [NSMutableArray new];
    int intNumber = number.intValue;
    int residual;
    [result addObject:[NSNumber numberWithInt:intNumber - 1]];
    residual = pow(intNumber, 2) - pow(intNumber - 1, 2);
    
    while (residual > 1) {
        [result addObject:[NSNumber numberWithInt:floor(sqrt(residual))]];
        residual -= pow(floor(sqrt(residual)), 2);
    }
    return [result sortedArrayUsingSelector:@selector(compare:)];
}
@end
