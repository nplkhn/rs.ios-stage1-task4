#import "SquareDecomposer.h"

@implementation SquareDecomposer
- (NSArray <NSNumber*>*)decomposeNumber:(NSNumber*)number {
    NSMutableArray *result = [self decomposeNumber:number withResidual:@([number longLongValue]*[number longLongValue])];
    return [result isEqual:nil]?nil:[result subarrayWithRange:NSMakeRange(0, result.count - 1)];
}

- (NSMutableArray*)decomposeNumber:(NSNumber*)number withResidual:(NSNumber*)residual {
    NSMutableArray *array = [NSMutableArray new];
    if ([residual longLongValue] == 0) {
        [array addObject:number];
        return array;
    }
    for (NSInteger i = [number longLongValue] - 1; i > 0; i--) {
        if ([residual longLongValue] - i*i >= 0) {
            NSMutableArray *res = [self decomposeNumber:@(i) withResidual:@([residual longLongValue]-i*i)];
            if (res) {
                [res addObject:number];
                return res;
            }
        }
    }
    return nil;
    
    
}
@end
