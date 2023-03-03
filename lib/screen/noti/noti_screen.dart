import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kho_hang_nhat/widget/drawler.dart';

import '../../styles/init_style.dart';
import '../../widget/app_bar.dart';

class NotiScreen extends StatefulWidget {
  const NotiScreen({Key? key}) : super(key: key);

  @override
  State<NotiScreen> createState() => _NotiScreenState();
}

class _NotiScreenState extends State<NotiScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  int click = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: ItemDrawer(),
      appBar: AppBarCustom(
        leadingTap: (){
          _scaffoldKey.currentState!.openDrawer();
        },
          context: context,
          scaffoldKey: _scaffoldKey,
          tittle: Center(
              child: Text(
            'Thông báo',
            style: StyleApp.textStyle500(color: Colors.white, fontSize: 18),
          ))),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(),
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        click = 0;
                        setState(() {});
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: ColorApp.red),
                            color: click == 0 ? ColorApp.red : Colors.white),
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                          child: Text(
                            'Của bạn',
                            style: click == 0
                                ? StyleApp.textStyle700(color: Colors.white)
                                : StyleApp.textStyle400(color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        click = 1;
                        setState(() {});
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: ColorApp.red),
                            color: click == 1 ? ColorApp.red : Colors.white),
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                          child: Text(
                            'Sự kiện',
                            style: click == 1
                                ? StyleApp.textStyle700(color: Colors.white)
                                : StyleApp.textStyle400(color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(),
              ],
            ),

            ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
              itemBuilder: (context, index) {
                return
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey)
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: 10,right: 10,top: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Stack(
                            alignment: Alignment.topRight,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: ColorApp.red,
                                  ),
                                  child: Padding(
                                    padding:
                                    EdgeInsets.symmetric(vertical: 7, horizontal: 7),
                                    child: FaIcon(
                                      FontAwesomeIcons.solidEnvelope,
                                      color: Colors.white,
                                      size: 15,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: 12,
                                height: 12,
                                decoration: BoxDecoration(
                                    color: ColorApp.red,
                                    border: Border.all(color: Colors.white),
                                    shape: BoxShape.circle),
                              )
                            ],
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.7,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '  Bộ dầu gôi,dầu xả chỉ còn 133k',
                                  style: StyleApp.textStyle700(),
                                ),
                                Html( style: {'#': Style(maxLines: 1,textOverflow: TextOverflow.ellipsis)},
                                    data:
                                    '<p>My first paragraph.asfasfa sfja sjfjagsd ijgjdigr ig jvdfsg sdfgs dgsd gdsgs dg dgsdg sduhr nf g hol dfhnf gwerptsjfas</p>')
                              ],
                            ),
                          ),
                          Icon(
                            Icons.arrow_right_rounded,
                            color: ColorApp.red,
                          )
                        ],
                      ),
                    ),
                  );
              },
              itemCount: 20,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
            ),
          ],
        ),
      ),
    );
  }
}
