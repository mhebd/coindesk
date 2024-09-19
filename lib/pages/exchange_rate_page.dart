import 'package:flutter/material.dart';

class ExchangeRatePage extends StatelessWidget {
  final Map rates;
  final String icon;
  ExchangeRatePage({super.key, required this.rates, required this.icon});
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
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new_outlined,
              color: Colors.white60),
        ),
        actions: [
          Container(
            width: 40,
            height: 40,
            margin: const EdgeInsets.only(right: 20),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(icon),
              ),
            ),
          ),
        ],
        title: const Text(
          'Exchange Rates',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: rates.length,
        itemBuilder: (BuildContext _context, index) {
          String currencyType = rates.keys.elementAt(index);
          double currencyValue = rates[currencyType]!;

          return ListTile(
            onTap: () {},
            tileColor:
                (index + 1) % 2 == 0 ? const Color.fromRGBO(0, 0, 0, .1) : null,
            title: Text(
              currencyType.toUpperCase(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            trailing: Text(
              currencyValue.toString(),
              style: const TextStyle(
                color: Colors.white70,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          );
        },
      ),
    );
  }
}
