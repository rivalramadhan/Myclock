import 'dart:async';

import 'package:clock_app/enums.dart';
import 'package:clock_app/menuinfo.dart';
import 'package:clock_app/views/clock_view.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../data.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String formattedTime;
  var dateTime = DateTime.now();
  @override
  void initState() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var now = DateTime.now();
    var formattedDate = DateFormat('EEE, d MMM').format(now);
    formattedTime = DateFormat('HH:mm').format(now);
    var timezoneString = now.timeZoneOffset.toString().split('.').first;
    var offsetSign = '';
    if (timezoneString.startsWith('-')) offsetSign = '+';
    print(timezoneString);

    return ChangeNotifierProvider(
        create: (context) => MenuInfo(MenuType.alarm),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            backgroundColor: Color(0xff202f41),
            body: Row(
              children: <Widget>[
                Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: menuItems
                        .map((currentMenuInfo) =>
                            buildMenuButton(currentMenuInfo))
                        .toList()),
                VerticalDivider(
                  color: Colors.white54,
                  width: 1,
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 64),
                    alignment: Alignment.center,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Flexible(
                          flex: 1,
                          fit: FlexFit.tight,
                          child: Text(
                            'Clock',
                            style: TextStyle(color: Colors.white, fontSize: 24),
                          ),
                        ),
                        Flexible(
                          flex: 0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                formattedTime,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 64),
                              ),
                              Text(
                                formattedDate,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                        Flexible(
                            flex: 8,
                            fit: FlexFit.tight,
                            child: Align(
                                alignment: Alignment.center,
                                child: ClockView(size: 500))),
                        Flexible(
                          flex: 2,
                          fit: FlexFit.tight,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'TimeZone',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 24),
                              ),
                              SizedBox(width: 16),
                              Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.language,
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: 16),
                                  Text(
                                    'UTC' + offsetSign + timezoneString,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 14),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Widget buildMenuButton(MenuInfo currentMenuInfo) {
    return Consumer<MenuInfo>(
        builder: (BuildContext context, MenuInfo value, Widget child) {
      // ignore: deprecated_member_use
      return FlatButton(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        color: currentMenuInfo.menuType == value.menuType
            ? Colors.red
            : Colors.transparent,
        onPressed: () {
          var menuInfo = Provider.of<MenuInfo>(context, listen: false);
          menuInfo.updateMenu(currentMenuInfo);
        },
        child: Column(
          children: <Widget>[
            Image.asset(
              currentMenuInfo.imageSource,
              scale: 1.5,
            ),
            SizedBox(height: 16),
            Text(
              currentMenuInfo.title ?? '',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ],
        ),
      );
    });
  }
}
