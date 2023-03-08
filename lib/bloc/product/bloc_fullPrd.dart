
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kho_hang_nhat/model/model_flash.dart';

import '../../config/api.dart';
import '../../config/path/api_path.dart';
import '../../model/model_productMain.dart';
import '../event_bloc.dart';
import '../state_bloc.dart';


class BlocFullPrd extends Bloc<EventBloc, StateBloc> {
  BlocFullPrd() : super(StateBloc());
  List<ModelSanPhamMain> list = [];

  @override
  Stream<StateBloc> mapEventToState(EventBloc event) async* {
    if (event is LoadMoreEvent) {
      if (!event.loadMore) {
        yield Loading();
        list.clear();
      }
      try {
        if (event.cleanList) {
          list.clear();
        }
        if (event.loadMore) {
          yield LoadSuccess(
            data: list,
            hasMore: true,
          );
        }
        Map<String, dynamic> req = Map();



        var res = await Api.getAsync(

            endPoint:'${ApiPath.productAll}?category_id=${event.id}&&per_page=10&sort=${event.sort}&page=${event.page}',isToken: false
        );
        if (res["status"] == 1) {
     if(res['data'].length!=0)     {
            for (var item in res['data']['items']) {
              ModelSanPhamMain modelSanPhamMain =
                  ModelSanPhamMain.fromJson(item);
              list.add(modelSanPhamMain);
            }
          }
          yield LoadSuccess(
            data: list,
            hasMore: false,

            checkLength: res['data'].length==0 && event.loadMore
                ? true
                : false,

          );
        }
        else if(res['data']) {
          yield LoadFail(data: list,error: res['message'] ?? "Lỗi kết nối");
        }else {
          yield LoadFail(error: res['message'] ?? "Lỗi kết nối");
        }
      } on DioError catch (e) {
        yield LoadFail(error: e.error.error ?? "Lỗi kết nối");
      } catch (e) {
        print(e);
        yield LoadFail(error: e.toString());
      }
    }
  }
}
