//
//  RealmDemoTests.m
//  RealmDemoTests
//
//  Created by Jentle on 2020/6/4.
//  Copyright © 2020 Jentle. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <Realm/Realm.h>
#import "Student.h"
#import "Person.h"
#import "Dog.h"
#import "ESRootClass.h"
#import "NoticeModel.h"
#import "DataModel.h"
#import "MigrateModel.h"

@interface RealmDemoTests : XCTestCase

/// token
@property(strong, nonatomic) RLMNotificationToken *token;
/// token
@property(strong, nonatomic) RLMNotificationToken *token2;

@end

@implementation RealmDemoTests

- (void)setUp {
    [super setUp];
//    RLMRealm *realm = [RLMRealm defaultRealm];
//    self.token = [realm addNotificationBlock:^(RLMNotification  _Nonnull notification, RLMRealm * _Nonnull realm) {
//        NSLog(@"监听到修改通知");
//    }];
    
//    RLMResults *results = [NoticeModel allObjects];
//    self.token2 = [results addNotificationBlock:^(RLMResults * _Nullable results, RLMCollectionChange * _Nullable change, NSError * _Nullable error) {
//        NSLog(@"results-%@",results);
//        NSLog(@"change-%@",change);
//        NSLog(@"error-%@",error);
//    }];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    
//    return;
    ///数据迁移：
    ///在[AppDelegate didFinishLaunchingWithOptions:]中进行设置
    RLMRealmConfiguration *config = [RLMRealmConfiguration defaultConfiguration];
    ///叠加版本号，要比上次的版本号高
    int newVersion = 11;
    config.schemaVersion = newVersion;
    config.migrationBlock = ^(RLMMigration * _Nonnull migration, uint64_t oldSchemaVersion) {
        if (oldSchemaVersion < newVersion) {
            ///数据迁移：
            NSLog(@"数据迁移");
            [migration enumerateObjects:MigrateModel.className block:^(RLMObject * _Nullable oldObject, RLMObject * _Nullable newObject) {
                newObject[@"fullName"] = [NSString stringWithFormat:@"%@%@",oldObject[@"name"],oldObject[@"age"]];
            }];
        }
    };
    ///配置生效
    [RLMRealmConfiguration setDefaultConfiguration:config];
    ///立即迁移
    [RLMRealm defaultRealm];
    

}

- (void)testDataMigration {
    
    MigrateModel *model = MigrateModel.new;
    model.name = @"mazi";
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm transactionWithBlock:^{
        [realm addObject:model];
    }];
    
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [self.token invalidate];
    [super tearDown];
}

- (void)testToken {
    
    NoticeModel *model = [[NoticeModel alloc] initWithValue:@{@"a":@2}];
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm transactionWithBlock:^{
        [realm addObject:model];
    }];
}

- (void)testResultsNotice {
    
//    RLMSyncUser
//    RLMSyncUser *user = [RLMSyncUser logInWithCredentials:<#(nonnull RLMSyncCredentials *)#> authServerURL:<#(nonnull NSURL *)#> onCompletion:<#^(RLMSyncUser * _Nullable, NSError * _Nullable)completion#>]

}

- (void)testSaveItem {
    /*
     @property NSInteger number;
     @property NSInteger age;
     @property NSString *name;
     */
//    Student *s = [[Student alloc] initWithValue:@{@"number":@13,@"age":@24,@"name":@"LiuHanyu"}];
    RLMRealm *realm = [RLMRealm defaultRealm];
//    [realm beginWriteTransaction];
//    [realm addObject:s];
//    [realm commitWriteTransaction];
    
//    [realm transactionWithBlock:^{
//        [realm addObject:s];
//    }];
    
    [realm transactionWithBlock:^{
        //Thread 1: Exception: "Attempting to create an object of type 'Student' with an existing primary key value '1'."
//        [Student createInRealm:realm withValue:@{@"number":@1,@"age":@29,@"name":@"anger"}];
        [Student createOrUpdateInRealm:realm withValue:@{@"number":@4,@"age":@21,@"name":@"zhangsan"}];
    }];
    
    
}

