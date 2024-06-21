import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:moneymanagement/db/category/category_db.dart';
import 'package:moneymanagement/db/transaction/transaction_db.dart';
import 'package:moneymanagement/models/category/category_model.dart';
import 'package:moneymanagement/models/transaction/transaction_model.dart';
import 'package:moneymanagement/screens/category/category_add_popup.dart';
import 'package:moneymanagement/screens/transactions/screen_transaction.dart';

class ScreenAddTransaction extends StatefulWidget {
  static const routeName = 'add-transaction';
  const ScreenAddTransaction({super.key});

  @override
  State<ScreenAddTransaction> createState() => _ScreenAddTransactionState();
}

class _ScreenAddTransactionState extends State<ScreenAddTransaction> {
  DateTime? _selecteddate;
  CategroryType? _selectedtype;
  CategoryModel? _selectedcategorymodel;
  String? _categoryid;
  final _purposeTextEditingController = TextEditingController();
  final _amountTextEditingController = TextEditingController();
  /**
   * purpose
   * Date
   * amount
   * Icome or expanse
   * category type
   */
  @override
  void initState() {
    // TODO: implement initState
    _selectedtype = CategroryType.income;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _purposeTextEditingController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: 'Purpose'),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: _amountTextEditingController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Amount',
              ),
            ),
            TextButton.icon(
              onPressed: () async {
                final _selectedatetemp = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now().subtract(Duration(days: 30)),
                  lastDate: DateTime.now(),
                );
                if (_selectedatetemp == null) {
                  return;
                } else {
                  print(_selectedatetemp);
                  setState(() {
                    _selecteddate = _selectedatetemp;
                  });
                }
              },
              icon: Icon(Icons.calendar_today),
              label: Text(_selecteddate == null
                  ? 'Select date'
                  : _selecteddate!.toString()),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Radio(
                    value: CategroryType.income,
                    groupValue: _selectedtype,
                    onChanged: (newvalue) {
                      setState(() {
                        _selectedtype = CategroryType.income;
                        _categoryid = null;
                      });
                    }),
                Text('Income'),
                Row(
                  children: [
                    Row(
                      children: [
                        Radio(
                            value: CategroryType.expanse,
                            groupValue: _selectedtype,
                            onChanged: (newvalue) {
                              setState(() {
                                _selectedtype = CategroryType.expanse;
                                _categoryid = null;
                              });
                            }),
                        Text('Expense'),
                      ],
                    ),
                  ],
                )
              ],
            ),
            DropdownButton<String>(
              hint: Text('Seleceted Category'),
              value: _categoryid,
              items: (_selectedtype == CategroryType.income
                      ? CategoryDB().IncomeCategoryList
                      : CategoryDB().ExpenseCategoryList)
                  .value
                  .map((val) {
                return DropdownMenuItem(
                  value: val.id,
                  child: Text(val.name),
                  onTap: () {
                    print(val.toString());
                    _selectedcategorymodel = val;
                  },
                );
              }).toList(),
              onChanged: (selectedvalue) {
                print('selectedvalues');
                setState(() {
                  _categoryid = selectedvalue;
                });
              },
              onTap: () {},
            ),
            ElevatedButton(
              onPressed: () {
                addTransaction();
              },
              child: Text('Submit'),
            )
          ],
        ),
      )),
    );
  }

  Future<void> addTransaction() async {
    final _purposeText = _purposeTextEditingController.text;
    final _amountText = _amountTextEditingController.text;
    if (_purposeText.isEmpty) {
      return;
    }
    if (_amountText.isEmpty) {
      return;
    }
    if (_categoryid == null) {
      return;
    }
    if (_selecteddate == null) {
      return;
    }
    final _parsedamount = double.tryParse(_amountText);
    if (_parsedamount == null) {
      return;
    }
    if (_selectedcategorymodel == null) {
      return;
    }
    //_selecteddate
    // _selectedtype
    //adding value tooo
    final _model = TransactionModel(
        purpose: _purposeText,
        amount: _parsedamount,
        date: _selecteddate!,
        type: _selectedtype!,
        category: _selectedcategorymodel!);
    await TransactionDB.instance.addTransaction(_model);
    Navigator.of(context).pop();
    TransactionDB.instance.refresh();
  }
}
