import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intelligent_inno_task/utils/colors.dart';
import 'package:intelligent_inno_task/utils/customLoader.dart';
import 'package:intelligent_inno_task/utils/margins.dart';
import 'package:intelligent_inno_task/utils/navigationUtil.dart';

import 'detailScreen.dart'; 
// ignore: import_of_legacy_library_into_null_safe
import 'package:string_extensions/string_extensions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_fonts/google_fonts.dart';

class LocalUser extends StatefulWidget {
  const LocalUser({Key? key}) : super(key: key);

  @override
  _LocalUserState createState() => _LocalUserState();
}

class _LocalUserState extends State<LocalUser> {
  Map? data;
  List? userData;

  Future<String> loadJsonData() async {
    var jsonText = await rootBundle.loadString('assets/json/userData.json');
    data = json.decode(jsonText);
    setState(() {
      userData = data!['data'];
    }); 
    return 'success';
  }

  @override
  void initState() {
    super.initState();
    this.loadJsonData();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: loadJsonData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (userData == null) {
            return Loading();
          } else
            return Scaffold(backgroundColor: white,
            appBar: AppBar(
              centerTitle: true,
          elevation: 0,
          backgroundColor: white,
          title: Text(
            'Users List[Offline]',
            style: GoogleFonts.mulish(
                color: black, fontSize: 20, fontWeight: FontWeight.w700),
          ),),
                body: ListView.separated(
                    separatorBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 20),
                        child: Divider(),
                      );
                    },
                    itemCount: userData!.length,
                    itemBuilder: (BuildContext contet, int index) {
                      return GestureDetector(
                        onTap: () {
                          navigate(
                              context,
                              UserDetail(
                                id: userData![index]['id'],
                                title: userData![index]['title'],
                                lastname: userData![index]['lastName'],
                                firstname: userData![index]['firstName'],
                                picture: userData![index]['picture'],
                              ));
                        },
                        child: ListTile(
      leading: CachedNetworkImage(
        imageUrl:userData![index]['picture'],
        imageBuilder: (context, imageProvider) => Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            shape: BoxShape.rectangle,
            image: DecorationImage(image: imageProvider, fit: BoxFit.contain),
          ),
        ),
        placeholder: (context, url) => CircularProgressIndicator(
            strokeWidth: 1.2, backgroundColor: accentColor),
      ),
      title: Row(
        children: [
          Text(
           userData![index]['title'],
            style: GoogleFonts.mulish(
                color: black, fontSize: 14, fontWeight: FontWeight.w700),
          ),
          const XMargin(3),
          Text(
            userData![index]['firstName'],
            style: GoogleFonts.mulish(
                color: black, fontSize: 14, fontWeight: FontWeight.w700),
          ),
          const XMargin(3),
          Text(
           userData![index]['lastName'],
            style: GoogleFonts.mulish(
                color: black, fontSize: 14, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    )
 
                      );
                    }));
        });
  }
}
