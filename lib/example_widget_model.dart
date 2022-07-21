import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

import 'customer.dart';

class ExampleWidgetModel {

  void doSome() async {
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

