#import <Foundation/Foundation.h>

@interface DESUtils : NSObject
+(NSString*) generateDESKey;
+(NSString*) decryptUseDES:(NSString*)cipherText key:(NSString*)key;
+(NSString *) encryptUseDES:(NSString *)clearText key:(NSString *)key;
@end
