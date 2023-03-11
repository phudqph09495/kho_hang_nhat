import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kho_hang_nhat/model/model_flash.dart';
import 'package:kho_hang_nhat/model/model_lichSu.dart';
import 'package:kho_hang_nhat/model/model_noti.dart';

import '../../config/api.dart';
import '../../config/path/api_path.dart';
import '../../model/model_productMain.dart';
import '../event_bloc.dart';
import '../state_bloc.dart';

class BlocLichSu extends Bloc<EventBloc, StateBloc> {
  BlocLichSu() : super(StateBloc());
  List<LichSu> list = [];

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
            endPoint: '${ApiPath.lichSu}${event.page}',
            isToken: true);
        if (res["status"] == 1) {
          if (res['data'].length != 0) {
            for (var item in res['data']['items']) {
              LichSu history = LichSu.fromJson(item);
              list.add(history);
            }
          }
          yield LoadSuccess(
            data: list,
            hasMore: false,
            checkLength:
            res['data'].length == 0 && event.loadMore ? true : false,
          );
        } else if (res['status'] == 0) {
          yield LoadFail(error: res['errors']['empty'] ?? "Lỗi kết nối");
        } else if (res['status'] == 401) {
          yield LoadFail2(error: 'error');
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
