import 'package:http/http.dart' as Http;
import 'dart:convert';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {
  String url = "https://rest.coinapi.io/v1/exchangerate";
  String apiKey = "B5A3F00B-4D72-491E-A935-5942FCF84AAF";

  Future<dynamic> getCoinData(String currencyType) async {
    Map<String, String> cryptoPrices = {};

    for (String crypto in cryptoList) {
      String requestURL = '$url/$crypto/$currencyType?apikey=$apiKey';
      Http.Response response = await Http.get(requestURL);
      print(response.body);

      if (response.statusCode == 200) {
        var coinData = jsonDecode(response.body);
        var price = coinData["rate"];
        cryptoPrices[crypto] = price.toStringAsFixed(0);
      }
    }

    return cryptoPrices;
  }
}
