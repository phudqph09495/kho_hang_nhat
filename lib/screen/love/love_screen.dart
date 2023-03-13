import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kho_hang_nhat/widget/item/load_image.dart';
import 'package:kho_hang_nhat/widget/loadPage/item_load_page.dart';

import '../../bloc/event_bloc.dart';
import '../../bloc/product/bloc_ListLike.dart';
import '../../bloc/state_bloc.dart';
import '../../model/model_productMain.dart';
import '../../styles/init_style.dart';
import '../../widget/app_bar.dart';
import '../../widget/drawler.dart';
import '../../widget/loadPage/item_loadmore.dart';

class LoveScreen extends StatefulWidget {
  const LoveScreen({Key? key}) : super(key: key);

  @override
  State<LoveScreen> createState() => _LoveScreenState();
}

class _LoveScreenState extends State<LoveScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  ScrollController _controller = ScrollController();
  int page = 1;
  BlocListLike blocLikeList = BlocListLike();

  Future<void> onRefresh() async {
    page = 1;
    blocLikeList.add(LoadMoreEvent(

      page: page,
      cleanList: true,
    ));
  }

  loadmore() async {
    _controller.addListener(() {
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        page++;
        blocLikeList.add(LoadMoreEvent(

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
    return Scaffold(key: _scaffoldKey,
      drawer: ItemDrawer(),
      appBar: AppBarCustom(
          context: context,
          leadingTap: () {_scaffoldKey.currentState!.openDrawer();},
          scaffoldKey: _scaffoldKey,
          tittle: Center(
              child: Text(
            'Yêu thích',
            style: StyleApp.textStyle500(color: Colors.white, fontSize: 18),
          ))),
body: SingleChildScrollView(
  controller: _controller,
  child: Column(
    children: [
      BlocBuilder(builder: (_,StateBloc state){
        final length = state is LoadSuccess ? state.checkLength : false;
        final hasMore = state is LoadSuccess ? state.hasMore : false;
        final    list = state is LoadSuccess
            ? state.data as List<ModelSanPhamMain>
            : <ModelSanPhamMain>[];
        return ItemLoadPage(state: state,onTapErr: (){
          onRefresh();

        },
        success: Column(
          children: [

          ListView.builder(
            itemBuilder: (context, index) {
              return Column(
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(left: MediaQuery.of(context).size.height * 0.01, right: MediaQuery.of(context).size.height * 0.01, top: MediaQuery.of(context).size.height * 0.008, bottom: MediaQuery.of(context).size.height * 0.008),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.1,
                      decoration: BoxDecoration(border: Border.all()),
                      child: Row(
                        children: [
                          Container(
                              height: MediaQuery.of(context).size.height * 0.1,
                              width: MediaQuery.of(context).size.height * 0.1,
                              decoration: BoxDecoration(
                                  border: Border.all(color: ColorApp.red)),
                              child: LoadImage(
                                url:'${list[index].imageMainUrl}',
                                fit: BoxFit.fitHeight,
                              )),
                          Padding(
                            padding: EdgeInsets.only(top: 5,bottom: 5,left: 6),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    width: MediaQuery.of(context).size.width * 0.7,
                                    child: Text(
                                      '${list[index].name}',
                                      style: StyleApp.textStyle700(fontSize: 12),
                                    )),
                                Row(
                                  children: [
                                    Text('${list[index].price}đ',style: StyleApp.textStyle700(color: ColorApp.red),),
                                    SizedBox(width: 15,),
                                    Text('${list[index].priceBeforeDiscount}đ',style: StyleApp.textStyle400(color: Colors.grey,decoration: TextDecoration.lineThrough),),
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              );
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
        ));
      },bloc: blocLikeList,),
    ],
  ),
),
      // body: SingleChildScrollView(
      //     child: ListView.builder(
      //   itemBuilder: (context, index) {
      //     return Column(
      //       children: [
      //         SizedBox(
      //           height: 5,
      //         ),
      //         Padding(
      //           padding:
      //               EdgeInsets.only(left: MediaQuery.of(context).size.height * 0.01, right: MediaQuery.of(context).size.height * 0.01, top: MediaQuery.of(context).size.height * 0.008, bottom: MediaQuery.of(context).size.height * 0.008),
      //           child: Container(
      //             height: MediaQuery.of(context).size.height * 0.1,
      //             decoration: BoxDecoration(border: Border.all()),
      //             child: Row(
      //               children: [
      //                 Container(
      //                     height: MediaQuery.of(context).size.height * 0.1,
      //                     width: MediaQuery.of(context).size.height * 0.1,
      //                     decoration: BoxDecoration(
      //                         border: Border.all(color: ColorApp.red)),
      //                     child: Image.asset(
      //                       'assets/images/exp.jpg',
      //                       fit: BoxFit.fitHeight,
      //                     )),
      //                 Padding(
      //                   padding: EdgeInsets.only(top: 5,bottom: 5,left: 6),
      //                   child: Column(
      //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                     crossAxisAlignment: CrossAxisAlignment.start,
      //                     children: [
      //                       Container(
      //                           width: MediaQuery.of(context).size.width * 0.7,
      //                           child: Text(
      //                             'combo 3 gói mỳ chinh (bột ngọt) ajinomoto (1kg x 3) nội địa nhật bản',
      //                             style: StyleApp.textStyle700(fontSize: 12),
      //                           )),
      //                       Row(
      //                         children: [
      //                           Text('455.000đ',style: StyleApp.textStyle700(color: ColorApp.red),),
      //                           SizedBox(width: 15,),
      //                           Text('760.000đ',style: StyleApp.textStyle400(color: Colors.grey,decoration: TextDecoration.lineThrough),),
      //                         ],
      //                       )
      //                     ],
      //                   ),
      //                 )
      //               ],
      //             ),
      //           ),
      //         )
      //       ],
      //     );
      //   },
      //   itemCount: 10,
      //   shrinkWrap: true,
      //   physics: NeverScrollableScrollPhysics(),
      // )),
    );
  }
}
