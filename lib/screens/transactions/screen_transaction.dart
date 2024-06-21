import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:moneymanagement/db/category/category_db.dart';
import 'package:moneymanagement/db/transaction/transaction_db.dart';
import 'package:moneymanagement/models/category/category_model.dart';
import 'package:moneymanagement/models/transaction/transaction_model.dart';

class ScreenTransaction extends StatelessWidget {
  const ScreenTransaction({super.key});

  @override
  Widget build(BuildContext context) {
    TransactionDB.instance.refresh();
    CategoryDB.instance.refreshUI();
    return ValueListenableBuilder(
        valueListenable: TransactionDB.instance.TransactionlistNotifier,
        builder: (BuildContext ctx, List<TransactionModel> newlist, Widget? _) {
          return ListView.separated(
              padding: EdgeInsets.all(39),
              itemBuilder: (ctx, index) {
                final value = newlist[index];
                return Slidable(
                  key: Key(value.id!),
                  startActionPane:
                      ActionPane(motion: ScrollMotion(), children: [
                    SlidableAction(
                      onPressed: (ctx) {
                        TransactionDB.instance.deleteTransaction(value.id!);
                      },
                      icon: Icons.delete,
                      label: 'Delete',
                      backgroundColor: Color.fromARGB(255, 209, 133, 126),
                    )
                  ]),
                  child: Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 80,
                        child: Text(
                          parseDate(value.date),
                          textAlign: TextAlign.center,
                        ),
                        backgroundColor: value.type == CategroryType.income
                            ? const Color.fromARGB(255, 103, 159, 105)
                            : const Color.fromARGB(255, 197, 100, 93),
                      ),
                      title: Text("Rs${value.amount}"),
                      subtitle: Text('${value.category.name}'),
                    ),
                  ),
                );
              },
              separatorBuilder: (ctx, index) {
                return const SizedBox(
                  height: 10,
                );
              },
              itemCount: newlist.length);
        });
  }

  String parseDate(DateTime date) {
    final _data = DateFormat.MMMd().format(date);
    final _splitData = _data.split(' ');
    return '${_splitData.last}\n${_splitData.first}';
    //return '${date.day}\n${date.month}';
  }
}
