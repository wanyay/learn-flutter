import 'package:bitcoin_ticker/coin_data.dart';
import 'package:bitcoin_ticker/crypto_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String _selectedCurrency = "USD";

  Map<String, String> values = {};

  bool isWaiting = false;

  DropdownButton androidDropdown() {
    List<DropdownMenuItem<String>> dropdownItems = [];

    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropdownItems.add(newItem);
    }

    return DropdownButton(
      onChanged: (value) {
        setState(() {
          _selectedCurrency = value;
          getBTCData();
        });
      },
      value: _selectedCurrency,
      items: dropdownItems,
    );
  }

  CupertinoPicker iosPicker() {
    List<Text> pickerItems = [];

    for (String currency in currenciesList) {
      pickerItems.add(Text(currency));
    }

    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        print(selectedIndex);
      },
      children: pickerItems,
    );
  }

  @override
  initState() {
    super.initState();
    getBTCData();
    print("initState started.");
  }

  void getBTCData() async {
    isWaiting = true;
    try {
      var data = await CoinData().getCoinData(_selectedCurrency);
      print(data);

      isWaiting = false;

      setState(() {
        values = data;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          getCard(),
          Container(
            alignment: Alignment.center,
            child: loading(),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isAndroid ? androidDropdown() : iosPicker(),
          ),
        ],
      ),
    );
  }

  Widget loading() {
    if (isWaiting) {
      return Loading(
          indicator: BallPulseIndicator(), size: 100.0, color: Colors.pink);
    } else {
      return Container();
    }
  }

  Column getCard() {
    List<CryptoCard> cryptoCardList = [];

    for (String crypto in cryptoList) {
      cryptoCardList.add(
        CryptoCard(
            cryptoType: crypto,
            amount: isWaiting ? "?" : values[crypto],
            currency: _selectedCurrency),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: cryptoCardList,
    );
  }
}
