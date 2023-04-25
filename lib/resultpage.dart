import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ResultPage extends StatefulWidget {
  String city;
  ResultPage({required this.city});

  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  late Map weatherData;
  fetchData() async {
    http.Response response = await http.get(
        ("http://api.openweathermap.org/data/2.5/weather?q=" +
            widget.city +
            "&appid=854554d4e9afaf233bf0a4e9bc9df1de") as Uri);
    setState(() {
      weatherData = jsonDecode(response.body);
    });
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Today's Weather",
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: weatherData == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              padding: const EdgeInsets.all(60),
              child: Column(
                children: <Widget>[
                  Text(
                    weatherData["name"],
                    style: TextStyle(
                        fontSize: 45,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  Image.network(
                    "http://openweathermap.org/img/wn/" +
                        weatherData["weather"][0]["icon"] +
                        "@4x.png",
                  ),
                  Text(
                    (weatherData["main"]["temp"] - 273.15).toStringAsFixed(2) +
                        "℃",
                    style: TextStyle(
                        fontSize: 45,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 30)),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                              "Feels Like:",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.grey[600],
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              (weatherData["main"]["feels_like"] - 273.15)
                                      .toStringAsFixed(2) +
                                  "℃",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.grey[600],
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const Padding(padding: EdgeInsets.only(top: 5)),
                        Row(
                          children: <Widget>[
                            Text(
                              "Max:",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.grey[600],
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              (weatherData["main"]["temp_max"] - 273.15)
                                      .toStringAsFixed(2) +
                                  "℃",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.grey[600],
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const Padding(padding: EdgeInsets.only(top: 5)),
                        Row(
                          children: <Widget>[
                            Text(
                              "Min:",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.grey[600],
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              (weatherData["main"]["temp_min"] - 273.15)
                                      .toStringAsFixed(2) +
                                  "℃",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.grey[600],
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const Padding(padding: EdgeInsets.only(top: 5)),
                        Row(
                          children: <Widget>[
                            Text(
                              "Humidity:",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.grey[600],
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              (weatherData["main"]["humidity"]).toString() +
                                  "%",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.grey[600],
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const Padding(padding: EdgeInsets.only(top: 40)),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green[600],
                            padding: const EdgeInsets.all(5),
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Row(
                            children: const <Widget>[
                              Icon(
                                Icons.arrow_back,
                                size: 20,
                                color: Colors.white,
                              ),
                              Text(
                                " CHANGE CITY",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
