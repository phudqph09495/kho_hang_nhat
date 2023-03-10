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
    if (event is AddData) {
      // list.add(event.modelSanPhamMain);

      // if(list.isNotEmpty){
      //   for (var i = 0; i < list.length; i++) {
      //     if (list[i].id == event.modelSanPhamMain.id) {
      //       print('a');
      //       list[i].soLuong = list[i].soLuong! + 1;
      //     }
      //     else {
      //       print('b');
      //       list.add(event.modelSanPhamMain);
      //     }
      //   }
      // }else{
      //   list.add(event.modelSanPhamMain);
      // }

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String jsonString = await prefs.getString('cart') ?? '[]';
      print(jsonString);
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
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String jsonString = await prefs.getString('cart') ?? '';


      List<ModelSanPhamMain> objects = jsonString != ''&&jsonString!='[]'
          ? List<ModelSanPhamMain>.from(
              jsonDecode(jsonString).map((x) => ModelSanPhamMain.fromJson(x)))
          : [];
      int sum=0;
      for(var item in objects){
        sum+=int.parse(item.price??'');
      }
      yield LoadSuccess(
        data: objects,
        data2: sum
      );
    }
    if (event is Reduce) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String jsonString = await prefs.getString('cart') ?? '';
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
        if (idList[i]==(event.modelSanPhamMain.id)) {

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
  }
}
