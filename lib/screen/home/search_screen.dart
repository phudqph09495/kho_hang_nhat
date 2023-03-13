import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kho_hang_nhat/screen/home/info_product.dart';
import 'package:kho_hang_nhat/widget/loadPage/item_load_page.dart';

import '../../bloc/event_bloc.dart';
import '../../bloc/product/bloc_search.dart';
import '../../bloc/state_bloc.dart';
import '../../model/model_productMain.dart';
import '../../styles/init_style.dart';
import '../../widget/item/load_image.dart';
import '../../widget/loadPage/item_loadmore.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController search = TextEditingController();
  ScrollController _controller = ScrollController();
  int page = 1;
  BlocSearch blocSearch = BlocSearch();

  Future<void> onRefresh() async {
    page = 1;
    blocSearch.add(LoadMoreEvent(
      id: search.text,
      page: page,
      cleanList: true,
    ));
  }

  loadmore() async {
    _controller.addListener(() {
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        page++;
        blocSearch.add(LoadMoreEvent(
          id: search.text,
          page: page,
          loadMore: true,
        ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: ColorApp.red,
            )),
        actions: [
          InkWell(
              onTap: () {
                search.clear();
              },
              child: Icon(
                Icons.clear,
                color: ColorApp.red,
              ))
        ],
        backgroundColor: ColorApp.whiteF0,
        title: TextFormField(
          controller: search,
          onChanged: (val) {
      if(search.text!=''){
              onRefresh();
              loadmore();
            }
            print(search.text);
          },
          decoration: InputDecoration(
              hintText: 'Tìm kiếm',
              hintStyle: StyleApp.textStyle400(fontStyle: FontStyle.italic)),
        ),
      ),
      body: SingleChildScrollView(
        controller: _controller,
        child: Column(
          children: [
            BlocBuilder(
              builder: (_, StateBloc state) {
                final length = state is LoadSuccess ? state.checkLength : false;
                final hasMore = state is LoadSuccess ? state.hasMore : false;
          final    list = state is LoadSuccess
                    ? state.data as List<ModelSanPhamMain>
                    : <ModelSanPhamMain>[];
                return ItemLoadPage(
                    state: state,
                    onTapErr: () {
                      onRefresh();
                    },
                    success: Column(
                    children: [
                    ListView.builder(
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>InfoProductScreen(id: '${list[index].id}')));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: [
                                Row(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    LoadImage(
                                      url:
                                          '${list[index].imageMainUrl}',
                                      width:
                                          MediaQuery.of(context).size.width *
                                              0.2,
                                      fit: BoxFit.fitHeight,
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${list[index].name}',
                                            style: StyleApp.textStyle700(),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                '${list[index].price} đ',
                                                style: StyleApp.textStyle700(
                                                    color: ColorApp.red,
                                                    fontSize: 16),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                '${list[index].priceBeforeDiscount} đ',
                                                style: StyleApp.textStyle700(
                                                    color: ColorApp.grey4F,
                                                    fontSize: 14,
                                                    decoration: TextDecoration
                                                        .lineThrough),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                Divider()
                              ],
                            ),
                          ),
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
              },
              bloc: blocSearch,
            ),
          ],
        ),
      ),
    );
  }
}
