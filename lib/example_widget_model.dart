import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:hive_basics/book.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'customer.dart';

class ExampleWidgetModel {

  void doSome() async {
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(CustomerAdapter());
    }
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(BookAdapter());
    }

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

    await box.compact();
    await box.close();
  }

  void secureStorage() async {
    const secureStorage = FlutterSecureStorage();

    final existKey = await secureStorage.read(key: 'key');
    if(existKey == null) {
      final key = Hive.generateSecureKey();
      await secureStorage.write(key: 'key', value: base64UrlEncode(key));
    }
    final key = await secureStorage.read(key: 'key');
    final encryptionKey = base64Url.decode(key!);
    
    final box = await Hive.openBox('box', encryptionCipher: HiveAesCipher(encryptionKey));
    await box.put('universe', 616);
    print(box.get('universe'));
  }
}

