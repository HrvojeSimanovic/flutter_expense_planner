import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';
// import './item_details.dart';

class TransactionItem extends StatefulWidget {
  const TransactionItem({
    Key? key,
    required this.transaction,
    required this.deleteTransactionHandler,
  }) : super(key: key);

  final Transaction transaction;
  final Function deleteTransactionHandler;

  @override
  _TransactionItemState createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  var _bgColor;

  @override
  void initState() {
    super.initState();
    final availableColors = [
      Colors.black,
      Colors.green,
      Colors.cyan,
      Colors.red,
    ];

    _bgColor = availableColors[Random().nextInt(4)];
  }

  void _itemDetailsHandler(BuildContext ctx) {
    Navigator.pushNamed(ctx, '/item-details', arguments: {
      'title': widget.transaction.title,
      'amount': widget.transaction.amount,
      'id': widget.transaction.id,
    });
    // Navigator.of(ctx).push(MaterialPageRoute(builder: (_) {
    //   return ItemDetails(
    //     '${widget.transaction.title}',
    //     widget.transaction.amount,
    //     widget.transaction.date,
    //   );
    // }));
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 5,
        vertical: 8,
      ),
      elevation: 5,
      child: ListTile(
        onTap: () => _itemDetailsHandler(context),
        leading: CircleAvatar(
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: FittedBox(
              child: Text(
                '\$${widget.transaction.amount}',
              ),
            ),
          ),
          radius: 30,
          backgroundColor: _bgColor,
        ),
        title: Text(
          '${widget.transaction.title}',
          style: Theme.of(context).textTheme.headline6,
        ),
        subtitle: Text(
          DateFormat.yMMMd().format(widget.transaction.date),
        ),
        trailing: MediaQuery.of(context).size.width > 460
            ? TextButton.icon(
                onPressed: () =>
                    widget.deleteTransactionHandler(widget.transaction.id),
                icon: Icon(Icons.delete),
                label: const Text('delete'),
              )
            : IconButton(
                onPressed: () =>
                    widget.deleteTransactionHandler(widget.transaction.id),
                icon: const Icon(Icons.delete),
                color: Theme.of(context).primaryColor,
              ),
      ),
    );
  }
}
