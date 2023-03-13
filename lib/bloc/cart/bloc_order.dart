import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kho_hang_nhat/model/model_config.dart';
import 'package:kho_hang_nhat/model/model_user.dart';

import '../../config/api.dart';
import '../../config/path/api_path.dart';

import '../../config/path/share_pref_path.dart';
import '../../config/share_pref.dart';
import '../../model/model_flash.dart';
import '../../model/model_login.dart';
import '../event_bloc.dart';
import '../state_bloc.dart';

class Bloc_Order extends Bloc<EventBloc, StateBloc> {
  Bloc_Order() : super(StateBloc());

  @override
  Stream<StateBloc> mapEventToState(EventBloc event) async* {
    if (event is TaoOrder) {
      yield Loading();
      try {
        Map<String, dynamic> req1 = Map();
        List<Map<String, dynamic>> product = [];
        for (var item in event.product) {
          Map<String, dynamic> req = Map();
          req['id'] = item.id;
          req['qty'] = item.qty;
          product.add(req);
        }
        Map<String, dynamic> req2 = Map();
        req2['address'] = event.address;
        req2['region_id'] = event.region_id;
        req2['district_id'] = event.district_id;
        req2['name'] = event.name;
        req2['phone'] = event.phone;

        req1['payment_method']=event.payment_method;
        req1['promotion_code']=event.promotion_code;
        req1['shipping_method']=event.shipping_method;
        req1['products']=product;
        req1['delivery_info']=req2;
       print(req1);
        var res = await Api.postAsync(endPoint: ApiPath.order,isToken: true,req: req1);
print(res);
        if (res['status'] == 1){
String code=res['data']['code'];
          yield LoadSuccess(
data: code
          );
        } else if (res['status'] == 0) {

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
