import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kho_hang_nhat/model/model_category.dart';

import '../../bloc/event_bloc.dart';
import '../../bloc/product/bloc_category.dart';
import '../../bloc/state_bloc.dart';
import '../../styles/init_style.dart';
import '../../widget/app_bar.dart';
import '../item/product_item.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen>
    with TickerProviderStateMixin {
  TabController? _tabController;
  TabController? _tabController2;
  int TabCha = 0;
int id=0;
  int tabCon=0;

  String type = 'Bán chạy nhất';
  BlocCategory blocCategory = BlocCategory()..add(GetData());
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _tabController = TabController(length: 10, vsync: this);
    // _tabController2 = TabController(length: 5, vsync: this);
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
                          'Sản phẩm',
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
              if (state is LoadSuccess) {
                ModelCategory model = state.data;
                _tabController =
                    TabController(length: model.items!.length, vsync: this);
                _tabController2 = TabController(
                    length: model.items![TabCha].children!.length, vsync: this);
                return TabBar(
                  controller: _tabController,
                  onTap: (value) {
                  print( model.items![TabCha].children![0].id);

                    TabCha = value;
                    _tabController2 = TabController(
                        length: model.items![TabCha].children!.length,
                        vsync: this);
                    setState(() {});
                  },
                  labelPadding: EdgeInsets.symmetric(horizontal: 30),
                  isScrollable: true,
                  labelStyle: StyleApp.textStyle700(fontSize: 16),
                  indicatorColor: Colors.transparent,
                  unselectedLabelStyle: StyleApp.textStyle500(fontSize: 14),
                  labelColor: ColorApp.red,
                  unselectedLabelColor: ColorApp.black49,
                  tabs: List<Tab>.generate(
                    model.items!.length,
                    (int index) {
                      return new Tab(
                        child: Text(
                          '${model.items![index].name}',
                          style: TabCha == index
                              ? StyleApp.textStyle700(
                                  fontSize: 16, color: ColorApp.red)
                              : StyleApp.textStyle500(
                                  fontSize: 14, color: ColorApp.black49),
                        ),
                      );
                    },
                  ),
                );
              }
              return SizedBox();
            },
            bloc: blocCategory,
          ),
          BlocBuilder(
            builder: (_, StateBloc state) {
              if (state is LoadSuccess) {
                ModelCategory model = state.data;
                return TabBar(
                    controller: _tabController2,
                    onTap: (value) {
                      print(value);
                      tabCon=value;
                    },
                    labelPadding: EdgeInsets.symmetric(horizontal: 30),
                    isScrollable: true,
                    labelStyle: StyleApp.textStyle700(fontSize: 16),
                    indicatorColor: Colors.transparent,
                    unselectedLabelStyle: StyleApp.textStyle500(fontSize: 14),
                    labelColor: ColorApp.red,
                    unselectedLabelColor: ColorApp.black49,
                    tabs: List<Tab>.generate(
                      model.items![TabCha]!.children!.length,
                      (int index) {
                        return new Tab(
                          child: Text(
                            '${model.items![TabCha].children![index].name}',
                          ),
                        );
                      },
                    ));
              }
              return SizedBox();
            },
            bloc: blocCategory,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(),
                InkWell(
                  onTap: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (context) => Container(
                              height: MediaQuery.of(context).size.height * 0.4,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    InkWell(
                                        onTap: () {
                                          type = 'Bán chạy nhất';
                                          Navigator.pop(context);
                                          setState(() {});
                                        },
                                        child: Container(
                                          width: double.maxFinite,
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 10),
                                            child: Text(
                                              'Bán chạy nhất',
                                              style: StyleApp.textStyle500(),
                                            ),
                                          ),
                                        )),
                                    InkWell(
                                        onTap: () {
                                          type = 'Hàng mới về';
                                          Navigator.pop(context);
                                          setState(() {});
                                        },
                                        child: Container(
                                          width: double.maxFinite,
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 10),
                                            child: Text(
                                              'Hàng mới về',
                                              style: StyleApp.textStyle500(),
                                            ),
                                          ),
                                        )),
                                    InkWell(
                                        onTap: () {
                                          type = 'Giá cao đến thấp';
                                          Navigator.pop(context);
                                          setState(() {});
                                        },
                                        child: Container(
                                          width: double.maxFinite,
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 10),
                                            child: Text(
                                              'Giá cao đến thấp',
                                              style: StyleApp.textStyle500(),
                                            ),
                                          ),
                                        )),
                                    InkWell(
                                        onTap: () {
                                          type = 'Giá thấp đến cao';
                                          Navigator.pop(context);
                                          setState(() {});
                                        },
                                        child: Container(
                                          width: double.maxFinite,
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 10),
                                            child: Text(
                                              'Giá thấp đến cao',
                                              style: StyleApp.textStyle500(),
                                            ),
                                          ),
                                        )),
                                    InkWell(
                                        onTap: () {
                                          type = 'Giảm giá';
                                          Navigator.pop(context);
                                          setState(() {});
                                        },
                                        child: Container(
                                          width: double.maxFinite,
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 10),
                                            child: Text(
                                              'Giảm giá',
                                              style: StyleApp.textStyle500(),
                                            ),
                                          ),
                                        )),
                                  ],
                                ),
                              ),
                            ));
                  },
                  child: Row(
                    children: [
                      Text(
                        type,
                        style: StyleApp.textStyle400(),
                      ),
                      Icon(Icons.arrow_upward),
                      Icon(Icons.arrow_downward)
                    ],
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: GridView.builder(
                padding: EdgeInsets.all(10),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    mainAxisExtent: MediaQuery.of(context).size.height * 0.32),
                itemBuilder: (context, index) {
                  // return ProductItem(borderW: 2,);
                  return SizedBox();
                },
                itemCount: 10,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
