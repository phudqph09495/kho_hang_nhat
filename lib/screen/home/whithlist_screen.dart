import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kho_hang_nhat/bloc/cart/bloc_cart.dart';
import 'package:kho_hang_nhat/bloc/cart/event_bloc2.dart';
import 'package:kho_hang_nhat/bloc/event_bloc.dart';
import 'package:kho_hang_nhat/screen/account/login_screen.dart';
import 'package:kho_hang_nhat/screen/home/thanhtoan_screen.dart';

import '../../bloc/auth/bloc_profile.dart';
import '../../bloc/product/bloc_infoPrd.dart';
import '../../bloc/state_bloc.dart';
import '../../config/share_pref.dart';
import '../../model/model_productMain.dart';
import '../../styles/init_style.dart';
import '../../widget/item/load_image.dart';
import '../home.dart';

class GioHangScreen extends StatefulWidget {
  @override
  State<GioHangScreen> createState() => _GioHangScreenState();
}

class _GioHangScreenState extends State<GioHangScreen> {

  BlocProfile blocProfile = BlocProfile();
  int sum = 0;
  BlocCartLocal blocCartLocal = BlocCartLocal();
  Bloc_infoPrd bloc = Bloc_infoPrd();

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
        child: Column(
          children: [
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

                          return Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
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
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.3,
                                          fit: BoxFit.fitHeight,
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
                                                  '${model.price}',
                                                  style: StyleApp.textStyle700(
                                                      color: ColorApp.red,
                                                      fontSize: 16),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  '${model.priceBeforeDiscount}',
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
                                )
                              ],
                            ),
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
              height: MediaQuery.of(context).size.height * 0.15,
            )
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
              ),
            ),
            BlocListener(
              bloc: blocProfile,
              listener: (_, StateBloc state) {
                if (state is LoadSuccess) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ThanhToanScreen()));
                }
                if (state is LoadFail) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Bạn phải đăng nhập để mua hàng'),
                      ],
                    ),
                    backgroundColor: Colors.green,
                    padding: EdgeInsets.zero,
                  ));

                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                }
              },
              child: InkWell(
                onTap: () async {
                  blocProfile.add(GetData());
                },
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.06,
                  child: Center(
                      child: Text(
                    'THANH TOÁN',
                    style: StyleApp.textStyle700(color: Colors.white),
                  )),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
