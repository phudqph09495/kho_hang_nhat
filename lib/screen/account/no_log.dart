import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kho_hang_nhat/widget/drawler.dart';
import 'package:kho_hang_nhat/widget/item/load_image.dart';

import '../../styles/init_style.dart';
import '../../widget/app_bar.dart';
import 'inset_phone.dart';
import 'login_screen.dart';

class NoLogScreen extends StatefulWidget {
  const NoLogScreen({Key? key}) : super(key: key);

  @override
  State<NoLogScreen> createState() => _NoLogScreenState();
}

class _NoLogScreenState extends State<NoLogScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: ItemDrawer(),
      appBar: AppBarCustom(
          context: context,
          leadingTap: (){_scaffoldKey.currentState!.openDrawer();},
          scaffoldKey: _scaffoldKey,
          tittle: Center(
              child: Text(
            'Tài khoản',
            style: StyleApp.textStyle500(color: Colors.white, fontSize: 18),
          ))),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.15,
                  width: double.infinity,
                  decoration: BoxDecoration(border: Border.all(color: Colors.grey),

                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: MediaQuery.of(context).size.height * 0.03,
                            horizontal: 15),
                        child: Container(
                          decoration: BoxDecoration(shape: BoxShape.circle,border: Border.all(color: Colors.red,width: 2)),
                          child: ClipOval(
                            child: LoadImage(
                              url:
                              'https://t4.ftcdn.net/jpg/03/46/93/61/360_F_346936114_RaxE6OQogebgAWTalE1myseY1Hbb5qPM.jpg',
                              height: MediaQuery.of(context).size.height * 0.11,

                              fit: BoxFit.fitWidth,
                            ),
                          ),
                        ),
                      ),
                      InkWell(onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                      },child: Text('Đăng nhập ',style: StyleApp.textStyle700(fontSize: 16),)),
                      Text('| ',style: StyleApp.textStyle700(fontSize: 16),),
                      InkWell(onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>NhapSDT()));
                      },child: Text('Đăng ký ',style: StyleApp.textStyle700(fontSize: 16),))
                    ],
                  ),
                ),
                SizedBox(height: 30,),
                Container(
                  height: MediaQuery.of(context).size.height * 0.07,
                  width: double.infinity,
                  decoration: BoxDecoration(border: Border.all(color: Colors.grey),

                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(width: 30,),
                      // Icon(Icons.notice_,color: ColorApp.red,size: 35,),
                      FaIcon(FontAwesomeIcons.circleInfo,color: ColorApp.red,size: 30,),
                      SizedBox(width: 20,),
                      Text('Về chúng tôi',style: StyleApp.textStyle400(fontSize: 16),)
                    ],
                  ),
                ),
              ],
            ),
            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
              },
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.05,
                  width: double.infinity,
                  decoration: BoxDecoration(border: Border.all(color: Colors.grey),
                    color: ColorApp.red

                  ),
                  child: Center(child: Text('Đăng nhập',style: StyleApp.textStyle400(fontSize: 18,color: Colors.white),))
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
