#include <CommonCrypto/CommonCryptor.h>
#import "GTMBase64.h"
#import "DESUtils.h"

@implementation DESUtils
Byte iv[] = {1,2,3,4,5,6,7,8};

+(NSString*) generateDESKey{
    int n = [self getRandomNumber:10000000 to:90000001];
    NSString *desKey=[NSString stringWithFormat:@"%d",n];
    return desKey;
}

+(int)getRandomNumber:(int)from to:(int)to
{
    return (int)(from + (arc4random() % (to-from + 1)));
}

+(NSString*) decryptUseDES:(NSString*)cipherText key:(NSString*)key {
    // 解碼 Base64 字串
    NSData* cipherData = [GTMBase64 decodeString:cipherText];
    size_t plainTextBufferSize = [cipherData length];
    uint8_t *bufferPtr = NULL;
    size_t bufferPtrSize = 0;
    bufferPtrSize = (plainTextBufferSize + kCCBlockSizeDES) & ~(kCCBlockSizeDES - 1);
    bufferPtr = malloc( bufferPtrSize * sizeof(uint8_t));
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
    size_t numBytesDecrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                          kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding,
                                          [key UTF8String],
                                          kCCKeySizeDES,
                                          iv,
                                          [cipherData bytes],
                                          [cipherData length],
                                          (void *)bufferPtr,
                                          plainTextBufferSize,
                                          &numBytesDecrypted);
    NSString* plainText = nil;
    if (cryptStatus == kCCSuccess) {        
        NSData* data = [NSData dataWithBytes:bufferPtr length:(NSUInteger)numBytesDecrypted];        
        plainText = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease];
    }else{
        //NSLog(@"%@",@"解密失败！");
//        DEBUG_LOG(@"%@",@"解密失败！");
    }
    free(bufferPtr);
    return plainText;
}

+(NSString *) encryptUseDES:(NSString *)clearText key:(NSString *)key
{
    NSData *data = [clearText dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    size_t plainTextBufferSize = [data length];
    uint8_t *bufferPtr = NULL;
    size_t bufferPtrSize = 0;
    bufferPtrSize = (plainTextBufferSize + kCCBlockSizeDES) & ~(kCCBlockSizeDES - 1);
    bufferPtr = malloc( bufferPtrSize * sizeof(uint8_t));

    size_t numBytesEncrypted = 0;
    
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
                                          kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding,
                                          [key UTF8String],
                                          kCCKeySizeDES,
                                          iv,
                                          [data bytes],
                                          [data length],
                                          (void *)bufferPtr,
                                          bufferPtrSize,
                                          &numBytesEncrypted);
    
    NSString* plainText = nil;
    if (cryptStatus == kCCSuccess) {
        NSData *dataTemp = [NSData dataWithBytes:bufferPtr length:(NSUInteger)numBytesEncrypted];
        plainText = [GTMBase64 stringByEncodingData:dataTemp];
    }else{
        NSLog(@"DES加密失败");
        /**
         * @reqno:H1601260224
         * @date-designer:20160201-zhouzhipeng
         * @date-author:20160201-zhouzhipeng:关闭logcat日志打印功能，禁止工具获取到用户登录的敏感信息。
         *
         */
//        DEBUG_LOG(@"DES加密失败");
    }
    free(bufferPtr);
    return plainText;
}
@end
