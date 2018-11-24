

#import "ViewController.h"
#import "SAMKeychain.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    [self checkSSKeychain];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"删除账号");
    NSString *bundleID = [[NSBundle mainBundle] bundleIdentifier];//获得本应用的bundle ID
    NSLog(@"bundle id = %@", bundleID);
    NSError *error = nil;
    [SAMKeychain deletePasswordForService:bundleID account:@"im" error:&error];

}

- (void)checkSSKeychain
{
    /*
     1、用builder 作为服务名称
     2、
     */
    NSString *bundleID = [[NSBundle mainBundle] bundleIdentifier];//获得本应用的bundle ID
    NSLog(@"bundle id = %@", bundleID);
    NSError *error = nil;
    [SAMKeychain passwordForService: bundleID account: @"im" error: &error];

    NSLog(@"error %zd",[error code]);
    if([error code] == -25300){
        NSLog(@"无密码");
        [SAMKeychain setAccessibilityType:kSecAttrAccessibleWhenUnlockedThisDeviceOnly];//设置该密码的权限只有在手机解锁、此台设备才可获得。
        [SAMKeychain setPassword:@"zhanghao" forService:bundleID account:@"im"];
        [SAMKeychain setPassword:@"mima" forService:bundleID account:@"pwd"];

    }
    else {
        NSLog(@"账号是 %@", [SAMKeychain passwordForService: bundleID account: @"im"]);
        NSLog(@"密码是 %@", [SAMKeychain passwordForService: bundleID account: @"pwd"]);
        
        NSLog(@"所有账号是 %@", [SAMKeychain accountsForService: bundleID]);

    }
}

@end
