import 'package:hive/hive.dart';
import 'package:hive_basics/book.dart';
import 'package:hive_flutter/adapters.dart';

import 'customer.dart';

class ExampleWidgetModel {

  void doSome() async {
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(CustomerAdapter());
    }
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(BookAdapter());
    }

    // Hive.deleteBoxFromDisk('Customer_box');
    // Hive.deleteBoxFromDisk('books_box');

    var box = await Hive.openBox<Customer>('Customer_box');
    var booksBox = await Hive.openBox<Book>('books_box');

    final book = Book('Stive Jobs', 500, 'Uolter Aizekson');
    await booksBox.add(book);
    final books = HiveList(booksBox, objects: [book]);
    var customer = Customer('Mark', 20, 30000, 23, 'Online', books);
    await box.add(customer);

    final customerFromBox = box.getAt(0);
    customerFromBox?.status = 'Offline';
    await customerFromBox?.save();

    print(box.values);
    print(customerFromBox);
  }
}

