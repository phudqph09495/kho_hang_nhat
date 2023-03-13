import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../config/path/share_pref_path.dart';
import '../../config/share_pref.dart';
import '../../model/model_productMain.dart';
import '../event_bloc.dart';
import '../state_bloc.dart';
import 'event_bloc2.dart';

class BlocCartLocal extends Bloc<EventBloc2, StateBloc> {
  BlocCartLocal() : super(StateBloc());

  @override
  Stream<StateBloc> mapEventToState(EventBloc2 event) async* {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (event is AddData) {
      String jsonString = prefs.getString('cart') ?? '[]';
      List<ModelSanPhamMain> list = jsonString != "[]"
          ? List<ModelSanPhamMain>.from(
              jsonDecode(jsonString).map((x) => ModelSanPhamMain.fromJson(x)))
          : [];
      list.add(event.modelSanPhamMain);
      jsonString = jsonEncode(list);
      prefs.setString('cart', jsonString);
      yield LoadSuccess(data: list);
    }
    if (event is GetCart) {
      String jsonString = prefs.getString('cart') ?? '';
      List<ModelSanPhamMain> objects = jsonString != '' && jsonString != '[]'
          ? List<ModelSanPhamMain>.from(
              jsonDecode(jsonString).map((x) => ModelSanPhamMain.fromJson(x)))
          : [];
      int sum = 0;
      for (var item in objects) {
        sum += int.parse(item.price ?? '');
      }
      yield LoadSuccess(data: objects, data2: sum);
    }
    if (event is Reduce) {
      String jsonString = prefs.getString('cart') ?? '';
      print(jsonString);
      List<ModelSanPhamMain> objects = jsonString != "[]"
          ? List<ModelSanPhamMain>.from(
              jsonDecode(jsonString).map((x) => ModelSanPhamMain.fromJson(x)))
          : [];
      List<String> idList = [];
      for (var item in objects) {
        idList.add(item.id ?? '');
      }
      for (var i = 0; i < objects.length; i++) {
        if (idList[i] == (event.modelSanPhamMain.id)) {
          objects.removeAt(i);
          break;
        }
      }
      jsonString = jsonEncode(objects);
      prefs.setString('cart', jsonString);
      yield LoadSuccess(
        data: objects,
      );
    }
    if (event is ClearAll) {
      String jsonString = await prefs.getString('cart') ?? '';
      print(jsonString);
      List<ModelSanPhamMain> objects = jsonString != "[]"
          ? List<ModelSanPhamMain>.from(
              jsonDecode(jsonString).map((x) => ModelSanPhamMain.fromJson(x)))
          : [];
      objects.clear();
      jsonString = jsonEncode(objects);
      prefs.setString('cart', jsonString);
    }
  }
}
