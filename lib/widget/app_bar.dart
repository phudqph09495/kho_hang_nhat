import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kho_hang_nhat/widget/item/input/text_filed.dart';

import '../bloc/event_bloc.dart';
import '../bloc/state_bloc.dart';

import '../config/path/image_path.dart';

import '../screen/home/whithlist_screen.dart';
import '../styles/init_style.dart';

class AppBarCustom extends StatefulWidget implements PreferredSizeWidget {
  BuildContext context;
  GlobalKey<ScaffoldState> scaffoldKey;
  Widget tittle;
  bool hasCart;
  Function()? leadingTap;
  AppBarCustom({required this.context, required this.scaffoldKey,required this.tittle,this.hasCart=true,this.leadingTap});

  @override
  State<AppBarCustom> createState() => _AppBarCustomState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize =>
      Size(double.maxFinite, MediaQuery.of(context).size.height * 0.07);
}

class _AppBarCustomState extends State<AppBarCustom> {
  @override
  Widget build(BuildContext context) {
    return PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.07),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: ColorApp.red,
          flexibleSpace: Padding(
            padding: EdgeInsets.only(
                right: 10,
                left: 15,
                bottom: 5,
                top: MediaQuery.of(context).size.height * 0.05),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                widget.hasCart?   InkWell(onTap:widget.leadingTap,
                  child: Container(

                    decoration: BoxDecoration( shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2)),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Icon(
                        Icons.list,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ):InkWell(onTap:widget.leadingTap ,child: Icon(Icons.arrow_back_ios_new_outlined,  color: Colors.white,
                  size: 20,),),
                Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: widget.tittle),
           widget.hasCart?   Stack(
             children: [
               InkWell(

                   onTap: (){
                     Navigator.push(context, MaterialPageRoute(builder: (context)=>GioHangScreen()));
                   },

                 child: Padding(
                   padding: const EdgeInsets.all(3.0),
                   child: Icon(
                     Icons.shopping_cart_outlined,
                     color: Colors.white,
                     size: 25,
                   ),
                 ),
               ),
               Positioned(bottom: -3,right: 0,child: Container(
                 decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.white),
                 child: Padding(
                   padding: const EdgeInsets.all(4.0),
                   child: Text('0',style: StyleApp.textStyle500(color: Colors.red,fontSize: 12),),
                 ),
               ))
             ],
           ):SizedBox()
              ],
            ),
          ),
        ));
  }
}
