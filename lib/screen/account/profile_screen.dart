import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kho_hang_nhat/bloc/check_log_state.dart';

import '../../bloc/auth/bloc_profile.dart';
import '../../bloc/auth/bloc_updateProFile.dart';
import '../../bloc/choose_image_bloc.dart';
import '../../bloc/event_bloc.dart';
import '../../bloc/location/bloc_huyen.dart';
import '../../bloc/location/bloc_tinh.dart';
import '../../bloc/state_bloc.dart';
import '../../config/const.dart';
import '../../model/model_tinh.dart';
import '../../model/model_user.dart';
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
  BlocProfile blocProfile = BlocProfile()..add(GetData());
  List<String> listS = ['Nam', 'Nữ'];
  List<String> tinh = ['Hà Nội', 'TP Hồ Chí Minh', 'Đà Nẵng'];
  String tinhS = 'Chọn tỉnh/thành phố';
  String idTinh = "";
  String huyenS = 'Chọn quận/huyện';
  String idHuyen = '';
  String sex = 'Không xác định';
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController diachi = TextEditingController();
  BlocTinh blocTinh = BlocTinh()..add(GetData());
  ChooseImageBloc chooseImageBloc = ChooseImageBloc();
  TextEditingController ngaySinh = TextEditingController();
  BlocUpdateProFile blocUpdateProFile = BlocUpdateProFile();
  BlocHuyen blocHuyen = BlocHuyen();
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
        children: [
          BlocBuilder(
            builder: (_, StateBloc state) {
              if (state is LoadSuccess) {
                ModelUser model = state.data;
                model.location!.region != null
                    ? blocHuyen
                        .add(GetData2(param: '${model.location!.region!.id}'))
                    : null;
              }

              return SizedBox();
            },
            bloc: blocProfile,
          ),
          BlocBuilder(
            builder: (_, StateBloc state) {
              if (state is LoadSuccess) {
                ModelUser model = state.data;
                name.text = model.name ?? '';
                phone.text = model.phone ?? '';
                email.text = model.email ?? '';
                sex = model.gender!.name ?? '';
                ngaySinh.text = model.dateOfBirth ?? '';
                if (model.location!.region == null) {
                  model.location!.region = Gender(id: '', name: '');
                }
                if (model.location!.district == null) {
                  model.location!.district = Gender(id: '', name: '');
                }
                if (model.location!.address == null) {
                  model.location!.address = '';
                }
                tinhS = model.location!.region != null
                    ? model.location!.region!.name ?? ''
                    : '';
                idTinh = model.location!.region != null
                    ? model.location!.region!.id ?? ''
                    : '';
                huyenS = model.location!.region != null
                    ? model.location!.district!.name ?? ''
                    : '';
                idHuyen = model.location!.region != null
                    ? model.location!.district!.id ?? ''
                    : '';
                diachi.text = model.location!.address ?? '';
                return Column(
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
                                  vertical:
                                      MediaQuery.of(context).size.height * 0.03,
                                  horizontal: 15),
                              child: ClipOval(
                                child: snapshot != null
                                    ? Image.file(
                                        File(snapshot.path),
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.13,
                                        width:
                                            MediaQuery.of(context).size.height *
                                                0.13,
                                        fit: BoxFit.cover,
                                      )
                                    : LoadImage(
                                        bangtin: true,
                                        url:
                                            'https://img.freepik.com/free-icon/user_318-804790.jpg',
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.13,
                                        width:
                                            MediaQuery.of(context).size.height *
                                                0.13,
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
                            decoration: BoxDecoration(
                                border: Border(top: BorderSide())),
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
                                      onChanged: (val) {
                                        model.name = val;
                                      },
                                      controller: name,
                                      textAlign: TextAlign.end,
                                      decoration:
                                          InputDecoration(hintText: 'Điền tên'),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                border: Border(top: BorderSide())),
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
                                      onChanged: (val) {
                                        model.email = val;
                                      },
                                      textAlign: TextAlign.end,
                                      controller: email,
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
                            decoration: BoxDecoration(
                                border: Border(top: BorderSide())),
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
                                      onChanged: (val) {
                                        model.phone = val;
                                      },
                                      controller: phone,
                                      textAlign: TextAlign.end,
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
                            decoration: BoxDecoration(
                                border: Border(top: BorderSide())),
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
                                                      style: StyleApp
                                                          .textStyle500(),
                                                      textAlign: TextAlign.end,
                                                    ),
                                                    value: index,
                                                    onTap: () {
                                                      setState(() {
                                                        model.gender!.name =
                                                            listS[index];
                                                      });
                                                    },
                                                  ));
                                        })),
                              ],
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                border: Border(top: BorderSide())),
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
                                                firstDate:
                                                    DateTime(1930, 01, 01),
                                                lastDate: DateTime.now(),
                                                locale: Locale('vi'))
                                            .then((value) {
                                          if (value != null) {
                                            model.dateOfBirth =
                                                Const.formatTime(
                                                    value
                                                        .millisecondsSinceEpoch,
                                                    format: "yyyy-MM-dd");
                                            setState(() {});
                                          }
                                        });
                                      },
                                      textAlign: TextAlign.end,
                                      decoration: InputDecoration(
                                          hintText: '1970-01-01'),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                border: Border(top: BorderSide())),
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
                                    child: BlocBuilder(
                                      builder: (_, StateBloc state) {
                                        if (state is LoadSuccess) {
                                          ModelTinh modelTinh = state.data;
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
                                                    modelTinh.items!.length,
                                                    (index) => PopupMenuItem(
                                                          child: Text(
                                                            '${modelTinh.items![index].name}',
                                                            style: StyleApp
                                                                .textStyle500(),
                                                            textAlign:
                                                                TextAlign.end,
                                                          ),
                                                          value: index,
                                                          onTap: () {
                                                            model
                                                                    .location!
                                                                    .region!
                                                                    .name =
                                                                modelTinh
                                                                    .items![
                                                                        index]
                                                                    .name;
                                                            model
                                                                    .location!
                                                                    .region!
                                                                    .id =
                                                                modelTinh
                                                                    .items![
                                                                        index]
                                                                    .id;
                                                            blocHuyen.add(GetData2(
                                                                param:
                                                                    '${model.location!.region!.id}'));
                                                            setState(() {
                                                              // tinhS = model.items![index].name;
                                                            });
                                                          },
                                                        ));
                                              });
                                        }
                                        return SizedBox();
                                      },
                                      bloc: blocTinh,
                                    )),
                              ],
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                border: Border(top: BorderSide())),
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
                                    child: BlocBuilder(
                                      builder: (_, StateBloc state) {
                                        if (state is LoadSuccess) {
                                          ModelTinh modelHuyen = state.data;
                                          return PopupMenuButton(
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
                                                    modelHuyen.items!.length,
                                                    (index) => PopupMenuItem(
                                                          child: Text(
                                                            '${modelHuyen.items![index].name}',
                                                            style: StyleApp
                                                                .textStyle500(),
                                                            textAlign:
                                                                TextAlign.end,
                                                          ),
                                                          value: index,
                                                          onTap: () {
                                                            setState(() {
                                                              model
                                                                  .location!
                                                                  .district!
                                                                  .name = modelHuyen
                                                                      .items![
                                                                          index]
                                                                      .name ??
                                                                  '';
                                                              model
                                                                  .location!
                                                                  .district!
                                                                  .id = modelHuyen
                                                                      .items![
                                                                          index]
                                                                      .id ??
                                                                  '';
                                                            });
                                                          },
                                                        ));
                                              });
                                        }
                                        return SizedBox();
                                      },
                                      bloc: blocHuyen,
                                    )),
                              ],
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                border: Border(top: BorderSide())),
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
                                    controller: diachi,
                                    onChanged: (val) {
                                      model.location!.address = val;
                                    },
                                    keyboardType: TextInputType.phone,
                                    decoration: InputDecoration(
                                      hintText: 'Nhập địa chỉ cụ thể',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          BlocListener(
                            bloc: blocUpdateProFile,
                            listener: (_, StateBloc state) {
                              CheckLogState.check(context,
                                  state: state,
                                  msg: 'Cập nhật thành công',
                                  success: () {
                                    blocProfile.add(GetData());
                                  });
                            },
                            child: InkWell(
                              onTap: () {
                                print(idTinh);
                                print(idHuyen);
                                print(name.text);
                                print(phone.text);
                                print(email.text);
                                print(diachi.text);
                                print(ngaySinh.text);
                                blocUpdateProFile.add(UpdateProfile(
                                    name: name.text,
                                    phone: phone.text,
                                    email: email.text,
                                    district: idHuyen,
                                    region: idTinh,
                                    address: diachi.text));
                              },
                              child: Container(
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
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          )
                        ],
                      ),
                    )
                  ],
                );
              }
              return SizedBox();
            },
            bloc: blocProfile,
          ),
        ],
      )),
    );
  }
}
