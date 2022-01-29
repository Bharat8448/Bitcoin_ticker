import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'coin_data.dart';



class PriceScreen extends StatefulWidget {

  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedcurrency='USD';
  String bdata='?';
  String edata='?';
  String ldata='?';
  CoinData coinData=CoinData();

  void updateui() async{
    try {
      double bbdata = await coinData.getonlinedata(selectedcurrency,'BTC');
      double eedata = await coinData.getonlinedata(selectedcurrency,'ETH');
      double lldata = await coinData.getonlinedata(selectedcurrency,'LTC');
      setState(() {
        bdata = bbdata.toStringAsFixed(0);
        edata = eedata.toStringAsFixed(0);
        ldata = lldata.toStringAsFixed(0);
      });
    }catch(e){
      print(e);
    }
  }
  void initState() {
    super.initState();
    //14. Call getData() when the screen loads up. We can't call CoinData().getCoinData() directly here because we can't make initState() async.
   updateui();

  }


  DropdownButton<String> returndropdownbutton(){
    List<DropdownMenuItem<String>> dropdownmenuitems=[];
    for(String currency in currenciesList){
      var newitem=DropdownMenuItem(child: Text(currency),
          value: currency);
      dropdownmenuitems.add(newitem);
    }
   return DropdownButton<String>(
value: selectedcurrency,
items: dropdownmenuitems,
onChanged: (value){
setState(() {
selectedcurrency=value;
updateui();
});
},
);
  }
  CupertinoPicker getios(){
    List<Text> list=[];
    for(String currency in currenciesList){
      list.add(Text(currency));
    }
    return CupertinoPicker(
      itemExtent: 32,
      onSelectedItemChanged: (selectedindex){
        print(selectedindex);
      },
      children: list
    );
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
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 BTC= $bdata $selectedcurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 ETH= $edata $selectedcurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 LTC= $ldata $selectedcurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),

          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isAndroid ? returndropdownbutton():getios(),
          ),
        ],
      ),
    );
  }
}
