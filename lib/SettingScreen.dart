import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import './countriesList.dart';

class SettingScreen extends StatefulWidget {
  final String country;
  SettingScreen(this.country);

  @override
  _SettingScreenState createState() => new _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  String selectedCountry;

  @override
  void initState() {
    super.initState();
    setState(() {
      selectedCountry = _getCountryName(widget.country);
    });
  }

  _getCountryID(selectedCountry) {
    var _list = countriesList.toList();
    for (var country in _list) {
      if (selectedCountry == country["name"]) {
        return country["id"];
      }
    }
  }

  _getCountryName(selectedCountry) {
    var _list = countriesList.toList();
    for (var country in _list) {
      if (selectedCountry == country["id"]) {
        return country["name"];
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.deepOrange[800],
          title: Text("Settings",
              style: TextStyle(color: Colors.white, fontSize: 24)),
          elevation: 0.0,
          leading: IconButton(
            icon: FaIcon(
              FontAwesomeIcons.chevronLeft,
              size: 20,
              color: Colors.white,
            ),
            onPressed: () =>
                Navigator.pop(context, _getCountryID(selectedCountry)),
          )),
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      body: Center(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Country:   ",
              style: TextStyle(color: Colors.black, fontSize: 16)),
          DropdownButton<String>(
            value: selectedCountry,
            elevation: 0,
            onChanged: (String newValue) {
              setState(() {
                selectedCountry = newValue;
              });
            },
            items: countriesList.map<DropdownMenuItem<String>>((country) {
              return DropdownMenuItem<String>(
                value: country["name"],
                child: Text(country["name"]),
              );
            }).toList(),
          )
        ],
      )),
    );
  }
}
