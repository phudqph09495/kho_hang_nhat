import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kho_hang_nhat/bloc/location/bloc_huyen.dart';

import '../../bloc/auth/bloc_profile.dart';
import '../../bloc/cart/bloc_cart.dart';
import '../../bloc/cart/event_bloc2.dart';
import '../../bloc/event_bloc.dart';
import '../../bloc/location/bloc_tinh.dart';
import '../../bloc/product/bloc_infoPrd.dart';
import '../../bloc/state_bloc.dart';
import '../../model/model_productMain.dart';
import '../../model/model_tinh.dart';
import '../../model/model_user.dart';
import '../../styles/init_style.dart';
import 'dart:async';

import '../../widget/item/load_image.dart';
import '../home.dart';
import 'ketQua_screen.dart';

class ThanhToanScreen extends StatefulWidget {
  const ThanhToanScreen({Key? key}) : super(key: key);

  @override
  State<ThanhToanScreen> createState() => _ThanhToanScreenState();
}

class _ThanhToanScreenState extends State<ThanhToanScreen> {

  String tinhS = 'Chọn tỉnh/thành phố';
  String idTinh = "";
  String huyenS = 'Chọn quận/huyện';
  String idHuyen = '';
  int checkedVC = 0;
  int checkedTT = 0;
  bool mau = true;
  late var timer;

  BlocTinh blocTinh = BlocTinh();
  BlocProfile blocProfile = BlocProfile();
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController diachi = TextEditingController();
String huyenSS='';
  ModelUser model=ModelUser();

String idHuyenNN='';
  BlocHuyen blocHuyen = BlocHuyen();

