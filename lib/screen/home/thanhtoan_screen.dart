import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../styles/init_style.dart';
import 'dart:async';

import '../home.dart';
import 'ketQua_screen.dart';
class ThanhToanScreen extends StatefulWidget {
  const ThanhToanScreen({Key? key}) : super(key: key);

  @override
  State<ThanhToanScreen> createState() => _ThanhToanScreenState();
}

class _ThanhToanScreenState extends State<ThanhToanScreen> {
  List<String> tinh = [
    'Hà Nội',
    'Đà Nẵng',
    'TP Hồ Chí Minh',
    'TP Hồ Chí Minh',
    'TP Hồ Chí Minh',
    'TP Hồ Chí Minh',
    'TP Hồ Chí Minh',
    'TP Hồ Chí Minh',
    'TP Hồ Chí Minh',
    'TP Hồ Chí Minh',
    'TP Hồ Chí Minh',
    'TP Hồ Chí Minh',
    'TP Hồ Chí Minh',
    'TP Hồ Chí Minh',
    'TP Hồ Chí Minh',
    'TP Hồ Chí Minh',
    'TP Hồ Chí Minh',
    'TP Hồ Chí Minh',
    'TP Hồ Chí Minh',
    'TP Hồ Chí Minh',
    'TP Hồ Chí Minh',
    'TP Hồ Chí Minh',
    'TP Hồ Chí Minh',
    'TP Hồ Chí Minh',
    'TP Hồ Chí Minh',
    'TP Hồ Chí Minh',
    'TP Hồ Chí Minh',
    'TP Hồ Chí Minh',
    'TP Hồ Chí Minh',
    'TP Hồ Chí Minh',
    'TP Hồ Chí Minh',
    'TP Hồ Chí Minh',
    'TP Hồ Chí Minh',
    'TP Hồ Chí Minh',
    'TP Hồ Chí Minh',
    'TP Hồ Chí Minh',
    'TP Hồ Chí Minh',
    'TP Hồ Chí Minh',
    'TP Hồ Chí Minh',
    'TP Hồ Chí Minh',
    'TP Hồ Chí Minh',
    'TP Hồ Chí Minh',
    'TP Hồ Chí Minh'
  ];
  String tinhS = 'Chọn tỉnh/thành phố';
  String huyenS = 'Chọn quận/huyện';
  int checkedVC = 0;
  int checkedTT = 0;
  bool mau=true;
  late var timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    timer =   Timer.periodic(Duration(milliseconds: 500), (timer) {
      mau=!mau;
      setState(() {

      });
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
                      onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>MyHomePage()));},

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
                  Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('', style: TextStyle(fontSize: 20.0)),
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
                  Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('0387270088', style: StyleApp.textStyle400()),
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
                  Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('0387270088', style: StyleApp.textStyle400()),
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
                  Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: PopupMenuButton(
                          constraints: BoxConstraints.expand(
                              width: MediaQuery.of(context).size.width * 0.5,
                              height: 300),
                          padding: EdgeInsets.zero,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(),
                              Row(
                                children: [
                                  Text(tinhS),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                  ),
                                ],
                              )
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
                                          tinhS = tinh[index];
                                        });
                                      },
                                    ));
                          }),
                    )
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
                  Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: PopupMenuButton(
                          constraints: BoxConstraints.expand(
                              width: MediaQuery.of(context).size.width * 0.5,
                              height: 300),
                          padding: EdgeInsets.zero,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          }),
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Địa chỉ cụ thể',
                                style: StyleApp.textStyle400(),
                              ),
                              Text(
                                'Số nhà, tên toà nhà, tên đường tên khu vực',
                                style: StyleApp.textStyle400(fontSize: 12),
                              ),
                              TextFormField(
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
                  Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('', style: StyleApp.textStyle400()),
                    )
                  ]),
                ]),
              ],
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
                          border: Border(
                              bottom: BorderSide(color: Colors.black12))),
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
                          border: Border(
                              bottom: BorderSide(color: Colors.black12))),
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
                      title: Text('Thanh toán COD',
                          style: StyleApp.textStyle400()),
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
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black12)),
                    width: double.infinity,
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Column(
                        children: [
                          Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom:
                                          BorderSide(color: Colors.black12))),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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

            ListView.builder(
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: ColorApp.grey4F)),
                        child: Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(
                                'assets/images/exp.jpg',
                                height:
                                    MediaQuery.of(context).size.width * 0.235,
                                fit: BoxFit.fitHeight,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.57,
                                      child: Text(
                                        'Combo 3 chai sữa tắm Arau Baby túi (400ml x m)',
                                        style: StyleApp.textStyle700(),
                                      )),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        '299.000đ',
                                        style: StyleApp.textStyle700(
                                            color: ColorApp.red, fontSize: 16),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        '600.000đ',
                                        style: StyleApp.textStyle700(
                                            color: ColorApp.grey4F,
                                            fontSize: 14,
                                            decoration:
                                                TextDecoration.lineThrough),
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(),
                          Row(
                            children: [
                              Text(
                                'Sô lượng:   ',
                                style: StyleApp.textStyle500(),
                              ),
                              Container(
                                height: 35,
                                width: 35,
                                decoration: BoxDecoration(
                                    border: Border.all(color: ColorApp.grey4F)),
                                child: Icon(Icons.add),
                              ),
                              Container(
                                height: 35,
                                width: 35,
                                decoration: BoxDecoration(
                                    border: Border.all(color: ColorApp.grey4F)),
                                child: Center(child: Text('3',style: StyleApp.textStyle400(color: ColorApp.red),)),
                              ),
                              Container(
                                height: 35,
                                width: 35,
                                decoration: BoxDecoration(
                                    border: Border.all(color: ColorApp.grey4F)),
                                child: Icon(Icons.remove),
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                );
              },
              itemCount: 10,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
            ),
            SizedBox(
              height: 20,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [

              Text('Tổng',style: StyleApp.textStyle400(),),
              Text('2.730.000đ',style: StyleApp.textStyle700(color: ColorApp.red),),
            ],),
            Divider(),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [

              Text('Phí vận chuyển',style: StyleApp.textStyle400(),),
              Text('2.730.000đ',style: StyleApp.textStyle700(color: ColorApp.red),),
            ],),
            Divider(),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(20)
              ),
              child: Row(
                children: [
                  Expanded(flex: 1,
                    child: Container(

                      decoration: BoxDecoration(
                        color:mau ?ColorApp.red:Colors.black12,

                        borderRadius: BorderRadius.horizontal(left: Radius.circular(20))
                        // borderRadius: BorderRadius.only(topLeft:Radius.circular(20),bottomLeft:Radius.circular(20) )
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Text('MÃ GIẢM GIÁ',textAlign: TextAlign.center,style: StyleApp.textStyle700(color: Colors.white),),
                      ),
                    ),
                  ),
                  Expanded(flex: 1,child: SizedBox(width: double.infinity,))
                ],
              ),
            ),
            Divider(),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [

              Text('Thành tiền',style: StyleApp.textStyle400(),),
              Text('2.730.000đ',style: StyleApp.textStyle700(color: ColorApp.red),),
            ],),
            SizedBox(height: 50,)

          ]),
        )),
      bottomSheet: Container(
        height: MediaQuery.of(context).size.height*0.06,
        decoration: BoxDecoration(border: Border.all(),color: ColorApp.red),
        child: InkWell(
          onTap: (){
Navigator.push(context, MaterialPageRoute(builder: (context)=>KetQuaScreen()));
          },
          child: Container(

            child: Center(child: Text('THANH TOÁN',style: StyleApp.textStyle700(color: Colors.white),)),
          ),
        ),
      ),
    );
  }
}