- (void)testSaved {
    
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm transactionWithBlock:^{
        //Thread 1: Exception: "Attempting to create an object of type 'Student' with an existing primary key value '1'."
//        [Student createInRealm:realm withValue:@{@"number":@1,@"age":@29,@"name":@"anger"}];
        [Data createInRealm:realm withValue:@{@"isHint":@(YES),@"viewModelUrl":@"www.baidu.com",@"isMore":@(NO),@"total":@12,@"moreUrl":@"www.yyy.com",@"url":@"www.yyy.com"}];
    }];
}

- (void)testSearchItem {
    
    RLMResults *results = [Student objectsWhere:@"age > 20 && number<2"];
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm transactionWithBlock:^{
        [realm addOrUpdateObject:results.lastObject];
    }];
}

- (void)testGetRealmDefaultPath {
    RLMResults <Student*> *results = [Student objectsWhere:@"name='zhangsan'"];
    ///获取最新数据
    Student *s = [results firstObject];
    NSLog(@"%@",s);
    NSLog(@"%@",[RLMRealmConfiguration defaultConfiguration].fileURL);
}

- (void)testDelateItem {
    
    RLMResults <Student*> *results = [Student allObjects];
    ///获取最新数据
    Student *s = [results lastObject];
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm transactionWithBlock:^{
        [realm deleteObject:s];
    }];
}

- (void)testToMany {
    
    Person *p = [[Person alloc] init];
    p.num = 1;
    p.name = @"zhangsan";
    
    Dog *pet1 = [[Dog alloc] init];
    pet1.num = 1;
    pet1.name = @"huzi";
    
    Dog *pet2 = [[Dog alloc] init];
    pet2.num = 2;
    pet2.name = @"heizi";
    
    ///内部自动初始化pets,懒加载
    [p.pets addObject:pet1];
    [p.pets addObject:pet2];
    
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm transactionWithBlock:^{
        [realm addObject:p];
    }];
}

- (void)testMany {
    
    Person *p = [Person allObjects].firstObject;
    NSLog(@"%p",p);//0x600001624bd0
    Person *pp = (Person*)p.pets.firstObject.master;
    NSLog(@"%p",pp);//0x7fba8d50fee0
    NSLog(@"%@",pp);
    /*
     [0] Person {
             num = 1;
             name = zhangsan;
             pets = RLMArray<Dog> <0x600001525400> (
                 [0] Dog {
                     num = 1;
                     name = huzi;
                 },
                 [1] Dog {
                     num = 2;
                     name = heizi;
                 }
             );
         }
     */
}

- (void)testExample {
    
}

- (void)testNilValue {
    
    ///默认情况下，属性可以为空
    Student *s = [Student new];
    s.name = @"ljr";
    s.age = 1;
    s.number = 1;
    /*
     + (NSArray<NSString *> *)requiredProperties {
         
         return @[@"name"];
     }
     */
    /*
     Thread 1: Exception: "Migration is required due to the following errors:\n- Property 'Student.name' has been made required."
     */
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm transactionWithBlock:^{
        [realm addObject:s];
    }];
}

- (void)testReadIgnoreProperty {
    
    Student *s = [Student allObjects].lastObject;
    NSLog(@"s.ageDesc=%@",s.ageDesc);
}

- (void)testChangeConfiguration {
    
    [self setDefaultRealmForUser:@"zhangsan"];
    RLMRealm *realm = [RLMRealm defaultRealm];
    NSLog(@"%@",[RLMRealmConfiguration defaultConfiguration].fileURL);

}

- (void)testmigrate {
    
    
}

- (void)setDefaultRealmForUser:(NSString *)userName {
    
    RLMRealmConfiguration *config = [RLMRealmConfiguration defaultConfiguration];
    config.fileURL = [[[config.fileURL URLByDeletingLastPathComponent] URLByAppendingPathComponent:userName] URLByAppendingPathExtension:@"realm"];
    [RLMRealmConfiguration setDefaultConfiguration:config];
    
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}


@end
