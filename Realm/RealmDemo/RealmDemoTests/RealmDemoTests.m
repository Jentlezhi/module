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


@interface RealmDemoTests : XCTestCase

@end

@implementation RealmDemoTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
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
    s.ageStr = @"15";
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

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}


@end
