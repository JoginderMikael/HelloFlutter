import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
  home: QuotesList(),
));

class QuotesList extends StatefulWidget {
  const QuotesList({super.key});


  @override
  State<QuotesList> createState() => _QuotesListState();
}

class _QuotesListState extends State<QuotesList> {
  
  List<String> quotes = [
  'I am Old testament',
  'Knowledge is Power!',
  'Big fucks Small'
];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text(
          "Awesome Quotes",
          style: TextStyle(color: Colors.white),
          ),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
      ),
      body:Column(
        children: quotes.map((quote) => Text(quote)).toList(),
      )
    );
  }
}