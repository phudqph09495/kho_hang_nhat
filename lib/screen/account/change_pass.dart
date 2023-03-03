import 'package:flutter/material.dart';

import '../../styles/init_style.dart';
import '../../widget/app_bar.dart';
import 'inset_phone.dart';

class ChangePass extends StatefulWidget {
  const ChangePass({Key? key}) : super(key: key);

  @override
  State<ChangePass> createState() => _ChangePassState();
}

class _ChangePassState extends State<ChangePass> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(
          context: context,
          hasCart: false,
          leadingTap: (){
            Navigator.pop(context);
          },
          scaffoldKey: _scaffoldKey,
          tittle: Center(
              child: Text(
                'Đổi mật khẩu',
                style: StyleApp.textStyle500(color: Colors.white, fontSize: 18),
              ))),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                    hintText: '     nhập mật khẩu ',
                    hintStyle: StyleApp.textStyle400(color: Colors.grey,fontSize: 16)
                ),
              ),
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                    hintText: '     nhập lại mật khẩu ',
                    hintStyle: StyleApp.textStyle400(color: Colors.grey,fontSize: 16),

                ),

              ),
              SizedBox(height: 15,),
              InkWell(
                onTap: (){
                },
                child: Container(
                  color: ColorApp.red,
                  width:MediaQuery.of(context).size.width * 0.5 ,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Center(child: Text('tiếp tục',style: StyleApp.textStyle700(color: Colors.white),)),
                  ),
                ),
              )
            ],
          ),
          // Container(
          //     height: MediaQuery.of(context).size.height * 0.05,
          //     width: double.infinity,
          //     decoration: BoxDecoration(border: Border.all(color: Colors.grey),
          //         color: Colors.white
          //
          //     ),
          //     child: Center(child: Text('Đăng ký',style: StyleApp.textStyle700(fontSize: 18,color: ColorApp.red),))
          // ),
        ],
      ),
    );
  }
}
