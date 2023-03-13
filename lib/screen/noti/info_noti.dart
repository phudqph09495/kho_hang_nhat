import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:kho_hang_nhat/model/model_noti.dart';

import '../../styles/init_style.dart';

class InfoNotiScreen extends StatelessWidget {
  NotiFiCa notiFiCa;
  InfoNotiScreen({required this.notiFiCa});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: ColorApp.whiteF7,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: ColorApp.red,
        title: Text('${notiFiCa.title}',style: StyleApp.textStyle500(color: Colors.white),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Html(data: notiFiCa.description,),
      ),
    );
  }
}
