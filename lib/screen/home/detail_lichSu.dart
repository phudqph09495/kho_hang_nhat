import 'package:flutter/material.dart';
import 'package:kho_hang_nhat/model/model_lichSu.dart';
import 'package:kho_hang_nhat/widget/item/load_image.dart';

import '../../styles/init_style.dart';
import '../home.dart';

class InfoLichSU extends StatefulWidget {
LichSu lichSu;
InfoLichSU({required this.lichSu});

  @override
  State<InfoLichSU> createState() => _InfoLichSUState();
}

class _InfoLichSUState extends State<InfoLichSU> {
  int checkedVC =0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkedVC=widget.lichSu.shippingMethod=='SHOP_SHIP'?0:1;
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
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: Center(
                        child: Text(
                          'Đơn hàng: ${widget.lichSu.code}',
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
                            '${widget.lichSu.deliveryInfo!.name} | ${widget.lichSu.deliveryInfo!.phone}',
                            style: StyleApp.textStyle500(color: Colors.black54),
                          ),
                          Text(
                            '${widget.lichSu.deliveryInfo!.location!.address} - ${widget.lichSu.deliveryInfo!.location!.district!.name} - ${widget.lichSu.deliveryInfo!.location!.region!.name}',
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
                            LoadImage(
                              url:'${widget.lichSu.products![index].imageMainUrl}',
                              height:
                              MediaQuery.of(context).size.width * 0.235,
                              fit: BoxFit.fitWidth,
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
                                      '${widget.lichSu.products![index].name}',
                                      style: StyleApp.textStyle700(),
                                    )),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  '${widget.lichSu.products![index].price}',
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
                                      '${widget.lichSu.products![index].qty}',
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
                itemCount: widget.lichSu.products!.length,
                physics: NeverScrollableScrollPhysics(),
              ),
              SizedBox(
                height: 20,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [

                Text('Tổng',style: StyleApp.textStyle400(),),
                Text('${widget.lichSu.subtotal}',style: StyleApp.textStyle700(color: ColorApp.red),),
              ],),
              Divider(),
              SizedBox(
                height: 20,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [

                Text('Phí vận chuyển',style: StyleApp.textStyle400(),),
                Text('${widget.lichSu.shippingFee}',style: StyleApp.textStyle700(color: ColorApp.red),),
              ],),
              Divider(),
              SizedBox(
                height: 20,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [

                Text('Giảm giá',style: StyleApp.textStyle400(),),
                Text('${widget.lichSu.promotionDiscount}',style: StyleApp.textStyle700(color: ColorApp.red),),
              ],),
              Divider(),
              SizedBox(
                height: 20,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [

                Text('Thành tiền',style: StyleApp.textStyle400(),),
                Text('${widget.lichSu!.total}',style: StyleApp.textStyle700(color: ColorApp.red),),
              ],),
              Divider(),
              SizedBox(
                height: 20,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [

                Text('Hình thức thanh toán',style: StyleApp.textStyle400(),),
                Text('${widget.lichSu.paymentMethod}',style: StyleApp.textStyle700(color: ColorApp.red),),
              ],),
              Divider(),
              SizedBox(
                height: 20,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [

                Text('Ngày tạo',style: StyleApp.textStyle400(),),
                Text('${widget.lichSu.createdAt}',style: StyleApp.textStyle700(color: ColorApp.red),),
              ],),
              Divider(),
              SizedBox(
                height: 20,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [

                Text('Trạng thái',style: StyleApp.textStyle400(),),
                Text('${widget.lichSu.statusText}',style: StyleApp.textStyle700(color: ColorApp.red),),
              ],),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
