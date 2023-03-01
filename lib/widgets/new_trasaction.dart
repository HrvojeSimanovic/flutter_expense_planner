import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import './adaptive_outlined_button.dart';
import 'package:intl/intl.dart';
// import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addNewTransaction;

  NewTransaction(this.addNewTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleControler = TextEditingController();
  final _amountControler = TextEditingController();
  var _userPickedDate;

  void _addNewTransactionHandler() {
    final enterdTitle = _titleControler.text;
    final enterdAmount = double.parse(_amountControler.text);

    if (enterdTitle.isEmpty || enterdAmount <= 0 || _userPickedDate == null) {
      return;
    }
    widget.addNewTransaction(
      enterdTitle,
      enterdAmount,
      _userPickedDate,
    );

    Navigator.of(context).pop(); // closes top modal screen that is open //
  }

  void _datePickerHandler() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _userPickedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                controller: _titleControler,
                onSubmitted: (_) => _addNewTransactionHandler(),
                // textInputAction: TextInputAction.next,
                // onChanged: (value) {
                //   titleInput = value;
                // },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                controller: _amountControler,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _addNewTransactionHandler(),
                // onChanged: (value) {
                //   amountInput = value;
                // },
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 30, 0, 30),
                child: Row(children: [
                  Expanded(
                    child: Text(
                      _userPickedDate == null
                          ? 'No Date chosen!'
                          : 'Picked Date: ${DateFormat.yMd().format(_userPickedDate)}',
                      // : DateFormat.yMd().format(_userPickedDate),
                    ),
                  ),
                  AdaptiveOutlinedButton('Choose Date', _datePickerHandler),
                ]),
              ),
              ElevatedButton(
                onPressed: _addNewTransactionHandler,
                child: const Text('add Transaction'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
