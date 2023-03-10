import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:kho_hang_nhat/screen/home/whithlist_screen.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../bloc/cart/bloc_cart.dart';
import '../../bloc/cart/event_bloc2.dart';
import '../../bloc/event_bloc.dart';
import '../../bloc/product/bloc_infoPrd.dart';
import '../../bloc/product/bloc_prdRelate.dart';
import '../../bloc/state_bloc.dart';
import '../../model/model_flash.dart';
import '../../model/model_productMain.dart';
import '../../styles/init_style.dart';
import '../../widget/app_bar.dart';
import '../../widget/item/input/text_filed.dart';
import '../../widget/item/load_image.dart';
import '../home.dart';
import '../item/product_item.dart';

class InfoProductScreen extends StatefulWidget {
  String id;
  InfoProductScreen({required this.id});
  @override
  State<InfoProductScreen> createState() => _InfoProductScreenState();
}

class _InfoProductScreenState extends State<InfoProductScreen>
    with TickerProviderStateMixin {
  TabController? _tabController;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Color colorFav = Colors.grey;
  Bloc_infoPrd bloc_infoPrd = Bloc_infoPrd();
  BlocRelatePrd blocRelatePrd = BlocRelatePrd();
  int tab = 0;
  BlocCartLocal blocCartLocal = BlocCartLocal();
  ModelSanPhamMain model = ModelSanPhamMain();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    bloc_infoPrd.add(GetData(param: '${widget.id}'));
    blocRelatePrd.add(GetData(param: '${widget.id}'));
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
                        child: BlocBuilder(
                          builder: (_, StateBloc state) {
                            if (state is LoadSuccess) {
                              ModelSanPhamMain model = state.data;
                              return Text(
                                '${model.name}',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: StyleApp.textStyle500(
                                    color: Colors.white, fontSize: 18),
                              );
                            }
                            return SizedBox();
                          },
                          bloc: bloc_infoPrd,
                        ),
                      )),
                  Stack(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => GioHangScreen()));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Icon(
                            Icons.shopping_cart_outlined,
                            color: Colors.white,
                            size: 25,
                          ),
                        ),
                      ),
                      Positioned(
                          bottom: -3,
                          right: 0,
                          child: Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: Colors.white),
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: BlocBuilder<BlocCartLocal, StateBloc>(
                                builder: (context, StateBloc state) {
                                  List<ModelSanPhamMain> list =
                                      state is LoadSuccess ? state.data : [];
                                  List<String> idList = [];
                                  for (var item in list) {
                                    idList.add(item.id ?? '');
                                  }
                                  List<String> duplicateElements =
                                      idList.toSet().toList();
                                  return Text(
                                      duplicateElements.length.toString(),
                                      style: StyleApp.textStyle500(
                                          color: Colors.red, fontSize: 12));
                                },
                              ),
                            ),
                          ))
                    ],
                  )
                ],
              ),
            ),
          )),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocBuilder(
              builder: (_, StateBloc state) {
                if (state is LoadSuccess) {
                  model = state.data;
                  int sum = 0;
                  double star = 0;
                  if (model.rate!.length > 0) {
                    for (int i = 0; i < model.rate!.length; i++) {
                      sum = sum + int.parse(model.rate![i].star ?? '');
                    }
                    star = sum / model.rate!.length;
                  }

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(bottom: 20),
                            child: ImageSlideshow(
                              children: List.generate(
                                  model.imageDetailUrls!.length,
                                  (index) => LoadImage(
                                        url: '${model.imageDetailUrls![index]}',
                                        width:
                                            MediaQuery.of(context).size.width,
                                      )),
                              // [
                              indicatorColor: model.imageDetailUrls!.length > 1
                                  ? Colors.red
                                  : Colors.transparent,
                              isLoop: model.imageDetailUrls!.length > 1,
                              autoPlayInterval: 2000,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50)),
                                child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(3),
                                      child: Icon(
                                        Icons.share_outlined,
                                        color: Colors.grey,
                                      ),
                                    )),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    colorFav = ColorApp.red;
                                  });
                                },
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50)),
                                  child: Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(3),
                                        child: Icon(
                                          Icons.favorite_outline,
                                          color: colorFav,
                                        ),
                                      )),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text('${model.name}',
                                      style: StyleApp.textStyle700()),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: ExactAssetImage(
                                              'assets/images/giam.png'),
                                          fit: BoxFit.fill)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Text(
                                          (100 -
                                                      (double.parse(
                                                                  '${model.price}') *
                                                              100 /
                                                              double.parse(
                                                                  '${model.priceBeforeDiscount}'))
                                                          .round())
                                                  .toString() +
                                              '%',
                                          style: StyleApp.textStyle700(
                                              color: ColorApp.red),
                                        ),
                                        Text(
                                          'GIẢM',
                                          style: StyleApp.textStyle700(
                                              color: Colors.white),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  '${NumberFormat("###,###.###", 'vi_VN').format(int.parse(model.price ?? ''))}đ',
                                  style: StyleApp.textStyle700(
                                      color: ColorApp.red),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  '${NumberFormat("###,###.###", 'vi_VN').format(int.parse(model.priceBeforeDiscount ?? ''))}đ',
                                  style: StyleApp.textStyle700(
                                      color: Colors.grey,
                                      decoration: TextDecoration.lineThrough),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    RatingBarIndicator(
                                      rating: star,
                                      itemBuilder: (context, index) => Icon(
                                        Icons.star,
                                        color: ColorApp.red,
                                      ),
                                      itemCount: 5,
                                      itemSize: 20.0,
                                      direction: Axis.horizontal,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      '${model.soldCount} đã bán',
                                      style: StyleApp.textStyle400(
                                          color: Colors.grey),
                                    )
                                  ],
                                ),
                                model.isStock == '1'
                                    ? Text(
                                        'Còn hàng',
                                        style: StyleApp.textStyle600(
                                            color: Colors.green),
                                      )
                                    : Text(
                                        'Hết hàng',
                                        style: StyleApp.textStyle600(
                                            color: Colors.red),
                                      )
                              ],
                            ),
                            Divider(
                              color: Colors.black,
                            ),
                          ],
                        ),
                      ),
                      TabBar(
                        controller: _tabController,
                        onTap: (value) {
                          print(value);
                          tab = value;
                          setState(() {});
                        },
                        labelPadding: EdgeInsets.symmetric(horizontal: 30),
                        labelStyle: StyleApp.textStyle700(fontSize: 16),
                        indicatorColor: ColorApp.red,
                        unselectedLabelStyle:
                            StyleApp.textStyle500(fontSize: 14),
                        labelColor: ColorApp.red,
                        unselectedLabelColor: ColorApp.black49,
                        tabs: <Widget>[
                          Tab(
                            child: Text(
                              'Chi tiết',
                            ),
                          ),
                          Tab(
                            child: Text('Bình Luận'),
                          ),
                        ],
                      ),
                      tab == 0
                          ? Html(
                              data: '${model.description}',
                              // onLinkTap:(url, context, attributes, element) {
                              //
                              //   print(attributes['href']);
                              //
                              // },
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Text(
                                    'ĐÁNH GIÁ BÌNH LUẬN',
                                    style: StyleApp.textStyle700(),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Column(
                                  children: [
                                    Text(
                                      'Đánh giá của bạn',
                                      style: StyleApp.textStyle700(),
                                    ),
                                    RatingBar.builder(
                                      itemCount: 5,
                                      itemBuilder: (context, index) => Icon(
                                        Icons.star,
                                        color: ColorApp.red,
                                      ),
                                      onRatingUpdate: (rating) {
                                        print(rating);
                                      },
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Container(
                                      color: Colors.grey.withOpacity(0.5),
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            left: 10,
                                            right: 10,
                                            top: 10,
                                            bottom: 5),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Bình luận của bạn',
                                              style: StyleApp.textStyle700(),
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            Container(
                                                decoration: BoxDecoration(
                                                    border: Border.all()),
                                                child: TextFormField(
                                                  maxLines: 2,
                                                  decoration: InputDecoration(
                                                      hintText:
                                                          '  Nhập bình luận',
                                                      hintStyle:
                                                          StyleApp.textStyle400(
                                                              fontSize: 16)),
                                                )),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                SizedBox(),
                                                InkWell(
                                                  onTap: () {},
                                                  child: Container(
                                                    color: ColorApp.red,
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 20,
                                                          vertical: 10),
                                                      child: Text(
                                                        'Gửi',
                                                        style: StyleApp
                                                            .textStyle700(
                                                                color: Colors
                                                                    .white),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    model.rate!.length > 0
                                        ? ListView.builder(
                                            itemBuilder: (context, index) {
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 10,
                                                        horizontal: 10),
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    ClipOval(
                                                        child: LoadImage(
                                                      url:
                                                          '${model.rate![index].customerAvatar}',
                                                      height: 50,
                                                      width: 50,
                                                      fit: BoxFit.cover,
                                                      bangtin: true,
                                                    )),
                                                    const SizedBox(
                                                      width: 20,
                                                    ),
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            '${model.rate![index].customerName}',
                                                            style: StyleApp
                                                                .textStyle700(),
                                                          ),
                                                          RatingBarIndicator(
                                                            rating: double.parse(
                                                                '${model.rate![index].star}'),
                                                            itemBuilder:
                                                                (context,
                                                                        index) =>
                                                                    Icon(
                                                              Icons.star,
                                                              color:
                                                                  ColorApp.red,
                                                            ),
                                                            itemCount: 5,
                                                            itemSize: 20.0,
                                                            direction:
                                                                Axis.horizontal,
                                                          ),
                                                          Text(
                                                            '${model.rate![index].content}',
                                                            style: StyleApp
                                                                .textStyle500(),
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              );
                                            },
                                            shrinkWrap: true,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemCount: model.rate!.length,
                                          )
                                        : SizedBox(),
                                  ],
                                )
                              ],
                            ),
                    ],
                  );
                }

                return SizedBox();
              },
              bloc: bloc_infoPrd,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Divider(),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                'Sản phẩm liên quan',
                style: StyleApp.textStyle700(),
              ),
            ),
            BlocBuilder(
              builder: (_, StateBloc state) {
                if (state is LoadSuccess) {
                  ModelFlash model = state.data;
                  return Container(
                    height: MediaQuery.of(context).size.height * 0.35,
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return Container(
                          width: MediaQuery.of(context).size.width * 0.48,
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: ProductItem(
                              borderW: 2,
                              modelSanPhamMain: model.items![index],
                            ),
                          ),
                        );
                      },
                      physics: AlwaysScrollableScrollPhysics(),
                      itemCount: 10,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                    ),
                  );
                }
                return SizedBox();
              },
              bloc: blocRelatePrd,
            ),
            SizedBox(
              height: 50,
            )
          ],
        ),
      ),
      bottomSheet: Row(
        children: [
          Container(
            width: MediaQuery.of(context).size.width / 3,
            decoration: BoxDecoration(border: Border.all(color: ColorApp.red)),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FaIcon(
                    FontAwesomeIcons.commentDots,
                    color: ColorApp.red,
                  ),
                  Text(
                    'CHAT NGAY',
                    style: StyleApp.textStyle600(color: ColorApp.red),
                  )
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => GioHangScreen()));
            },
            child: Container(
              width: MediaQuery.of(context).size.width / 3,
              decoration: BoxDecoration(
                  border: Border.all(color: ColorApp.red), color: ColorApp.red),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(
                      Icons.shopping_cart_outlined,
                      color: Colors.white,
                    ),
                    Text(
                      'MUA NGAY',
                      style: StyleApp.textStyle600(color: Colors.white),
                    )
                  ],
                ),
              ),
            ),
          ),
          BlocListener(
            bloc: blocCartLocal,
            listener: (_, StateBloc state) {
              if (state is LoadSuccess) {
                context.read<BlocCartLocal>().add(GetCart());
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Thêm vào giỏ hàng thành công'),
                    ],
                  ),
                  backgroundColor: Colors.green,
                  padding: EdgeInsets.zero,
                ));
              }
            },
            child: InkWell(
              onTap: () {
                blocCartLocal.add(AddData(modelSanPhamMain: model));
              },
              child: Container(
                width: MediaQuery.of(context).size.width / 3,
                decoration:
                    BoxDecoration(border: Border.all(color: ColorApp.red)),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      FaIcon(
                        FontAwesomeIcons.add,
                        color: ColorApp.red,
                      ),
                      Text(
                        'GIỎ HÀNG',
                        style: StyleApp.textStyle600(color: ColorApp.red),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Align(
        alignment: Alignment(1, 0.7),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => MyHomePage()));
          },
          backgroundColor: Colors.white,
          child: Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: ColorApp.red)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  'assets/images/logoNoBG.png',
                  height: 40,
                  width: 40,
                ),
              )),
        ),
      ),
    );
  }
}
