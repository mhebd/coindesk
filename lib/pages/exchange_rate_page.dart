import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ExchangeRatePage extends StatelessWidget {
  final Map rates;
  final String icon;
  late double _height;
  ExchangeRatePage({super.key, required this.rates, required this.icon});

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    List<MapEntry<dynamic, dynamic>> rateList = rates.entries.toList();

    if (rateList.isEmpty) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        centerTitle: true,
        toolbarHeight: _height * 0.1,
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
        itemCount: rateList.length,
        clipBehavior: Clip.none,
        itemBuilder: (context, index) {
          final rate = rateList[index];

          return ListTile(
            onTap: () {},
            tileColor:
                (index + 1) % 2 == 0 ? const Color.fromRGBO(0, 0, 0, .1) : null,
            title: Text(
              rate.key.toUpperCase(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            trailing: Text(
              rate.value.toString(),
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
