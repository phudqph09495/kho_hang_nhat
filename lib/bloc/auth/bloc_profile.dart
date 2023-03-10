
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kho_hang_nhat/model/model_user.dart';

import '../../config/api.dart';
import '../../config/path/api_path.dart';

import '../../config/path/share_pref_path.dart';
import '../../config/share_pref.dart';
import '../../model/model_login.dart';
import '../event_bloc.dart';
import '../state_bloc.dart';

class BlocProfile extends Bloc<EventBloc, StateBloc> {
  BlocProfile() : super(StateBloc());

  @override
  Stream<StateBloc> mapEventToState(EventBloc event) async* {
    if (event is GetData) {
      yield Loading();
      try {

        var res = await Api.getAsync(endPoint: ApiPath.profile,isToken: true);


        // yield LoadSuccess(
        // );
        if (res['status'] == 1){

          ModelUser model = ModelUser.fromJson(res['data']);


          yield LoadSuccess(
            data: model,
          );
        } else if (res['status'] == 0) {

          yield LoadFail(error: res['errors'] ?? "Lỗi kết nối");
        }
        else if (res['status'] == 401) {

          yield LoadFail(error: res['errors'] ?? "Lỗi kết nối");
        }





      } on DioError catch (e) {
        yield LoadFail(error: e.error.error);
      } catch (e) {
        print(e);
        yield LoadFail(error: e.toString());
      }
    }
  }
}

