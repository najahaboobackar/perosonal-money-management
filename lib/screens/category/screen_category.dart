import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:moneymanagement/db/category/category_db.dart';
import 'package:moneymanagement/screens/category/expanse_category.dart';
import 'package:moneymanagement/screens/category/income_category.dart';

class ScreenCategory extends StatefulWidget {
  const ScreenCategory({super.key});

  @override
  State<ScreenCategory> createState() => _ScreenCategoryState();
}

class _ScreenCategoryState extends State<ScreenCategory>
    with SingleTickerProviderStateMixin {
  late TabController _tabcontroller;
  @override
  void initState() {
    // TODO: implement initState
    _tabcontroller = TabController(length: 2, vsync: this);
    CategoryDB.instance.refreshUI();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          controller: _tabcontroller,
          labelColor: Colors.deepPurple,
          unselectedLabelColor: Colors.grey,
          tabs: [
            Tab(
              text: 'INCOME',
            ),
            Tab(
              text: 'EXPENSES',
            ),
          ],
        ),
        Expanded(
          child: TabBarView(
              controller: _tabcontroller,
              children: [IncomeCategoryList(), ExpanseCategoryList()]),
        ),
      ],
    );
  }
}
