import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kho_hang_nhat/bloc/auth/bloc_profile.dart';
import 'package:kho_hang_nhat/config/share_pref.dart';
import 'package:kho_hang_nhat/screen/account/profile_screen.dart';
import 'package:kho_hang_nhat/widget/drawler.dart';

import '../../bloc/auth/bloc_checkLogin.dart';
import '../../bloc/event_bloc.dart';
import '../../bloc/state_bloc.dart';
import '../../config/path/share_pref_path.dart';
import '../../model/model_user.dart';
import '../../styles/init_style.dart';
import '../../widget/app_bar.dart';
import '../../widget/item/load_image.dart';
import '../home.dart';
import 'history_screen.dart';
import 'login_screen.dart';

class LoggedScreen extends StatefulWidget {
  const LoggedScreen({Key? key}) : super(key: key);

  @override
  State<LoggedScreen> createState() => _LoggedScreenState();
}

class _LoggedScreenState extends State<LoggedScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  BlocProfile blocProfile = BlocProfile()..add(GetData());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        drawer: ItemDrawer(),
        appBar: AppBarCustom(
            context: context,
            leadingTap: () {
              _scaffoldKey.currentState!.openDrawer();
            },
            scaffoldKey: _scaffoldKey,
            tittle: Center(
                child: Text(
              'Tài khoản',
              style: StyleApp.textStyle500(color: Colors.white, fontSize: 18),
            ))),
        body: BlocBuilder(
          builder: (context, StateBloc state) {
            if(state is LoadSuccess){
              ModelUser modelUser=state.data;

              bool light = modelUser.setting!.enableNotification=='1';
              return Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.17,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: MediaQuery.of(context).size.height * 0.03,
                                    horizontal: 15),
                                child: Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(color: Colors.red, width: 2)),
                                  child: ClipOval(
                                    child: LoadImage(
                                      url:
                                      'https://t4.ftcdn.net/jpg/03/46/93/61/360_F_346936114_RaxE6OQogebgAWTalE1myseY1Hbb5qPM.jpg',
                                      height: MediaQuery.of(context).size.height * 0.13,
                                      fit: BoxFit.fitWidth,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: MediaQuery.of(context).size.height * 0.03,
                                    horizontal: 15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('${modelUser.phone}\n', style: StyleApp.textStyle700()),
                                    Text('${modelUser.email}',
                                        style: StyleApp.textStyle500()),
                                    Row(
                                      children: [
                                        Text('Số dư: ', style: StyleApp.textStyle500()),
                                        Text(
                                          '${modelUser.balance} Gold',
                                          style: StyleApp.textStyle500(color: ColorApp.red),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>LichSuDatHang()));
                          },
                          child: Container(
                            decoration: BoxDecoration(border:Border(top: BorderSide(color: Colors.grey))),
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(right: 25, left: 25, top: 10,bottom: 10),
                                  child: Row(
                                    children: [
                                      FaIcon(
                                        FontAwesomeIcons.clockRotateLeft,
                                        color: ColorApp.red,
                                      ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Text(
                                        'Lịch sử đặt hàng',
                                        style: StyleApp.textStyle400(fontSize: 16),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: InkWell(onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>Profle()));
                        },
                          child: Container(
                            decoration: BoxDecoration(border:Border(top: BorderSide(color: Colors.grey))),
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(right: 25, left: 25, top: 10,bottom: 10),
                                  child: Row(
                                    children: [
                                      FaIcon(
                                        FontAwesomeIcons.gear,
                                        color: ColorApp.red,
                                      ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Text(
                                        'Cài đặt tài khoản',
                                        style: StyleApp.textStyle400(fontSize: 16),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Container(
                          decoration: BoxDecoration(border:Border(top: BorderSide(color: Colors.grey))),
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(right: 25, left: 25, top: 10,bottom: 10),
                                child: Row(
                                  children: [
                                    FaIcon(
                                      FontAwesomeIcons.circleInfo,
                                      color: ColorApp.red,
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Text(
                                      'Về chúng tôi',
                                      style: StyleApp.textStyle400(fontSize: 16),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Container(
                          decoration: BoxDecoration(border:Border(top: BorderSide(color: Colors.grey),bottom: BorderSide(color: Colors.grey))),
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(right: 25, left: 25, top: 5,bottom: 5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        FaIcon(
                                          FontAwesomeIcons.bell,
                                          color: ColorApp.red,
                                        ),
                                        SizedBox(
                                          width: 15,
                                        ),
                                        Text(
                                          'Nhận thông báo',
                                          style: StyleApp.textStyle400(fontSize: 16),
                                        )
                                      ],
                                    ),
                                    Switch(
                                      // This bool value toggles the switch.
                                      value: light,
                                      activeColor: Colors.red,
                                      onChanged: (bool value) {
                                        // This is called when the user toggles the switch.
                                        setState(() {
                                          light = value;
                                        });
                                      },
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: ()async{
                      SharePrefsKeys.removeAllKey();
                      context.read<BlocCheckLogin>().add(GetData());
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Đăng xuất thành công"),backgroundColor: Colors.green,
                      ));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(width: double.infinity,color: ColorApp.red,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text('Đăng xuất',style: StyleApp.textStyle500(color: Colors.white,fontSize: 16),textAlign: TextAlign.center,),
                        ),
                      ),
                    ),
                  )
                ],
              );
            }
            if(state is LoadFail){

              return Center(
                child: Column(
                  children: [
                    SizedBox(height: 100,),
                    Text('Phiên đăng nhập đã hệt, vui lòng đăng nhập lại'
                        ''),
                    SizedBox(height: 10,),
                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                      },
                      child: Container(
                        decoration: BoxDecoration(border: Border.all()),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Đăng Nhập',style: StyleApp.textStyle500(color: ColorApp.blue00),textAlign: TextAlign.center,),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
            return SizedBox();
          },
          bloc: blocProfile,
        ));
  }
}