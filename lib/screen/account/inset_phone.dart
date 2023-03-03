import 'package:flutter/material.dart';
import 'package:kho_hang_nhat/widget/item/input/text_filed.dart';
import 'package:kho_hang_nhat/widget/item/load_image.dart';

import '../../styles/init_style.dart';
import '../../widget/app_bar.dart';
import 'confirm_phone.dart';

class NhapSDT extends StatefulWidget {
  const NhapSDT({Key? key}) : super(key: key);

  @override
  State<NhapSDT> createState() => _NhapSDTState();
}

class _NhapSDTState extends State<NhapSDT> {
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
            'Nhập số điện thoại',
            style: StyleApp.textStyle500(color: Colors.white, fontSize: 18),
          ))),
      body: Column(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Image.asset('assets/images/img.png',width: MediaQuery.of(context).size.width * 0.35,),
              // child: LoadImage(
              //   url:
              //       'https://img.ws.mms.shopee.vn/3481ecb6f8a0e5d6949fd877cbdd183d',
              //   width: MediaQuery.of(context).size.width * 0.3,
              // ),
            ),
          ),
          Text(
            'Chào mừng bạn đến với kho hàng Nhật',
            style: StyleApp.textStyle700(color: ColorApp.red, fontSize: 16),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
              width: MediaQuery.of(context).size.width * 0.6,
              child: InputText1(
                label: 'Số điện thoại',
                keyboardType: TextInputType.phone,
                radius: 0,
                borderColor: Colors.grey,
                colorBg: Colors.white,
              )),
          SizedBox(
            height: 15,
          ),
          InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>XacNhanSDT()));
            },
            child: Container(
              color: ColorApp.red,
              width:MediaQuery.of(context).size.width * 0.5 ,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Center(child: Text('Tiếp tục',style: StyleApp.textStyle700(color: Colors.white),)),
              ),
            ),
          )
        ],
      ),
    );
  }
}
