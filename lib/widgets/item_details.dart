import 'package:flutter/material.dart';

class ItemDetails extends StatelessWidget {
  // final String title;
  // final double amount;
  // final DateTime date;

  // ItemDetails(this.title, this.amount, this.date);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments;
    // final title = args!.title;
    // final amount = args['amount'];
    // final date = args['date'];

    return Scaffold(
      appBar: AppBar(
        title: Text('title'),
      ),
      body: Center(
        child: Column(
          children: [
            Text('title'),
            Text('amount'),
            Text('date'),
          ],
        ),
      ),
    );
  }
}
