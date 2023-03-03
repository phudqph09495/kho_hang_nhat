import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kho_hang_nhat/bloc/event_bloc.dart';
import 'package:kho_hang_nhat/model/model_flash.dart';

import '../../bloc/product/bloc_flash.dart';
import '../../bloc/state_bloc.dart';
import '../../styles/init_style.dart';
import '../item/product_item.dart';

class FlashScreen extends StatefulWidget {
  String param;
  FlashScreen({required this.param});

  @override
  State<FlashScreen> createState() => _FlashScreenState();
}

class _FlashScreenState extends State<FlashScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  BlocFlashSale blocFlashSale = BlocFlashSale();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    blocFlashSale.add(GetData(param: widget.param));
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
                          'Flash sale',
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
          child: BlocBuilder(
        builder: (_, StateBloc state) {

          if(state is LoadSuccess){
            ModelFlash modelFlash=state.data;
            return GridView.builder(
              padding: EdgeInsets.all(10),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  mainAxisExtent: MediaQuery.of(context).size.height * 0.32),
              itemBuilder: (context, index) {
                return ProductItem(modelSanPhamMain: modelFlash.items![index],);

              },
              itemCount: 10,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
            );
          }
          if(state is Loading){
            return Center(child: Text('Đang tải danh sách sản phẩm',style: StyleApp.textStyle500(),),);
          }
          return SizedBox();
        },
        bloc: blocFlashSale,
      )),
    );
  }
}
