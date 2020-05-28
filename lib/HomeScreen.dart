import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import './categoriesList.dart';
import './quotesList.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var data;
  var formatter = new DateFormat('yyyy-MM-dd');
  String selectedCountry = 'at';
  int _selectedCategory = 0;

  @override
  void initState() {
    super.initState();
    _getNewsData('general', selectedCountry);
  }

  _setCategory(index) {
    _selectedCategory = index;
    _getNewsData(categoriesList[index]["id"], selectedCountry);
  }

  _formatDate(input) {
    var date = DateTime.parse(input);
    return DateFormat('dd.MM.yyyy').format(date);
  }

  void _getNewsData(String category, String country) async {
    var response = await http.get(
        Uri.encodeFull('https://newsapi.org/v2/top-headlines?country=' +
            country +
            '&category=' +
            category),
        headers: {
          "Accept": "application/json",
          "X-Api-Key": "insert key"
        });

    var localData = jsonDecode(response.body);

    this.setState(() {
      data = localData;
    });
  }

  void _awaitReturnValueFromSettingScreen(BuildContext context) async {
    final result = await Navigator.pushNamed(context, '/settings',
        arguments: selectedCountry);

    setState(() {
      selectedCountry = result;
    });

    this._getNewsData('general', selectedCountry);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.white,
            title: Text(
              "D i s c o v e r y",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                color: Colors.deepOrange[800],
              ),
            ),
            elevation: 0.0,
            actions: <Widget>[
              // action button
              IconButton(
                icon: FaIcon(
                  FontAwesomeIcons.globe,
                  size: 24,
                  color: Colors.deepOrange[800],
                ),
                onPressed: () {
                  _awaitReturnValueFromSettingScreen(context);
                },
              ),
            ]),
        resizeToAvoidBottomPadding: false,
        backgroundColor: Colors.white,
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                  height: 100.0,
                  child: Padding(
                      padding: EdgeInsets.only(
                          left: 16.0, right: 16.0, bottom: 16.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                                child: Container(
                                    margin: const EdgeInsets.only(top: 10.0),
                                    child: ListView.separated(
                                      shrinkWrap: true,
                                      itemCount: categoriesList.length,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Column(children: <Widget>[
                                          new IconButton(
                                            icon: categoriesList[index]["icon"],
                                            color: _selectedCategory != null &&
                                                    _selectedCategory == index
                                                ? Colors.deepOrange[800]
                                                : Colors.black,
                                            onPressed: () {
                                              _setCategory(index);
                                            },
                                          ),
                                          Text(categoriesList[index]["name"],
                                              style: TextStyle(
                                                  color: _selectedCategory !=
                                                              null &&
                                                          _selectedCategory ==
                                                              index
                                                      ? Colors.deepOrange[800]
                                                      : Colors.black)),
                                        ]);
                                      },
                                      separatorBuilder:
                                          (BuildContext context, int index) {
                                        return SizedBox(
                                          width: 15,
                                        );
                                      },
                                    )))
                          ]))),
              Expanded(child: LayoutBuilder(
                builder: (context, constraints) {
                  if (constraints.maxWidth > 700) {
                    return _webContainer();
                  } else {
                    return _newsListing();
                  }
                },
              ))
            ]));
  }

  Widget _webContainer() {
    return Row(children: [
      Expanded(flex: 6, child: _newsListing()),
      Expanded(
          flex: 3,
          child: Container(
              color: Colors.grey[200],
              margin: EdgeInsets.only(left: 30.0, right: 30.0, bottom: 30.0),
              child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Column(children: [
                    Text(
                      "Zitate der Woche",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                      ),
                    ),
                    SizedBox(height: 30),
                    ListView.separated(
                      shrinkWrap: true,
                      itemCount: quotesList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(children: <Widget>[
                          new Text('"' + quotesList[index]["description"] + '"',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontStyle: FontStyle.italic, fontSize: 17)),
                          new Text(quotesList[index]["person"],
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 12)),
                        ]);
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(
                          height: 35,
                        );
                      },
                    )
                  ]))))
    ]);
  }

  Widget _newsListing() {
    return Container(
        child: data == null
            ? const Center(child: const CircularProgressIndicator())
            : data["articles"].length != 0
                ? ListView.builder(
                    itemCount: data == null ? 0 : data["articles"].length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0.0),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: GestureDetector(
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                      flex: 7,
                                      child: Container(
                                        margin:
                                            const EdgeInsets.only(right: 5.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              data["articles"][index]["source"]
                                                  ["name"],
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey[500],
                                              ),
                                            ),
                                            Text(
                                              data["articles"][index]["title"],
                                              style: TextStyle(
                                                fontSize: 15,
                                              ),
                                            ),
                                            Text(
                                              _formatDate(
                                                data["articles"][index]
                                                    ["publishedAt"],
                                              ),
                                              style: TextStyle(
                                                  color: Colors.grey[500],
                                                  fontSize: 12),
                                            ),
                                          ],
                                        ),
                                      )),
                                  Expanded(
                                      flex: 3,
                                      child: SizedBox(
                                          height: 100.0,
                                          width: 200.0,
                                          child: data["articles"][index]
                                                      ["urlToImage"] !=
                                                  null
                                              ? Image.network(
                                                  data["articles"][index]
                                                      ["urlToImage"],
                                                  fit: BoxFit.cover,
                                                )
                                              : Container())),
                                ],
                              ),
                              onTap: () {
                                Navigator.pushNamed(context, '/details',
                                    arguments: data["articles"][index]);
                              },
                            ),
                          ));
                    })
                : Text("error"));
  }
}
