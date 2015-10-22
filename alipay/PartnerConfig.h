//
//  PartnerConfig.h
//  AlipaySdkDemo
//
//  Created by ChaoGanYing on 13-5-3.
//  Copyright (c) 2013年 RenFei. All rights reserved.
//
//  提示：如何获取安全校验码和合作身份者id
//  1.用您的签约支付宝账号登录支付宝网站(www.alipay.com)
//  2.点击“商家服务”(https://b.alipay.com/order/myorder.htm)
//  3.点击“查询合作者身份(pid)”、“查询安全校验码(key)”
//

#ifndef MQPDemo_PartnerConfig_h
#define MQPDemo_PartnerConfig_h

//合作身份者id，以2088开头的16位纯数字
#define PartnerID @"2088512781442354"
//收款支付宝账号
#define SellerID  @"niceroad@qq.com"

//安全校验码（MD5）密钥，以数字和字母组成的32位字符
#define MD5_KEY @"51ums2vkitqf2juzhnhyvibca82ugby0"

//商户私钥，自助生成
#define PartnerPrivKey @"MIICdgIBADANBgkqhkiG9w0BAQEFAASCAmAwggJcAgEAAoGBAOTlYoakfzge16Mg2tEmefOcOP0uiILywqabo/EcDn+oG4ysYhjrmk18ZuUBzfKG3ZbodATxZC0Dshd+/9+ZSHQWUO1eStoytoW6QRJHcNYJ5890kD9pj7TV5q6RGZGXP3ljxrurIWBZSg+eUUa3YimT8UkqnEErhib+ssau2Kl1AgMBAAECgYBsAmXcnRC/Haapfl5i5SIUtzoZFnUqPX1mevkAVDnvORdO6SUdF0fnmnU/SPuynrs/c48TqgiYSS8ncTEyhLUv1cesLmQZaSrjhDOiENZqt9fc3zf1zNwQMlmSHOJxMiy9EPDKtxxN1tMtsughw94LIKx8biPB9VGkwj0WEE3y/QJBAPJn7xc1Xdd5Z+ClYzgevMUpYrPFL6doAEfkyIo94rnhKkNJnxi7VUS1cA89dkQbvgfuEZIOpKoLRzhlmV42p4sCQQDxu39IblHSRFZ0ctiFWqD6ODskTjgwqzPLOdAvd0LH5UPL/tLqCeI6GMMatJPYrM24Gtmq4Rp2794lEgLP4BL/AkAnJdHfFadKHTlBdnRHo+8oiD6Aed/wUUN6WOBqMwRisJJ6u3EONXLX3dVzIKHw7eoKrc/4npTJQXkHCqFyLbFxAkEAzsElzte81/FnWNZZ50Vq5lluDFFysf3coPfj3pVM4xhu8m4UC+VEP5iqV48X3X1/vvYIMqWyMwRapq5PBWmMFQJAV16aeEiqRzIaOuQZl5QdQZarU7K372DFHTbvMVqO17r/zfWbKdDIj8yrwbFAWuMYQ9HhoM/qnf0P7OUN6QMggg=="


//支付宝公钥
#define AlipayPubKey   @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDk5WKGpH84HtejINrRJnnznDj9LoiC8sKmm6PxHA5/qBuMrGIY65pNfGblAc3yht2W6HQE8WQtA7IXfv/fmUh0FlDtXkraMraFukESR3DWCefPdJA/aY+01eaukRmRlz95Y8a7qyFgWUoPnlFGt2Ipk/FJKpxBK4Ym/rLGrtipdQIDAQAB"

#endif
