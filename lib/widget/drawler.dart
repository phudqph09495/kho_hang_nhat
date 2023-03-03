import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../bloc/auth/bloc_checkLogin.dart';

import '../bloc/config/bloc_config.dart';
import '../bloc/event_bloc.dart';
import '../bloc/state_bloc.dart';
import '../config/const.dart';
import '../config/path/image_path.dart';
import '../config/path/share_pref_path.dart';
import '../model/model_config.dart';
import '../styles/init_style.dart';

class ItemDrawer extends StatefulWidget {
  @override
  State<ItemDrawer> createState() => _ItemDrawerState();
}

class _ItemDrawerState extends State<ItemDrawer> {
  BlocConfig blocConfig = BlocConfig()..add(GetData());

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      child: Drawer(
        backgroundColor: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                  child: Image.asset(
                'assets/images/logoNoBG.png',
                width: MediaQuery.of(context).size.width * 0.4,
              )),
              buildRow(title: 'MẸ VÀ BÉ'), Divider(),
              buildRow(title: 'SỨC KHOẺ & SẮC ĐẸP'), Divider(),

              buildRow(title: 'NHÀ CỬA & ĐỜI SỐNG'), Divider(),

              buildRow(title: 'BÁCH HOÁ ONLINE'), Divider(),

              buildRow(title: 'THỜI TRANG'), Divider(),
              buildRow(title: 'ĐIỆN MÁY'), Divider(),
              buildRow(title: 'NHÀ THÔNG MINH'), Divider(),
              buildRow(title: 'SẢN PHẨM HÀN QUỐC (KOREA)'), Divider(),
              buildRow(title: 'SẢN PHẨM ÚC (AUSTRALIA)'), Divider(),
              buildRow(title: 'SẢN PHẨM ĐỨC (GERMANY)'), Divider(),
              SizedBox(
                height: 15,
              ),
              BlocBuilder(
                builder: (_, StateBloc state) {
                  if(state is LoadSuccess){
                    ModelConfig model=state.data;
                    return Html(data: '${model.shopInfo}');
                  }
                  return SizedBox();
                },
                bloc: blocConfig,
              )
              // Padding(
              //   padding: EdgeInsets.symmetric(horizontal: 15),
              //   child: Text('KHO HÀNG NHẬT',
              //       style: StyleApp.textStyle700(
              //         fontSize: 16,)),
              // ),SizedBox(height: 15,),
              // RichText(
              //   text: TextSpan(
              //     text: 'Đơn vị chủ quản :  ',
              //     style: StyleApp.textStyle700(),
              //     children:  <TextSpan>[
              //       TextSpan(text: 'Hộ kinh doanh Trần Thị Nhung - App Hoàng Anh', style: StyleApp.textStyle400()),
              //
              //     ],
              //   ),
              // ),
              //
              // SizedBox(height: 15,),
              // RichText(
              //   text: TextSpan(
              //     text: 'Địa chỉ Shop :  ',
              //     style: StyleApp.textStyle700(),
              //     children:  <TextSpan>[
              //       TextSpan(text: 'Số 30 Nguyễn Ngọc Nại, phường Khương Mai, quận Thanh Xuân, Hà Nội', style: StyleApp.textStyle400()),
              //
              //     ],
              //   ),
              // ),
              // SizedBox(height: 15,),
              // RichText(
              //   text: TextSpan(
              //     text: 'Mã số thuế/GPKD :  ',
              //     style: StyleApp.textStyle700(),
              //     children:  <TextSpan>[
              //       TextSpan(text: '0F1F801514441', style: StyleApp.textStyle400()),
              //
              //     ],
              //   ),
              // ),
              // SizedBox(height: 15,),
              // RichText(
              //   text: TextSpan(
              //     text: 'Website/Facebook :  ',
              //     style: StyleApp.textStyle700(),
              //     children:  <TextSpan>[
              //       TextSpan(text: 'Khohangnhat.vn', style: StyleApp.textStyle400()),
              //
              //     ],
              //   ),
              // ),
              // SizedBox(height: 15,),
              // RichText(
              //   text: TextSpan(
              //     text: 'Email :  ',
              //     style: StyleApp.textStyle700(),
              //     children:  <TextSpan>[
              //       TextSpan(text: 'khohangnhat.vn@gmail.com', style: StyleApp.textStyle400()),
              //
              //     ],
              //   ),
              // ),
              // SizedBox(height: 15,),
              // RichText(
              //   text: TextSpan(
              //     text: 'Về chúng tôi :  ',
              //     style: StyleApp.textStyle700(),
              //     children:  <TextSpan>[
              //       TextSpan(text: '(024) 8888 3333', style: StyleApp.textStyle400()),
              //
              //     ],
              //   ),
              // ),
              // SizedBox(height: 15,),
              // RichText(
              //   text: TextSpan(
              //     text: 'Zalo/Viber :  ',
              //     style: StyleApp.textStyle700(),
              //     children:  <TextSpan>[
              //       TextSpan(text: '0923 220 222', style: StyleApp.textStyle400()),
              //
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  buildRow({
    required String title,
    Function()? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          child: Text(
            title,
            overflow: TextOverflow.ellipsis,
            style: StyleApp.textStyle700(
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
