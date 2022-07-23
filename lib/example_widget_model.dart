import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'book.dart';
import 'customer.dart';

class ExampleWidgetModel {
  Future<Box<Customer>>? customersBox;
  Future<Box<Book>>? booksBox;
  
  void setup() {
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(CustomerAdapter());
    }
    customersBox = Hive.openBox<Customer>('customersBox');
    customersBox?.then(
          (box) => box.listenable().addListener(() {
            print(box.length);
          })
    );

    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(BookAdapter());
    }
    booksBox = Hive.openBox<Book>('booksBox');
  }

  void add() async {
    final box_c = await customersBox;
    final box_b = await booksBox;
    
    final book = Book('Mirror', 305, 'Konan Doil');
    await box_b?.add(book);
    final books = HiveList(box_b!, objects: [book]);

    final customer = Customer('Greh', 25, 41025, 290, 'Online', books);
    await box_c?.add(customer);
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

