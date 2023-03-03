import 'package:flutter/material.dart';

import '../../styles/init_style.dart';
import '../home.dart';

class KetQuaScreen extends StatefulWidget {
  const KetQuaScreen({Key? key}) : super(key: key);

  @override
  State<KetQuaScreen> createState() => _KetQuaScreenState();
}

class _KetQuaScreenState extends State<KetQuaScreen> {
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
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.black12)),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(color: Colors.black12))),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Hình thức thanh toán',
                            style: StyleApp.textStyle700(fontSize: 14),
                          ),
                        )),
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Thanh toán COD',
                          style: StyleApp.textStyle400(
                            color: Colors.black87,
                          ),
                        ))
                  ],
                ),
              ),
              SizedBox(
                height: 35,
              ),
              Text(
                'Mã đơn hàng : KHMAFG14252641',
                style: StyleApp.textStyle500(color: Colors.black87),
              ),
              Text(
                'Thời gian giao dịch : 10:04:30 23/02/2023',
                style: StyleApp.textStyle500(color: Colors.black87),
              ),
              Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 50,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'GIAO DỊCH THÀNH CÔNG',
                style: StyleApp.textStyle500(color: ColorApp.red, fontSize: 16),
              ),
              SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>MyHomePage()));
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  decoration: BoxDecoration(color: ColorApp.blue3D),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(),
                        Row(
                          children: [
                            Icon(
                              Icons.shopping_cart_outlined,
                              color: Colors.white,
                            ),
                            Text(
                              ' Tiếp tục mua sắm',
                              style: StyleApp.textStyle500(
                                  color: Colors.white, fontSize: 14),
                            ),
                          ],
                        ),
                        SizedBox()
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
