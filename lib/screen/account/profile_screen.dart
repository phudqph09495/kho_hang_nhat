import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:image_picker/image_picker.dart';

import '../../bloc/choose_image_bloc.dart';
import '../../bloc/event_bloc.dart';
import '../../bloc/location/bloc_tinh.dart';
import '../../bloc/state_bloc.dart';
import '../../config/const.dart';
import '../../model/model_tinh.dart';
import '../../styles/init_style.dart';
import '../../widget/app_bar.dart';
import '../../widget/item/load_image.dart';

class Profle extends StatefulWidget {
  const Profle({Key? key}) : super(key: key);

  @override
  State<Profle> createState() => _ProfleState();
}

class _ProfleState extends State<Profle> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  List<String> listS = ['Nam', 'Nữ'];
  List<String> tinh = ['Hà Nội', 'TP Hồ Chí Minh', 'Đà Nẵng'];
  String? tinhS = 'Chọn tỉnh/thành phố';
  String huyenS = 'Chọn quận/huyện';
  String sex = 'Không xác định';
  BlocTinh blocTinh=BlocTinh()..add(GetData());
  ChooseImageBloc chooseImageBloc = ChooseImageBloc();
  TextEditingController ngaySinh = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(
          context: context,
          hasCart: false,
          leadingTap: () {
            Navigator.pop(context);
          },
          scaffoldKey: _scaffoldKey,
          tittle: Center(
              child: Text(
            'Cài đặt tài khoản',
            style: StyleApp.textStyle500(color: Colors.white, fontSize: 18),
          ))),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocBuilder(
              builder: (context, XFile? snapshot) {
                return InkWell(
                  onTap: () {
                    ImagePicker _picker = ImagePicker();
                    _picker
                        .pickImage(source: ImageSource.gallery)
                        .then((value) {
                      chooseImageBloc.getImage(image: value);
                    });
                  },
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).size.height * 0.03,
                          horizontal: 15),
                      child: ClipOval(
                        child:snapshot != null?Image.file(
                          File(snapshot.path),
                          height: MediaQuery.of(context).size.height * 0.13,
                          width: MediaQuery.of(context).size.height * 0.13,
                          fit: BoxFit.cover,
                        ): LoadImage(
                          bangtin: true,
                          url:
                              'https://img.freepik.com/free-icon/user_318-804790.jpg',
                          height: MediaQuery.of(context).size.height * 0.13,
                          width: MediaQuery.of(context).size.height * 0.13,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                );
              },
              bloc: chooseImageBloc,
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.only(left: 10, right: 5),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    decoration:
                        BoxDecoration(border: Border(top: BorderSide())),
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: Text(
                            'Tên',
                            style: StyleApp.textStyle500(),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(left: 15),
                            child: TextFormField(
                              textAlign: TextAlign.end,
                              decoration: InputDecoration(hintText: 'Điền tên'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    decoration:
                        BoxDecoration(border: Border(top: BorderSide())),
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: Text(
                            'Email',
                            style: StyleApp.textStyle500(),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(left: 15),
                            child: TextFormField(
                              textAlign: TextAlign.end,
                              decoration: InputDecoration(
                                hintText: 'Email',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    decoration:
                        BoxDecoration(border: Border(top: BorderSide())),
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: Text(
                            'Số điện thoại',
                            style: StyleApp.textStyle500(),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(left: 15),
                            child: TextFormField(
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                hintText: '',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    decoration:
                        BoxDecoration(border: Border(top: BorderSide())),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 13),
                          child: Text(
                            'Giới tính',
                            style: StyleApp.textStyle500(),
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.only(left: 15),
                            child: PopupMenuButton(
                                child: Row(
                                  children: [
                                    Text(
                                      sex,
                                      style: StyleApp.textStyle500(),
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                    ),
                                  ],
                                ),
                                itemBuilder: (context) {
                                  return List.generate(
                                      listS.length,
                                      (index) => PopupMenuItem(
                                            child: Text(
                                              listS[index],
                                              style: StyleApp.textStyle500(),
                                              textAlign: TextAlign.end,
                                            ),
                                            value: index,
                                            onTap: () {
                                              setState(() {
                                                sex = listS[index];
                                              });
                                            },
                                          ));
                                })),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    decoration:
                        BoxDecoration(border: Border(top: BorderSide())),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 13),
                          child: Text(
                            'Ngày sinh',
                            style: StyleApp.textStyle500(),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(left: 15),
                            child: TextFormField(
                              style: StyleApp.textStyle500(),
                              readOnly: true,
                              controller: ngaySinh,
                              onTap: () {
                                showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(1930, 01, 01),
                                        lastDate: DateTime.now(),
                                        locale: Locale('vi'))
                                    .then((value) {
                                  if (value != null) {
                                    ngaySinh.text = Const.formatTime(
                                        value.millisecondsSinceEpoch,
                                        format: " dd/MM/yyyy");
                                  }
                                });
                              },
                              textAlign: TextAlign.end,
                              decoration:
                                  InputDecoration(hintText: '01/01/1970'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    decoration:
                        BoxDecoration(border: Border(top: BorderSide())),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 13),
                          child: Text(
                            'Tỉnh/thành phố',
                            style: StyleApp.textStyle500(),
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.only(left: 15),
                            child: BlocBuilder(builder: (_,StateBloc state){
                              if(state is LoadSuccess){
                                ModelTinh model=state.data;
                                return PopupMenuButton(
                                    child: Row(
                                      children: [
                                        Text('${tinhS}'),
                                        Icon(
                                          Icons.arrow_forward_ios,
                                        ),
                                      ],
                                    ),
                                    itemBuilder: (context) {
                                      return List.generate(
                                          model.items!.length,
                                              (index) => PopupMenuItem(
                                            child: Text(
                                              '${model.items![index].name}',
                                              style: StyleApp.textStyle500(),
                                              textAlign: TextAlign.end,
                                            ),
                                            value: index,
                                            onTap: () {
                                              setState(() {
                                                tinhS = model.items![index].name;
                                              });
                                            },
                                          ));
                                    });
                              }
                              return SizedBox();
                            },bloc: blocTinh,)),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    decoration:
                        BoxDecoration(border: Border(top: BorderSide())),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 13),
                          child: Text(
                            'Quận/huyện',
                            style: StyleApp.textStyle500(),
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.only(left: 15),
                            child: PopupMenuButton(
                                child: Row(
                                  children: [
                                    Text(huyenS),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                    ),
                                  ],
                                ),
                                itemBuilder: (context) {
                                  return List.generate(
                                      tinh.length,
                                      (index) => PopupMenuItem(
                                            child: Text(
                                              tinh[index],
                                              style: StyleApp.textStyle500(),
                                              textAlign: TextAlign.end,
                                            ),
                                            value: index,
                                            onTap: () {
                                              setState(() {
                                                huyenS = tinh[index];
                                              });
                                            },
                                          ));
                                })),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    decoration:
                        BoxDecoration(border: Border(top: BorderSide())),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 13),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Địa chỉ cụ thể',
                            style: StyleApp.textStyle500(),
                          ),
                          Text(
                            'Số nhà,tên toà nhà, tên đường, tên khu vực',
                            style: StyleApp.textStyle400(fontSize: 14),
                          ),
                          TextFormField(
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              hintText: 'Nhập địa chỉ cụ thể',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(color: ColorApp.red),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Center(
                          child: Text(
                        'Lưu thông tin',
                        style: StyleApp.textStyle700(
                            fontSize: 16, color: Colors.white),
                      )),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
