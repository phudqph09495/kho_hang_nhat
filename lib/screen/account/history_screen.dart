import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kho_hang_nhat/widget/loadPage/item_load_page.dart';

import '../../bloc/auth/bloc_lichSU.dart';
import '../../bloc/event_bloc.dart';
import '../../bloc/state_bloc.dart';
import '../../model/model_lichSu.dart';
import '../../styles/init_style.dart';
import '../../widget/loadPage/item_loadmore.dart';
import '../home/detail_lichSu.dart';

class LichSuDatHang extends StatefulWidget {
  const LichSuDatHang({Key? key}) : super(key: key);

  @override
  State<LichSuDatHang> createState() => _LichSuDatHangState();
}

class _LichSuDatHangState extends State<LichSuDatHang> {
  BlocLichSu blocLichSu = BlocLichSu();
  ScrollController _controller = ScrollController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  int page = 1;
  Future<void> onRefresh() async {
    page = 1;
    blocLichSu.add(LoadMoreEvent(
      page: page,
      cleanList: true,
    ));
  }

  loadmore() async {
    _controller.addListener(() {
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        page++;
        blocLichSu.add(LoadMoreEvent(
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
      body: Column(
        children: [
          BlocBuilder(
            builder: (_, StateBloc state) {
              final length = state is LoadSuccess ? state.checkLength : false;
              final hasMore = state is LoadSuccess ? state.hasMore : false;
              final list = state is LoadSuccess
                  ? state.data as List<LichSu>
                  : <LichSu>[];
              return ItemLoadPage(
                state: state,
                onTapErr: () {
                  onRefresh();
                },
                success:
                Expanded(
                  child: SingleChildScrollView(
                    controller: _controller,
                    child: Column(
                      children: [
                        ListView.builder(
                          itemBuilder: (context, index) {
                            return   Padding(padding: EdgeInsets.symmetric(vertical: 5),
                              child: InkWell(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>InfoLichSU(lichSu: list[index],)));
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
                                        Text('Mã đơn hàng : ${list[index].code}',style: StyleApp.textStyle400(),),
                                        Text(''),
                                        Text('Ngày tạo: ${list[index].createdAt }',style: StyleApp.textStyle400(),),
                                        Text(''),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Text('Tổng tiền: ',style: StyleApp.textStyle400(),),
                                                Text('${list[index].subtotal}đ',style: StyleApp.textStyle400(color: ColorApp.red),)
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text('Trạng thái: ',style: StyleApp.textStyle400(),),
                                                Text('${list[index].statusText}',style: StyleApp.textStyle400(color: ColorApp.red),)
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
                          itemCount: list.length,
                          physics: NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                        ),
                        ItemLoadMore(
                          hasMore: hasMore,
                          length: length,
                        ),
                      ],
                    ),
                  ),
                )
              );
            },
            bloc: blocLichSu,
          ),
        ],
      ),
    );
  }
}
