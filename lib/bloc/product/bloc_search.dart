
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../config/api.dart';
import '../../config/path/api_path.dart';
import '../../model/model_flash.dart';
import '../../model/model_productMain.dart';
import '../event_bloc.dart';
import '../state_bloc.dart';


class BlocSearch extends Bloc<EventBloc, StateBloc> {
  BlocSearch() : super(StateBloc());
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
        var res = await Api.getAsync(

            endPoint:ApiPath.search+event.id+'&per_page=10'+'&page='+event.page.toString(),isToken: false);

        if (res["status"] == 1) {
          ModelFlash modelFlash=ModelFlash.fromJson(res['data']);
        if(modelFlash.pagination!.total!="0")  {
            for (var item in res['data']['items']) {
              ModelSanPhamMain modelSanPhamMain =
                  ModelSanPhamMain.fromJson(item);
              list.add(modelSanPhamMain);
            }
            yield LoadSuccess(
              data: list,
              hasMore: false,
              checkLength: res['data']['items'].length == 0 && event.loadMore
                  ? true
                  : false,
            );
          }else{
          yield LoadFail(error: 'Không tìm thấy sản phẩm');
        }
        }
      else {
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
