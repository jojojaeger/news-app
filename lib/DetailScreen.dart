import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailScreen extends StatelessWidget {
  final data;

  DetailScreen(this.data);

  _formatDate(input) {
    var date = DateTime.parse(input);
    return DateFormat('dd.MM.yyyy').format(date);
  }

  _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(60.0),
            child: AppBar(
                backgroundColor: Colors.white,
                title: Text(""),
                elevation: 0.0,
                leading: IconButton(
                  icon: FaIcon(
                    FontAwesomeIcons.chevronLeft,
                    size: 20,
                    color: Colors.deepOrange[800],
                  ),
                  onPressed: () => Navigator.pop(context),
                ))),
        backgroundColor: Colors.white,
        body: Container(
            padding: EdgeInsets.only(left: 16.0, bottom: 0.0, right: 16.0),
            child: Column(
              children: <Widget>[
                SizedBox(
                    child: data["urlToImage"] != null
                        ? Image.network(
                            data["urlToImage"],
                            fit: BoxFit.fill,
                            width: 700,
                          )
                        : Container()),
                Padding(
                  padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
                  child: Text(
                    data["title"],
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  ),
                ),
                Text(
                  data["content"],
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                        padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              _formatDate(
                                    data["publishedAt"],
                                  ) +
                                  "  |  " +
                                  data["source"]["name"],
                              style: TextStyle(
                                  color: Colors.grey[500], fontSize: 12),
                            ),
                            RaisedButton(
                              onPressed: () {
                                _launchURL(data["url"]);
                              },
                              color: Colors.deepOrange[800],
                              child: Text('READ MORE',
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.white)),
                            ),
                          ],
                        )),
                  ),
                )
              ],
            )));
  }
}
