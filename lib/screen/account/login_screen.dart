import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kho_hang_nhat/bloc/check_log_state.dart';
import 'package:kho_hang_nhat/bloc/event_bloc.dart';
import 'package:kho_hang_nhat/model/model_login.dart';

import '../../bloc/auth/bloc_login.dart';
import '../../bloc/state_bloc.dart';
import '../../config/path/share_pref_path.dart';
import '../../config/share_pref.dart';
import '../../styles/init_style.dart';
import '../../widget/app_bar.dart';
import '../home.dart';
import 'inset_phone.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController phone = TextEditingController();
  TextEditingController pass = TextEditingController();
  BlocLogin bloc = BlocLogin();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(
          context: context,
          hasCart: false,
          leadingTap: () {
            Navigator.pop(context);
          },
          scaffoldKey: _scaffoldKey,
          tittle: Center(
              child: Text(
            'Đăng nhập',
            style: StyleApp.textStyle500(color: Colors.white, fontSize: 18),
          ))),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              TextFormField(
                controller: phone,
                decoration: InputDecoration(
                    hintText: '     Số điện thoại ',
                    hintStyle: StyleApp.textStyle400(
                        color: Colors.grey, fontSize: 16)),
              ),
              TextFormField(
                controller: pass,
                obscureText: true,
                decoration: InputDecoration(
                    hintText: '     Mật khẩu ',
                    hintStyle:
                        StyleApp.textStyle400(color: Colors.grey, fontSize: 16),
                    suffixIcon: InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => NhapSDT()));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(13.0),
                        child: Text(
                          'quên?',
                          style: StyleApp.textStyle400(
                              fontSize: 16, color: ColorApp.red),
                        ),
                      ),
                    )),
              ),
              SizedBox(
                height: 15,
              ),
              BlocListener(
                bloc: bloc,
                listener: (_, StateBloc state) {
                  ModelLogin model = ModelLogin();
                  if (state is LoadSuccess) {
                    model = state.data;
                  }
                  CheckLogState.check(context, state: state, msg: 'Đăng nhập thành công',
                      success: () async {
                    await SharePrefsKeys.saveUserKey(model);
                // await    SharedPrefs.saveString(SharePrefsKeys.user_token,model.accessToken);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MyHomePage()));

                  });
                },
                child: InkWell(
                  onTap: () {
                    bloc.add(LoginApp(id: phone.text, password: pass.text));
                  },
                  child: Container(
                    color: ColorApp.red,
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Center(
                          child: Text(
                        'Đăng nhập',
                        style: StyleApp.textStyle700(color: Colors.white),
                      )),
                    ),
                  ),
                ),
              )
            ],
          ),
          Container(
              height: MediaQuery.of(context).size.height * 0.05,
              width: double.infinity,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey), color: Colors.white),
              child: Center(
                  child: Text(
                'Đăng ký',
                style: StyleApp.textStyle700(fontSize: 18, color: ColorApp.red),
              ))),
        ],
      ),
    );
  }
}