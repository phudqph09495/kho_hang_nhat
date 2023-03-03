import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kho_hang_nhat/widget/item/load_image.dart';

import '../../model/model_productMain.dart';
import '../../styles/init_style.dart';
import '../home/info_product.dart';

class ProductItem extends StatefulWidget {
  double borderW;
  ModelSanPhamMain modelSanPhamMain;
  ProductItem({this.borderW = 1, required this.modelSanPhamMain});

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => InfoProductScreen(id: '${widget.modelSanPhamMain.id}',)));
      },
      child: Container(
          decoration: BoxDecoration(border: Border.all(color: ColorApp.grey4F)),
          child: Column(
            children: [
              Stack(
                alignment: Alignment.topLeft,
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: widget.borderW,
                            color: ColorApp.red,
                            strokeAlign: BorderSide.strokeAlignOutside)),
                    // child: Image.asset(
                    //
                    //   'assets/images/exp.jpg',
                    //
                    //   height: MediaQuery.of(context).size.height*0.2
                    //   ,fit: BoxFit.fill,
                    // ),
                    child: LoadImage(
                      url: '${widget.modelSanPhamMain.imageMainUrl}',
                      height: MediaQuery.of(context).size.height * 0.2,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: ColorApp.red,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20),
                            bottomRight: Radius.circular(20))),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                      child: Text(
                        (100- (double.parse('${widget.modelSanPhamMain.price}') *
                            100 /
                            double.parse(
                                '${widget.modelSanPhamMain.priceBeforeDiscount}'))
                            .round())
                            .toString()+'%',
                        style: StyleApp.textStyle500(
                            color: Colors.white, fontSize: 14),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: Text(
                        '${widget.modelSanPhamMain.name}',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: StyleApp.textStyle700(),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${NumberFormat("###,###.###", 'vi_VN').format(int.parse(widget.modelSanPhamMain.price ?? ''))}đ',
                          style: StyleApp.textStyle600(
                              color: ColorApp.red, fontSize: 16),
                        ),
                        Text(
                          '${NumberFormat("###,###.###", 'vi_VN').format(int.parse(widget.modelSanPhamMain.priceBeforeDiscount ?? ''))}đ',
                          style: StyleApp.textStyle600(
                              color: ColorApp.grey4F.withOpacity(0.5),
                              fontSize: 14,
                              decoration: TextDecoration.lineThrough),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          )),
    );
  }
}
