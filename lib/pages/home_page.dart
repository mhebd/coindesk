import 'dart:convert';

import 'package:coindesk/pages/exchange_rate_page.dart';
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
  double? height, width;

  @override
  void initState() {
    super.initState();
    _http = GetIt.instance.get<HTTPServices>();
  }

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
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 25),
              child: SizedBox(
                width: width! * .5,
                child: _renderCoinDropdown(),
              ),
            ),
            _renderCoinInfo()
          ],
        ),
      ),
    );
  }

  // Render coin dropdown list
  Widget _renderCoinDropdown() {
    List<Map<String, String>> _coinList = [
      {"id": "bitcoin", "name": "Bitcoin"},
      {"id": "ethereum", "name": "Ethereum"},
      {"id": "binancecoin", "name": "BNB"},
      {"id": "solana", "name": "Solana"},
      {"id": "the-open-network", "name": "TonCoin"},
      {"id": "tether", "name": "TeTher"},
    ];
    List<DropdownMenuItem<String>> _items = _coinList
        .map((coin) => DropdownMenuItem(
              value: coin['id'],
              child: Text(
                coin['name']!,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ))
        .toList();
    return DropdownButton(
      items: _items,
      value: coin,
      underline: Container(),
      isExpanded: true,
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

  // Render coin info
  Widget _renderCoinInfo() {
    return FutureBuilder(
      future: _http!.get('/coins/$coin'),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          Map data = jsonDecode(snapshot.data.toString());
          num price = data['market_data']['current_price']['usd'];
          Map exchangeRates = data['market_data']['current_price'];
          double last24hchanges =
              data['market_data']['price_change_percentage_24h'];
          String image = data['image']['large'];

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: GestureDetector(
                    onDoubleTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext _context) {
                            return ExchangeRatePage(
                              rates: exchangeRates,
                              icon: image,
                            );
                          },
                        ),
                      );
                    },
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(image),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  '\$${price.toStringAsFixed(2)} USD',
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  '$last24hchanges %',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                Container(
                  height: height! * .5,
                  color: Colors.deepPurple,
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.only(top: 20),
                  child: SingleChildScrollView(
                    child: Text(
                      data['description']['en'],
                      style: const TextStyle(color: Colors.white70),
                    ),
                  ),
                )
              ],
            ),
          );
        } else {
          return SizedBox(
            width: width,
            height: height! * .7,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
