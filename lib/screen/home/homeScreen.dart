import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:kho_hang_nhat/model/model_config.dart';
import 'package:kho_hang_nhat/model/model_flash.dart';
import 'package:kho_hang_nhat/model/model_productMain.dart';
import 'package:kho_hang_nhat/screen/home/product_screen.dart';
import 'package:kho_hang_nhat/screen/home/search_screen.dart';
import 'package:kho_hang_nhat/widget/item/load_image.dart';
import 'package:kho_hang_nhat/widget/loadPage/item_load_page.dart';

import '../../bloc/config/bloc_config.dart';
import '../../bloc/event_bloc.dart';
import '../../bloc/product/bloc_flash.dart';
import '../../bloc/product/bloc_productMain.dart';
import '../../bloc/state_bloc.dart';
import '../../styles/init_style.dart';
import '../../widget/app_bar.dart';
import '../../widget/drawler.dart';
import '../../widget/item/input/text_filed.dart';
import '../../widget/item/item_count_down.dart';
import '../../widget/loadPage/item_loadmore.dart';
import '../item/product_item.dart';
import 'flash_sreen.dart';
import 'info_product.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  BlocFlashSale blocFlashSale = BlocFlashSale();
  BlocConfig blocConfig = BlocConfig()..add(GetData());
  BlocProductMain blocProductMain = BlocProductMain();
  ScrollController _controller = ScrollController();
  int page = 1;
  ModelConfig modelConFig=ModelConfig();
  Future<void> onRefresh() async {
    page = 1;
    blocProductMain.add(LoadMoreEvent(
      page: page,
      cleanList: true,
    ));
  }

  loadmore() async {
    _controller.addListener(() {
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {

        page++;
        blocProductMain.add(LoadMoreEvent(
          page: page,
          loadMore: true,
        ));
      }
    });
  }
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    onRefresh();
    loadmore();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: ItemDrawer(),
      appBar: AppBarCustom(
        context: context,
        leadingTap: () {
          _scaffoldKey.currentState!.openDrawer();
        },
        scaffoldKey: _scaffoldKey,
        tittle: InputText1(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchScreen()));
          },
          label: 'Tìm kiếm',
          readOnly: true,
          hasLeading: true,
          iconPreFix: InkWell(

            child: Icon(
              Icons.search,
              color: Colors.red,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        controller: _controller,
        child: Column(
          children: [
            Container(
              color: ColorApp.red,
              child: Column(
                children: [
                  BlocBuilder(
                    builder: (_, StateBloc state) {
                      if (state is LoadSuccess) {
                         modelConFig = state.data;
                        modelConFig.flashSale!=null?     blocFlashSale.add(
                            GetData(param: '${modelConFig.flashSale!.id}')):null;
                        return Column(
                          children: [
                            ImageSlideshow(
                              children: List.generate(
                                  modelConFig.imageHomeUrls!.length,
                                  (index) => LoadImage(
                                        url:
                                            '${modelConFig.imageHomeUrls![index].imageUrl}',
                                        width: double.infinity,
                                        fit: BoxFit.fitWidth,
                                      )),
                              // [

                              height: MediaQuery.of(context).size.height * 0.2,
                              indicatorColor: Colors.red,
                              isLoop: true,
                              autoPlayInterval: 2000,
                            ),
                            modelConFig.flashSale!=null?         Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'FLASH SALE',
                                    style: StyleApp.textStyle500(
                                        fontSize: 18, color: Colors.amber),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => FlashScreen(param:'${modelConFig.flashSale!.id}' ,)));
                                    },
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'XEM THÊM',
                                          style: StyleApp.textStyle500(
                                              fontSize: 14, color: Colors.white),
                                        ),
                                        Icon(
                                          Icons.arrow_right,
                                          color: Colors.white,
                                          size: 20,
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ):SizedBox(),
                          ],
                        );
                      }
                      return SizedBox();
                    },
                    bloc: blocConfig,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(),
                      BlocBuilder(
                        builder: (_, StateBloc state) {
                          if (state is LoadSuccess) {
                            ModelConfig modelConFig = state.data;
                            return modelConFig.flashSale!=null? ItemCountDown(
                                time: DateTime.parse(
                                        '${modelConFig.flashSale!.dateTo}')
                                    .millisecondsSinceEpoch):SizedBox();
                          }
                          return ItemCountDown(
                            time: DateTime.now().millisecondsSinceEpoch +
                                86400000,
                          );
                        },
                        bloc: blocConfig,
                      ),
                      // ItemCountDown(
                      //   time: DateTime.now().millisecondsSinceEpoch + 86400000,
                      // ),
                      SizedBox(),
                    ],
                  ),
                  BlocBuilder(
                    builder: (_, StateBloc state) {
                      if (state is LoadSuccess) {
                        ModelFlash modelFlash = state.data;
                        return Container(
                          height: MediaQuery.of(context).size.width * 0.5 + 11,
                          child: ListView.builder(
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              InfoProductScreen(id: '${modelFlash.items![index].id}',)));
                                },
                                child: Padding(
                                  padding: EdgeInsets.all(
                                      MediaQuery.of(context).size.width * 0.01),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.white),
                                        color: Colors.white),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Stack(
                                          alignment: Alignment.topLeft,
                                          children: [
                                            LoadImage(
                                              url:
                                                  '${modelFlash.items![index].imageMainUrl}',
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.3,
                                              fit: BoxFit.fitHeight,
                                            ),
                                            // Image.asset(
                                            //   'assets/images/exp.jpg',
                                            //   width: MediaQuery.of(context).size.width *
                                            //       0.30,
                                            //   fit: BoxFit.fitHeight,
                                            // ),
                                            Container(
                                              decoration: BoxDecoration(
                                                  color: ColorApp.red,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topRight:
                                                              Radius.circular(
                                                                  20),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  20))),
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 2, horizontal: 5),
                                                child: Text(
                                                 (100- (double.parse('${modelFlash.items![index].price}') *
                                                              100 /
                                                              double.parse(
                                                                  '${modelFlash.items![index].priceBeforeDiscount}'))
                                                          .round())
                                                          .toString() +
                                                      '%',
                                                  style: StyleApp.textStyle500(
                                                      color: Colors.white,
                                                      fontSize: 14),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          '${NumberFormat("###,###.###", 'vi_VN').format(int.parse(modelFlash.items![index].price ?? ''))}đ',
                                          style: StyleApp.textStyle600(
                                              color: ColorApp.red,
                                              fontSize: 16),
                                        ),
                                        Text(
                                          '${NumberFormat("###,###.###", 'vi_VN').format(int.parse(modelFlash.items![index].priceBeforeDiscount ?? ''))}đ',
                                          style: StyleApp.textStyle600(
                                              color: ColorApp.grey4F,
                                              fontSize: 14,
                                              decoration:
                                                  TextDecoration.lineThrough),
                                        ),
                                        Stack(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10, vertical: 10),
                                              child: Stack(
                                                alignment: Alignment.center,
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(
                                                        color: Colors.amber,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20)),
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.255,
                                                    height: 15,
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          decoration: BoxDecoration(
                                                              color: Colors.red,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20)),
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.06,
                                                        ),
                                                        SizedBox()
                                                      ],
                                                    ),
                                                  ),
                                                  Text(
                                                    ' Đã bán ${modelFlash.items![index].soldCount}',
                                                    style:
                                                        StyleApp.textStyle500(
                                                            color:
                                                                Colors.white),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Positioned(
                                              left: 0.5,
                                              bottom: 10,
                                              child: Stack(
                                                alignment:
                                                    Alignment.bottomCenter,
                                                children: [
                                                  FaIcon(
                                                    FontAwesomeIcons
                                                        .fireFlameCurved,
                                                    size: 30,
                                                    color: ColorApp.redText,
                                                  ),
                                                  Container(
                                                    decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        border: Border.all(
                                                            color:
                                                                Colors.white),
                                                        color: ColorApp.red),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              2.0),
                                                      child: Text(
                                                        '%',
                                                        style: StyleApp
                                                            .textStyle500(
                                                                fontSize: 13,
                                                                color: Colors
                                                                    .white),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: modelFlash.items!.length,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                          ),
                        );
                      }
                      if (state is Loading)    {
                        return Container(
                          height: MediaQuery.of(context).size.width * 0.5 + 11,
                          child: ListView.builder(
                            itemBuilder: (context, index) {
                              return Padding(
                                  padding: EdgeInsets.all(
                                      MediaQuery.of(context).size.width * 0.01),
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.3,
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.white),
                                        color: Colors.white),
                                  ));
                            },
                            itemCount: 3,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                          ),
                        );
                      }
                      return SizedBox();
                    },
                    bloc: blocFlashSale,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 05, vertical: 10),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Sản phẩm',
                        style: StyleApp.textStyle500(
                            color: ColorApp.red, fontSize: 16),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProductScreen()));
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Xem tất cả',
                              style: StyleApp.textStyle500(
                                  color: ColorApp.red, fontSize: 16),
                            ),
                            Icon(
                              Icons.arrow_right,
                              color: ColorApp.red,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  // GridView.builder(
                  //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  //       crossAxisCount: 2,
                  //       mainAxisSpacing: 10,
                  //       crossAxisSpacing: 10,
                  //       mainAxisExtent:
                  //       MediaQuery.of(context).size.height * 0.32),
                  //   itemBuilder: (context, index) {
                  //     return ProductItem();
                  //   },
                  //   itemCount: 10,
                  //   shrinkWrap: true,
                  //   physics: NeverScrollableScrollPhysics(),
                  // )
                  BlocBuilder(
                    builder: (_, StateBloc state) {
                      final length =
                          state is LoadSuccess ? state.checkLength : false;
                      final hasMore =
                          state is LoadSuccess ? state.hasMore : false;
                      final list = state is LoadSuccess
                          ? state.data as List<ModelSanPhamMain>
                          : <ModelSanPhamMain>[];
                      return ItemLoadPage(
                        state: state,
                        onTapErr: () {
                          onRefresh();
                        },
                        success: Column(
                          children: [
                            GridView.builder(
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 10,
                                  crossAxisSpacing: 10,
                                  mainAxisExtent:
                                  MediaQuery.of(context).size.height * 0.32),
                              itemBuilder: (context, index) {
                                return ProductItem(modelSanPhamMain: list[index],);
                              },
                              itemCount: list.length,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                            ),
                            ItemLoadMore(
                              hasMore: hasMore,
                              length: length,
                            ),
                          ],
                        )
                      );
                    },
                    bloc: blocProductMain,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
