import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

class ExampleWidgetModel {
  ExampleWidgetModel() {
    Hive.initFlutter();
  }

  void doSome() async {
    // var box = await Hive.openBox('database');
    //
    // box.put('name', 'Ilon');
    // box.put('age', 35);
    // box.put('balance', 100000);
    // box.put('business', ['Tesla', 'SpaceX', 'PayPal']);
    //
    // final name = box.get('name') as String?;
    // final age = box.get('age') as int?;
    // final balance = box.get('balance') as int?;
    // final business = box.get('business') as List<String>?;
    //
    // print('name: $name');
    // print('name: $age');
    // print('name: $balance');
    // print('business: $business');
    //
    // box.close();

    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(CustomerAdapter());
    }

    var box = await Hive.openBox<Customer>('Customer_box');
    final customer = Customer('Mark', 20, 30000, 23, 'Online');
    await box.add(customer);
    final customerFromBox = box.getAt(0);

    print(customerFromBox);
  }
}

class Customer {
  String name;
  int age;
  int balance;
  int books_count;
  String status;

  Customer(
      this.name,
      this.age,
      this.balance,
      this.books_count,
      this.status
      );

  @override
  String toString() {
    return 'Customer{name: $name, age: $age, balance: $balance, books_count: $books_count, status: $status}';
  }
}

class CustomerAdapter extends TypeAdapter<Customer>{
  @override
  final typeId = 0;

  @override
  Customer read(BinaryReader reader) {
    final name = reader.readString();
    final age = reader.readInt();
    final balance = reader.readInt();
    final books_count = reader.readInt();
    final status = reader.readString();
    return Customer(name, age, balance, books_count, status);
  }

  @override
  void write(BinaryWriter writer, Customer obj) {
    writer.writeString(obj.name);
    writer.writeInt(obj.age);
    writer.writeInt(obj.balance);
    writer.writeInt(obj.books_count);
    writer.writeString(obj.status);
  }
}