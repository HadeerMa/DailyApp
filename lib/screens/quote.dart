import 'package:flutter/material.dart';

class DailyQuotesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daily Quotes'),
      ),
      body: ListView(
        children: [
          _buildQuoteCard('“Believe you can and you\'re halfway there.” - Theodore Roosevelt'),
          _buildQuoteCard('“The only way to do great work is to love what you do.” - Steve Jobs'),
          _buildQuoteCard('“Act as if what you do makes a difference. It does.” - William James'),
          _buildQuoteCard('“The future belongs to those who believe in the beauty of their dreams.” - Eleanor Roosevelt'),
          _buildQuoteCard('“Don’t watch the clock; do what it does. Keep going.” - Sam Levenson'),
          _buildQuoteCard('“It does not matter how slowly you go as long as you do not stop.” - Confucius'),
          _buildQuoteCard('“Hardships often prepare ordinary people for an extraordinary destiny.” - C.S. Lewis'),
          _buildQuoteCard('“The only limit to our realization of tomorrow is our doubts of today.” - Franklin D. Roosevelt'),
          _buildQuoteCard('“Success is not final, failure is not fatal: It is the courage to continue that counts.” - Winston Churchill'),
          _buildQuoteCard('“You miss 100% of the shots you don’t take.” - Wayne Gretzky'),
        ],
      ),
    );
  }

  Widget _buildQuoteCard(String quote) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          quote,
          style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
        ),
      ),
    );
  }
}
