import 'dart:convert';
import 'package:http/http.dart';
import 'price_screen.dart';
const apikey='5757D8BC-C533-4E14-8DB0-178EF3AA4178';



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


  Future getonlinedata(String currency,String top) async {
    String url='https://rest.coinapi.io/v1/exchangerate/$top/$currency?apikey=$apikey';
    Response response = await get(Uri.parse(url));
    if (response.statusCode == 200) {
      String data = response.body;
      var ratedata = jsonDecode(data)['rate'];
      return ratedata;
    } else {
      print(response.statusCode);
    }
  }



  }
