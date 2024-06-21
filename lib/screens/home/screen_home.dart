import 'package:flutter/material.dart';
import 'package:moneymanagement/db/category/category_db.dart';
import 'package:moneymanagement/models/category/category_model.dart';
import 'package:moneymanagement/screens/add_transaction/screen_add_transaction.dart';
import 'package:moneymanagement/screens/category/category_add_popup.dart';
import 'package:moneymanagement/screens/category/screen_category.dart';
import 'package:moneymanagement/screens/home/widgets/bottom_navigation.dart';
import 'package:moneymanagement/screens/transactions/screen_transaction.dart';

class ScreenHome extends StatelessWidget {
  ScreenHome({super.key});
  static ValueNotifier<int> selectedIndexNotifier = ValueNotifier(0);
  final _pages = const [ScreenTransaction(), ScreenCategory()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 240, 234, 234),
      appBar: AppBar(
        title: Center(
            child: Text(
          'Cash keeper',
          style: TextStyle(fontFamily: AutofillHints.organizationName),
        )),
        backgroundColor: Color.fromARGB(255, 168, 136, 223),
      ),
      bottomNavigationBar: MoneyMangerBottomNavigation(),
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: selectedIndexNotifier,
          builder: (BuildContext context, int updatedIndex, Widget? child) {
            return _pages[updatedIndex];
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (selectedIndexNotifier.value == 0) {
            Navigator.of(context).pushNamed(ScreenAddTransaction.routeName);
            print("transaction");
          } else {
            print("category");
            // final _sample = CategoryModel(
            //     id: DateTime.now().millisecondsSinceEpoch.toString(),
            //     name: 'travel',
            //     type: CategroryType.expanse);
            // CategoryDB().insertCategory(_sample);
            showCategoryAddPopup(context);
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
