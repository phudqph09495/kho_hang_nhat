import 'package:flutter/material.dart';
import 'package:kho_hang_nhat/screen/home/thanhtoan_screen.dart';

import '../../styles/init_style.dart';
import '../home.dart';

class GioHangScreen extends StatefulWidget {
  @override
  State<GioHangScreen> createState() => _GioHangScreenState();
}

class _GioHangScreenState extends State<GioHangScreen> {
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
                          'Giỏ hàng',
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
        child: Column(
          children: [
            ListView.builder(
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
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
                                child: Center(child: Text('3')),
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
            SizedBox(height: MediaQuery.of(context).size.height * 0.15,)
          ],
        ),
      ),
      bottomSheet: Container(
        height: MediaQuery.of(context).size.height * 0.13,
        decoration: BoxDecoration(border: Border.all(), color: ColorApp.red),
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.06,
              decoration: BoxDecoration(
                  color: Colors.white, border: Border(bottom: BorderSide())),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Tổng',
                      style: StyleApp.textStyle500(),
                    ),
                    Text(
                      '2.743.000đ',
                      style: StyleApp.textStyle700(color: ColorApp.red),
                    )
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ThanhToanScreen()));
              },
              child: Container(
                height: MediaQuery.of(context).size.height * 0.06,
                child: Center(
                    child: Text(
                  'THANH TOÁN',
                  style: StyleApp.textStyle700(color: Colors.white),
                )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
