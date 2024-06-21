import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:moneymanagement/db/category/category_db.dart';
import 'package:moneymanagement/models/category/category_model.dart';

ValueNotifier<CategroryType> selectedCategoryType =
    ValueNotifier(CategroryType.income);
Future<void> showCategoryAddPopup(BuildContext context) async {
  final _nameEditController = TextEditingController();
  showDialog(
      context: context,
      builder: (ctx) {
        return SimpleDialog(
          title: Text('Add '),
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _nameEditController,
                decoration: InputDecoration(
                    hintText: 'Category Name',
                    labelText: 'catgeory name',
                    border: OutlineInputBorder()),
              ),
            ),
            Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    RadioButton(title: 'INCOME', type: CategroryType.income),
                    RadioButton(
                      title: 'EXPENSES',
                      type: CategroryType.expanse,
                    )
                  ],
                )),
            ElevatedButton(
              onPressed: () {
                final name = _nameEditController.text;
                if (name.isEmpty) {
                  return;
                } else {
                  final type = selectedCategoryType.value;

                  final _category = CategoryModel(
                      id: DateTime.now().millisecondsSinceEpoch.toString(),
                      name: name,
                      type: type);

                  CategoryDB.instance.insertCategory(_category);
                  Navigator.of(ctx).pop();
                }
              },
              child: Text('Add'),
            )
          ],
        );
      });
}

class RadioButton extends StatelessWidget {
  final String title;
  final CategroryType type;
  // final CategroryType selectedType;
  RadioButton({
    Key? key,
    required this.title,
    required this.type,
  }) : super(key: key);

  CategroryType? _type;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ValueListenableBuilder(
          valueListenable: selectedCategoryType,
          builder: (BuildContext ctx, CategroryType newCategory, Widget? _) {
            return Radio<CategroryType>(
                value: type,
                groupValue: newCategory,
                onChanged: (value) {
                  if (value == null) {
                    return;
                  }
                  selectedCategoryType.value = value;
                  selectedCategoryType.notifyListeners();
                  // setState(() {
                  //   _type = value;
                  // });
                });
          },
        ),
        Text(title),
      ],
    );
  }
}
