import 'package:flutter/material.dart';

import '../../styles/init_style.dart';
import '../home.dart';

class InfoLichSU extends StatefulWidget {
  const InfoLichSU({Key? key}) : super(key: key);

  @override
  State<InfoLichSU> createState() => _InfoLichSUState();
}

class _InfoLichSUState extends State<InfoLichSU> {
  int checkedVC = 0;
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
                          'Đơn hàng: KH0142578111',
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
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(border: Border.all()),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration:
                          BoxDecoration(border: Border(bottom: BorderSide())),
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          'Thông tin giao hàng',
                          style: StyleApp.textStyle600(),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '0387270088 | 0387270088',
                            style: StyleApp.textStyle500(color: Colors.black54),
                          ),
                          Text(
                            'asfa shfuash fuhasufhu ashfu ahfu iasdhbf uihsdu  ifhsduif asdfh asdasdfas ifjasofh',
                            style: StyleApp.textStyle500(color: Colors.black54),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                decoration: BoxDecoration(border: Border.all()),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration:
                          BoxDecoration(border: Border(bottom: BorderSide())),
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          'Hình thức vận chuyển',
                          style: StyleApp.textStyle600(),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RadioListTile(
                              activeColor: ColorApp.red,
                              contentPadding: EdgeInsets.zero,
                              value: 0,
                              groupValue: checkedVC,
                              title: Text('Shop tự vận chuyển',
                                  style: StyleApp.textStyle400()),
                              onChanged: (val) {}),
                          RadioListTile(
                              activeColor: ColorApp.red,
                              contentPadding: EdgeInsets.zero,
                              value: 1,
                              groupValue: checkedVC,
                              title: Text('Lấy sản phẩm tại cửa hàng',
                                  style: StyleApp.textStyle400()),
                              onChanged: (val) {})
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              ListView.builder(
                itemBuilder: (context, index) {
                  return   Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Container(
                      padding: EdgeInsets.only(bottom: 10),
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
                                Text(
                                  '299.000đ',
                                  style: StyleApp.textStyle700(
                                      color: ColorApp.red, fontSize: 16),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Số lượng:',
                                      style: StyleApp.textStyle700(
                                          color: ColorApp.black00, fontSize: 14),
                                    ), Text(
                                      '1',
                                      style: StyleApp.textStyle700(
                                          color: ColorApp.red, fontSize: 14),
                                    ),
                                  ],
                                ),

                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
                shrinkWrap: true,
                itemCount: 2,
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
              SizedBox(
                height: 20,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [

                Text('Phí vận chuyển',style: StyleApp.textStyle400(),),
                Text('2.730.000đ',style: StyleApp.textStyle700(color: ColorApp.red),),
              ],),
              Divider(),
              SizedBox(
                height: 20,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [

                Text('Giảm giá',style: StyleApp.textStyle400(),),
                Text('2.730.000đ',style: StyleApp.textStyle700(color: ColorApp.red),),
              ],),
              Divider(),
              SizedBox(
                height: 20,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [

                Text('Thành tiền',style: StyleApp.textStyle400(),),
                Text('2.730.000đ',style: StyleApp.textStyle700(color: ColorApp.red),),
              ],),
              Divider(),
              SizedBox(
                height: 20,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [

                Text('Hình thức thanh toán',style: StyleApp.textStyle400(),),
                Text('Thanh toán chuyển khoản',style: StyleApp.textStyle700(color: ColorApp.red),),
              ],),
              Divider(),
              SizedBox(
                height: 20,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [

                Text('Ngày tạo',style: StyleApp.textStyle400(),),
                Text('2022-08-08 11:25:30',style: StyleApp.textStyle700(color: ColorApp.red),),
              ],),
              Divider(),
              SizedBox(
                height: 20,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [

                Text('Trạng thái',style: StyleApp.textStyle400(),),
                Text('Huỷ bỏ',style: StyleApp.textStyle700(color: ColorApp.red),),
              ],),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
