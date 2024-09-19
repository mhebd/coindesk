import 'package:flutter/material.dart';

class ExchangeRatePage extends StatelessWidget {
  final Map rates;
  ExchangeRatePage({super.key, required this.rates});
  double? height, width;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        centerTitle: true,
        toolbarHeight: height! * 0.1,
        title: const Text(
          'CoinDesk',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      ),
      body: Container(
        child: ListView.builder(
          itemCount: 3,
          itemBuilder: (BuildContext _context, index) {
            return const ListTile(
              title: Text('AED'),
            );
          },
        ),
      ),
    );
  }
}
