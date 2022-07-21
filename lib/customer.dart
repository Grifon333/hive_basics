import 'package:hive/hive.dart';

import 'book.dart';

part 'customer.g.dart';

@HiveType(typeId: 0)
class Customer extends HiveObject {
  @HiveField(0)
  String name;
  @HiveField(1)
  int age;
  @HiveField(2)
  int balance;
  @HiveField(3)
  int books_count;
  @HiveField(4)
  String status;
  @HiveField(5)
  HiveList<Book> books;

  Customer(
      this.name,
      this.age,
      this.balance,
      this.books_count,
      this.status,
      this.books
      );

  @override
  String toString() {
    return 'Customer{name: $name, age: $age, balance: $balance, books_count: $books_count, status: $status}';
  }
}