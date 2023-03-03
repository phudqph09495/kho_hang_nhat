import 'package:flutter/material.dart';

import '../../styles/init_style.dart';
import '../home/detail_lichSu.dart';

class LichSuDatHang extends StatefulWidget {
  const LichSuDatHang({Key? key}) : super(key: key);

  @override
  State<LichSuDatHang> createState() => _LichSuDatHangState();
}

class _LichSuDatHangState extends State<LichSuDatHang> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
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
                  bottom: 5,
                  top: MediaQuery.of(context).size.height * 0.05),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(

                          ),
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
                          'Lịch sử đặt hàng',
                          style: StyleApp.textStyle500(
                              color: Colors.white, fontSize: 18),
                        ),
                      )),
                  InkWell(
                    child: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
          )),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              itemBuilder: (context, index) {
                return   Padding(padding: EdgeInsets.symmetric(vertical: 5),
                  child: InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>InfoLichSU()));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all()
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Mã đơn hàng : KHNMDH121233545',style: StyleApp.textStyle400(),),
                            Text(''),
                            Text('Ngày tạo: 2023-02-15 10:15:25',style: StyleApp.textStyle400(),),
                            Text(''),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text('Tổng tiền: ',style: StyleApp.textStyle400(),),
                                    Text('215.000đ',style: StyleApp.textStyle400(color: ColorApp.red),)
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text('Trạng thái: ',style: StyleApp.textStyle400(),),
                                    Text('Chờ xử lý',style: StyleApp.textStyle400(color: ColorApp.red),)
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),);
              },
              shrinkWrap: true,
              itemCount: 20,
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
            )
          ],
        ),
      ),
    );
  }
}