  int sum = 0;
  BlocCartLocal blocCartLocal = BlocCartLocal();
  Bloc_infoPrd bloc = Bloc_infoPrd();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    blocProfile.add(GetData());
    blocTinh.add(GetData());
    timer = Timer.periodic(Duration(milliseconds: 2000), (timer) {
      mau = !mau;

    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(MediaQuery.of(context).size.height * 0.07),
          child: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: ColorApp.red,
            flexibleSpace: Padding(
              padding: EdgeInsets.only(
                  right: 10,
                  left: 10,
                  top: MediaQuery.of(context).size.height * 0.05),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: Center(
                        child: Text(
                          'Đơn hàng của bạn',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: StyleApp.textStyle500(
                              color: Colors.white, fontSize: 18),
                        ),
                      )),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyHomePage()));
                    },
                    child: Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Colors.white),
                        child: ClipOval(
                          child: Image.asset(
                            'assets/images/img.png',
                            height: 40,
                            width: 40,
                            fit: BoxFit.cover,
                          ),
                        )),
                  ),
                ],
              ),
            ),
          )),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(children: [
BlocBuilder(builder: (_,StateBloc state){
if(state is LoadSuccess){
  ModelUser model=state.data;
  blocHuyen.add(GetData2(param: '${model.location!.region!.id}'));
}

  return SizedBox();
},bloc: blocProfile,),

          BlocBuilder(
            builder: (_, StateBloc state) {
              if (state is LoadSuccess) {
              model   = state.data;

                name.text = model.name ?? '';
                phone.text = model.phone ?? '';
                tinhS = model.location!.region!.name ?? '';
                idTinh = model.location!.region!.id ?? '';
                huyenS = model.location!.district!.name ?? '';
                idHuyen = model.location!.district!.id ?? '';
                diachi.text = model.location!.address ?? '';
                return Column(
                  children: [
                    Table(
                      columnWidths: const {
                        0: FlexColumnWidth(5),
                        1: FlexColumnWidth(5),
                      },
                      border: TableBorder(
                          horizontalInside: BorderSide(color: Colors.black12),
                          top: BorderSide(color: Colors.black12),
                          left: BorderSide(color: Colors.black12),
                          right: BorderSide(color: Colors.black12),
                          bottom: BorderSide(color: Colors.black12)),
                      children: [
                        TableRow(children: [
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text('Thông tin giao hàng',
                                      style: StyleApp.textStyle700()),
                                )
                              ]),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text('',
                                      style: TextStyle(fontSize: 20.0)),
                                )
                              ]),
                        ]),
                        TableRow(children: [
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'Tên',
                                    style: StyleApp.textStyle400(),
                                  ),
                                )
                              ]),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                TextFormField(
                                  controller: name,
                                  textAlign: TextAlign.end,
                                  decoration:
                                      InputDecoration(hintText: 'Điền tên'),
                                )
                              ]),
                        ]),
                        TableRow(children: [
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'Số điện thoại',
                                    style: StyleApp.textStyle400(),
                                  ),
                                )
                              ]),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                TextFormField(
                                  controller: phone,
                                  textAlign: TextAlign.end,
                                  decoration:
                                      InputDecoration(hintText: 'Điền sdt'),
                                )
                              ]),
                        ]),
                        TableRow(children: [
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'Tỉnh/thành phố',
                                    style: StyleApp.textStyle400(),
                                  ),
                                )
                              ]),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                BlocBuilder(
                                  builder: (_, StateBloc state) {
                                    if (state is LoadSuccess) {
                                      ModelTinh modelTinh = state.data;
                                      return StatefulBuilder(builder:
                                          (BuildContext context,
                                              StateSetter setState) {
                                        return PopupMenuButton(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                SizedBox(),
                                                Row(
                                                  children: [
                                                    Text('${tinhS}'),
                                                    Icon(
                                                      Icons.arrow_forward_ios,
                                                    ),
                                                  ],
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
                                                          setState(() {
                                                            model
                                                                .location!
                                                                .region!
                                                                .name = modelTinh
                                                                    .items![
                                                                        index]
                                                                    .name ??
                                                                '';
                                                            model.location!.region!.id= modelTinh
                                                                    .items![
                                                                        index]
                                                                    .id ??
                                                                '';
                                                            blocHuyen.add(GetData2(
                                                                param:
                                                                    '${model.location!.region!.id= modelTinh
                                                                        .items![
                                                                    index]
                                                                        .id}'));
                                                          });
                                                        },
                                                      ));
                                            });
                                      });
                                    }
                                    return SizedBox();
                                  },
                                  bloc: blocTinh,
                                )
                                //
                              ]),
                        ]),
                        TableRow(children: [
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text('Quận/huyện'),
                                )
                              ]),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                BlocBuilder(
                                  builder: (_, StateBloc state) {
                                    ModelTinh modelHuyen = state is LoadSuccess
                                        ? state.data as ModelTinh
                                        : ModelTinh();

                                    return StatefulBuilder(
                                      builder: (BuildContext context,
                                          StateSetter setState) {

                                        return PopupMenuButton(
                                            constraints: BoxConstraints.expand(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.5,
                                                height: 300),
                                            padding: EdgeInsets.zero,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                SizedBox(),
                                                Row(
                                                  children: [
                                                    Text(huyenS),
                                                    Icon(
                                                      Icons.arrow_forward_ios,
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                            itemBuilder: (context) {
                                              return List.generate(
                                                  modelHuyen.items!.length,
                                                  (index) => PopupMenuItem(
                                                        child: Text(
                                                          modelHuyen
                                                                  .items![index]
                                                                  .name ??
                                                              '',
                                                          style: StyleApp
                                                              .textStyle500(),
                                                          textAlign:
                                                              TextAlign.end,
                                                        ),
                                                        value: index,
                                                        onTap: () {

                                                          setState(() {
                                                            model.location!.district!.name = modelHuyen
                                                                .items![
                                                            index]
                                                                .name ??
                                                                '';
                                                            model.location!.district!.id = modelHuyen
                                                                .items![
                                                            index]
                                                                .id ??
                                                                '';
                                                          });

                                                        },
                                                      ));
                                            });
                                      },
                                    );
                                  },
                                  bloc: blocHuyen,
                                )
                              ]),
                        ]),
                      ],
                    ),
                    Table(
                      border: TableBorder(
                          bottom: BorderSide(color: Colors.black12),
                          left: BorderSide(color: Colors.black12),
                          right: BorderSide(color: Colors.black12)),
                      columnWidths: const {
                        0: FlexColumnWidth(50),
                        1: FlexColumnWidth(1),
                      },
                      children: [
                        TableRow(children: [
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Địa chỉ cụ thể',
                                        style: StyleApp.textStyle400(),
                                      ),
                                      Text(
                                        'Số nhà, tên toà nhà, tên đường tên khu vực',
                                        style:
                                            StyleApp.textStyle400(fontSize: 12),
                                      ),
                                      TextFormField(
                                        controller: diachi,
                                        decoration: InputDecoration(
                                          hintText: 'Nhập địa chỉ cụ thế',
                                          hintStyle: StyleApp.textStyle400(),
                                        ),
                                        maxLines: 1,
                                      )
                                    ],
                                  ),
                                )
                              ]),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child:
                                      Text('', style: StyleApp.textStyle400()),
                                )
                              ]),
                        ]),
                      ],
                    ),
                  ],
                );
              }
              return SizedBox();
            },
            bloc: blocProfile,
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            decoration:
                BoxDecoration(border: Border.all(color: Colors.black12)),
            width: double.infinity,
            child: Column(
              children: [
                Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        border:
                            Border(bottom: BorderSide(color: Colors.black12))),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Hình thức vận chuyển',
                        style: StyleApp.textStyle700(fontSize: 14),
                      ),
                    )),
                RadioListTile(
                    activeColor: ColorApp.red,
                    contentPadding: EdgeInsets.zero,
                    value: 0,
                    groupValue: checkedVC,
                    title: Text('Shop tự vận chuyển',
                        style: StyleApp.textStyle400()),
                    onChanged: (val) {
                      checkedVC = val!;
                      setState(() {});
                    }),
                RadioListTile(
                    activeColor: ColorApp.red,
                    contentPadding: EdgeInsets.zero,
                    value: 1,
                    groupValue: checkedVC,
                    title: Text('Lấy sản phẩm tại cửa hàng',
                        style: StyleApp.textStyle400()),
                    onChanged: (val) {
                      checkedVC = val!;
                      setState(() {});
                    })
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            decoration:
                BoxDecoration(border: Border.all(color: Colors.black12)),
            width: double.infinity,
            child: Column(
              children: [
                Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        border:
                            Border(bottom: BorderSide(color: Colors.black12))),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          FaIcon(
                            FontAwesomeIcons.magnifyingGlassDollar,
                            color: ColorApp.red,
                          ),
                          Text(
                            '    Hình thức thanh toán',
                            style: StyleApp.textStyle700(fontSize: 14),
                          ),
                        ],
                      ),
                    )),
                RadioListTile(
                    activeColor: ColorApp.red,
                    contentPadding: EdgeInsets.zero,
                    value: 0,
                    groupValue: checkedTT,
                    title:
                        Text('Thanh toán COD', style: StyleApp.textStyle400()),
                    onChanged: (val) {
                      checkedTT = val!;
                      setState(() {});
                    }),
                RadioListTile(
                    activeColor: ColorApp.red,
                    contentPadding: EdgeInsets.zero,
                    value: 1,
                    groupValue: checkedTT,
                    title: Text('Thanh toán chuyển khoản',
                        style: StyleApp.textStyle400()),
                    onChanged: (val) {
                      checkedTT = val!;
                      setState(() {});
                    })
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          checkedTT == 1
              ? Container(
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.black12)),
                  width: double.infinity,
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Column(
                      children: [
                        Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(color: Colors.black12))),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Thông tin tài khoản hưởng',
                                style: StyleApp.textStyle700(fontSize: 14),
                              ),
                            )),
                        Table(
                          columnWidths: const {
                            0: FlexColumnWidth(5),
                            1: FlexColumnWidth(5),
                          },
                          children: [
                            TableRow(children: [
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                        'Tên ngân hàng',
                                        style: StyleApp.textStyle400(),
                                      ),
                                    )
                                  ]),
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text('Vietcomabnk',
                                          style: StyleApp.textStyle500(
                                              color: ColorApp.red)),
                                    )
                                  ]),
                            ]),
                            TableRow(children: [
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                        'Chi nhánh',
                                        style: StyleApp.textStyle400(),
                                      ),
                                    )
                                  ]),
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text('Thanh xuân, Hà Nội',
                                          style: StyleApp.textStyle500(
                                              color: ColorApp.red)),
                                    )
                                  ]),
                            ]),
                            TableRow(children: [
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                        'Tên chủ tài khoản',
                                        style: StyleApp.textStyle400(),
                                      ),
                                    )
                                  ]),
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text('Trần Thị Nhung',
                                          style: StyleApp.textStyle500(
                                              color: ColorApp.red)),
                                    )
                                  ]),
                            ]),
                            TableRow(children: [
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                        'Số tài khoản',
                                        style: StyleApp.textStyle400(),
                                      ),
                                    )
                                  ]),
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text('00110004250754',
                                          style: StyleApp.textStyle500(
                                              color: ColorApp.red)),
                                    )
                                  ]),
                            ]),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Divider(),
                        SizedBox(
                          height: 20,
                        ),
                        Table(
                          columnWidths: const {
                            0: FlexColumnWidth(5),
                            1: FlexColumnWidth(5),
                          },
                          children: [
                            TableRow(children: [
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                        'Tên ngân hàng',
                                        style: StyleApp.textStyle400(),
                                      ),
                                    )
                                  ]),
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text('Vietcomabnk',
                                          style: StyleApp.textStyle500(
                                              color: ColorApp.red)),
                                    )
                                  ]),
                            ]),
                            TableRow(children: [
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                        'Chi nhánh',
                                        style: StyleApp.textStyle400(),
                                      ),
                                    )
                                  ]),
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text('Thanh xuân, Hà Nội',
                                          style: StyleApp.textStyle500(
                                              color: ColorApp.red)),
                                    )
                                  ]),
                            ]),
                            TableRow(children: [
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                        'Tên chủ tài khoản',
                                        style: StyleApp.textStyle400(),
                                      ),
                                    )
                                  ]),
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text('Trần Thị Nhung',
                                          style: StyleApp.textStyle500(
                                              color: ColorApp.red)),
                                    )
                                  ]),
                            ]),
                            TableRow(children: [
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                        'Số tài khoản',
                                        style: StyleApp.textStyle400(),
                                      ),
                                    )
                                  ]),
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text('00110004250754',
                                          style: StyleApp.textStyle500(
                                              color: ColorApp.red)),
                                    )
                                  ]),
                            ]),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              : SizedBox(),
          BlocBuilder<BlocCartLocal, StateBloc>(
              builder: (_, StateBloc state) {
                if (state is LoadSuccess) {
                  List<ModelSanPhamMain> list = state.data;
                  List<String> idList = [];
                  for (var item in list) {
                    idList.add(item.id ?? '');
                    sum += int.parse(item.price ?? '0') % 2;
                  }

                  Map<String, int> count = {};
                  idList.forEach((i) => count[i] = (count[i] ?? 0) + 1);
                  print(count.toString());

                  return ListView.builder(
                    itemBuilder: (context, index) {
                      Bloc_infoPrd bloc_infoPrd = Bloc_infoPrd();
                      bloc_infoPrd
                          .add(GetData(param: '${count.keys.toList()[index]}'));

                      return BlocBuilder(
                        builder: (_, StateBloc state) {
                          if (state is LoadSuccess) {
                            ModelSanPhamMain model = state.data;

                            return Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      border:
                                      Border.all(color: ColorApp.grey4F)),
                                  child: Padding(
                                    padding: EdgeInsets.only(right: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        LoadImage(
                                          url: '${model.imageDetailUrls![0]}',
                                          height: MediaQuery.of(context)
                                              .size
                                              .width *
                                              0.235,

                                          fit: BoxFit.fitWidth,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: 10,
                                            ),
                                            SizedBox(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                    0.57,
                                                child: Text(
                                                  '${list[index].name}',
                                                  style:
                                                  StyleApp.textStyle700(),
                                                )),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  '${model.price} đ',
                                                  style: StyleApp.textStyle700(
                                                      color: ColorApp.red,
                                                      fontSize: 16),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  '${model.priceBeforeDiscount} đ',
                                                  style: StyleApp.textStyle700(
                                                      color: ColorApp.grey4F,
                                                      fontSize: 14,
                                                      decoration: TextDecoration
                                                          .lineThrough),
                                                )
                                              ],
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(),
                                    Row(
                                      children: [
                                        Text(
                                          'Sô lượng:   ',
                                          style: StyleApp.textStyle500(),
                                        ),
                                        BlocListener(
                                          listener: (_, StateBloc state) {
                                            if (state is LoadSuccess) {
                                              context
                                                  .read<BlocCartLocal>()
                                                  .add(GetCart());
                                            }
                                          },
                                          bloc: blocCartLocal,
                                          child: InkWell(
                                            onTap: () {
                                              blocCartLocal.add(AddData(
                                                  modelSanPhamMain: model));
                                            },
                                            child: Container(
                                              height: 35,
                                              width: 35,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: ColorApp.grey4F)),
                                              child: Icon(Icons.add),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: 35,
                                          width: 35,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: ColorApp.grey4F)),
                                          child: Center(
                                              child: Text(
                                                  '${count.values.toList()[index]}')),
                                        ),
                                        BlocListener(
                                          listener: (_, StateBloc state) {
                                            if (state is LoadSuccess) {
                                              context
                                                  .read<BlocCartLocal>()
                                                  .add(GetCart());
                                            }
                                          },
                                          bloc: blocCartLocal,
                                          child: InkWell(
                                            onTap: () {
                                              blocCartLocal.add(Reduce(
                                                  modelSanPhamMain: model));
                                            },
                                            child: Container(
                                              height: 35,
                                              width: 35,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: ColorApp.grey4F)),
                                              child: Icon(Icons.remove),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                              ],
                            );
                          }
                          return SizedBox();
                        },
                        bloc: bloc_infoPrd,
                      );
                    },
                    itemCount: count.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                  );
                }
                return SizedBox();
              }),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Tổng',
                style: StyleApp.textStyle400(),
              ),
              BlocBuilder<BlocCartLocal, StateBloc>(
                  builder: (_, StateBloc state) {
                    if (state is LoadSuccess) {
                      int tong = state.data2;
                      return Text(
                        '${tong}đ',
                        style: StyleApp.textStyle700(color: ColorApp.red),
                      );
                    }
                    return Text(
                      '0đ',
                      style: StyleApp.textStyle700(color: ColorApp.red),
                    );
                  }),
            ],
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Phí vận chuyển',
                style: StyleApp.textStyle400(),
              ),
              Text(
                '2.730.000đ',
                style: StyleApp.textStyle700(color: ColorApp.red),
              ),
            ],
          ),
          Divider(),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
                border: Border.all(), borderRadius: BorderRadius.circular(20)),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(
                        color: mau ? ColorApp.red : Colors.black12,
                        borderRadius:
                            BorderRadius.horizontal(left: Radius.circular(20))
                        // borderRadius: BorderRadius.only(topLeft:Radius.circular(20),bottomLeft:Radius.circular(20) )
                        ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        'MÃ GIẢM GIÁ',
                        textAlign: TextAlign.center,
                        style: StyleApp.textStyle700(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                Expanded(
                    flex: 1,
                    child: SizedBox(
                      width: double.infinity,
                    ))
              ],
            ),
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Thành tiền',
                style: StyleApp.textStyle400(),
              ),
              Text(
                '2.730.000đ',
                style: StyleApp.textStyle700(color: ColorApp.red),
              ),
            ],
          ),
          SizedBox(
            height: 50,
          )
        ]),
      )),
      bottomSheet: Container(
        height: MediaQuery.of(context).size.height * 0.06,
        decoration: BoxDecoration(border: Border.all(), color: ColorApp.red),
        child: InkWell(
          onTap: () {

          },
          child: Container(
            child: Center(
                child: Text(
              'THANH TOÁN',
              style: StyleApp.textStyle700(color: Colors.white),
            )),
          ),
        ),
      ),
    );
  }
}
