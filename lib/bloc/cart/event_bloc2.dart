import 'package:kho_hang_nhat/model/model_productMain.dart';

abstract class EventBloc2 {}
class AddData extends EventBloc2{
  ModelSanPhamMain modelSanPhamMain;
  AddData({required this.modelSanPhamMain});
}
class Reduce extends EventBloc2{
  ModelSanPhamMain modelSanPhamMain;
  Reduce({required this.modelSanPhamMain});
}
class GetCart extends EventBloc2{}