import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../bloc/auth/bloc_checkLogin.dart';
import '../bloc/event_bloc.dart';
import '../bloc/state_bloc.dart';
import '../styles/init_style.dart';
import '../widget/app_bar.dart';
import 'account/logged_screen.dart';
import 'account/no_log.dart';
import 'chat/chat_screen.dart';
import 'home/homeScreen.dart';
import 'love/love_screen.dart';
import 'noti/noti_screen.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  _launchURL(url) async {

    if (await canLaunchUrl(url)) {
      await launchUrl(url,mode: LaunchMode.externalApplication);
    } else {
      throw 'Đã có lỗi , vui lòng quay lại sau';
    }
  }

  int index = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<BlocCheckLogin>().add(GetData());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: BlocBuilder<BlocCheckLogin, StateBloc>(
        builder: (context,StateBloc state){
          final check = state is LoadSuccess ? state.data as bool : false;
          return IndexedStack(
            index: index,

            children: [
              HomeScreen(),
              ChatScreen(),
              NotiScreen(),
              LoveScreen(),
           check?LoggedScreen(): NoLogScreen()
              // AccountScreen()
            ],
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items:  [
          BottomNavigationBarItem(
              icon:Icon(Icons.home_outlined), label: "HOME"),
          BottomNavigationBarItem(
              icon:SpeedDial(
                iconTheme: IconThemeData(color: Colors.red),
                activeIcon: Icons.close,
                child: Column(mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
SizedBox(),
                   Column(children: [
                     Padding(
                       padding: EdgeInsets.symmetric(vertical: 2),
                       child: FaIcon(FontAwesomeIcons.commentDots,size: 20,color: Colors.black,),
                     ),
                     Text('CHAT',style: StyleApp.textStyle400(fontSize: 12),),
                   ],)
                  ],
                ),
                backgroundColor: Colors.white,
                switchLabelPosition: true,
                elevation: 0,
                spaceBetweenChildren: 5,
                animationCurve: Curves.easeInOut,
                overlayColor: Colors.grey,
                overlayOpacity: 0.3,
                children: [

                  SpeedDialChild(
                      onTap: () {
                        _launchURL(Uri.parse('https://www.zalo.me/0923220222'));
                      },
                      backgroundColor: Colors.white,
                      labelBackgroundColor: Colors.black,
                      labelStyle: TextStyle(fontSize: 15, color: Colors.white),
                      child: Transform.scale(scale: 0.8,child: Image.asset('assets/images/zalo.png',fit: BoxFit.fitHeight  ,)),
                      label: 'Zalo'),
                  SpeedDialChild(
                      onTap: () {
                          _launchURL(Uri.parse('https://www.messenger.com/t/khohangnhat.vn'));
                      },
                      backgroundColor: Colors.white,
                      labelBackgroundColor: Colors.black,
                      labelStyle: TextStyle(fontSize: 15, color: Colors.white),
                      child: FaIcon(FontAwesomeIcons.facebookMessenger,color: Colors.blue,),
                      label: 'Messenger'),

                ],
              ), label: ""),
          // BottomNavigationBarItem(
          //     icon:ImageIcon(AssetImage(ImagePath.bottomBarDon)), label: "Đon từ"),
          BottomNavigationBarItem(
              icon:Icon(Icons.notifications_none_outlined), label: "THÔNG BÁO"),
          BottomNavigationBarItem(
              icon:Icon(Icons.star_border_outlined), label: "YÊU THÍCH"),
          BottomNavigationBarItem(
              icon:Icon(Icons.person_outline_rounded), label: "TÀI KHOẢN"),
          // BottomNavigationBarItem(
          //     icon:ImageIcon(AssetImage(ImagePath.bottomBarAccount)), label: "Tài khoản"),
        ],
        onTap: (val) {
          index = val;
          setState(() {});
          // if(index==1){
          //   _launchURL(Uri.parse('https://www.messenger.com/t/khohangnhat.vn'));
          //
          // }

        },
        backgroundColor: Colors.white,
        currentIndex: index,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: ColorApp.red,
        selectedLabelStyle:
        StyleApp.textStyle400(color: ColorApp.red, fontSize: 12),
        unselectedItemColor: ColorApp.black,
        unselectedLabelStyle:
        StyleApp.textStyle400(color: ColorApp.black, fontSize: 12),
      ),
    );
  }
}
