import 'package:coindesk/services/http_services.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  _HomePageState();

  HTTPServices? _http;
  String coin = 'bitcoin';

  @override
  void initState() {
    super.initState();
    _http = GetIt.instance.get<HTTPServices>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
        toolbarHeight: 100,
        title: const Text(
          'CoinDesk',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
              child: Center(
                child: _renderCoinDropdown(),
              ),
            )
          ],
        ),
      ),
    );
  }

  // Render coin dropdown list
  Widget _renderCoinDropdown() {
    List<String> _coinList = [
      'bitcoin',
      'ethereum',
      'bnb',
      'solana',
      'tether',
      'toncoin'
    ];
    List<DropdownMenuItem<String>> _items = _coinList
        .map((coin) => DropdownMenuItem(
              value: coin,
              child: Text(
                coin,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ))
        .toList();
    return DropdownButton(
      items: _items,
      value: coin,
      underline: Container(),
      icon: const Icon(
        Icons.arrow_drop_down_sharp,
        color: Colors.white,
        size: 20,
      ),
      dropdownColor: Colors.deepPurpleAccent,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      onChanged: (value) {
        coin = value!;
        setState(() {});
      },
    );
  }

  //
}
