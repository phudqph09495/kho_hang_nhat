import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../config/api.dart';
import '../../config/path/api_path.dart';

import '../../model/model_login.dart';
import '../event_bloc.dart';
import '../state_bloc.dart';

class BlocUpdateProFile extends Bloc<EventBloc, StateBloc> {
  BlocUpdateProFile() : super(StateBloc());

  @override
  Stream<StateBloc> mapEventToState(EventBloc event) async* {
    if (event is UpdateProfile) {
      yield Loading();
      try {
        Map<String, dynamic> req = Map();
        req['name'] = event.name;
        req['email'] = event.email;
        req['phone'] = event.phone;
        req['address'] = event.address;
        req['region_id'] = event.region;
        req['district_id'] = event.district;
        var res = await Api.postAsync(
            endPoint: ApiPath.updatePro, req: req, isToken: true);
        print(res);
        if (res['status'] == 1) {



          yield LoadSuccess(

          );
        } else if (res['status'] == 0) {
          yield LoadFail(error: res['errors']['login'] ?? "Lỗi kết nối");
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
