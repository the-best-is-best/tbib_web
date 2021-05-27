import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../models/header_content.dart';

fetchData() async {
    var url = Uri.parse('http://localhost/tbib_web/header_content/get_data.php');

  try{
     await http.get(url);
  }catch(ex){
    return;
  }
  var response =  await http.get(url);
  if (response.statusCode == 201) {
    var obj = json.decode(response.body);
    HeaderContent.bg = obj['data']['bg'];
    HeaderContent.btnActive = obj['data']['btn_active'];
    HeaderContent.btnTitle = obj['data']['btn_title'];
    HeaderContent.content = obj['data']['content'].split('/n');
    HeaderContent.des = obj['data']['des'];
    HeaderContent.title = obj['data']['title'];
  }
 
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    fetchData();
    Timer(Duration(seconds: 5),
        () => Navigator.pushReplacementNamed(context, '/home'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Color.fromRGBO(240, 241, 242, 1),
            ),
          ),
          Column(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 70,
                        child: Image.asset(
                          'assets/images/logo.png',
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    CircularProgressIndicator(
                      color: Color.fromRGBO(217, 135, 17, 1),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: 20,
                      ),
                    ),
                    Text("Copyright © The Best Is Best 2021 "),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
