import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intelligent_inno_task/utils/colors.dart';
import 'package:intelligent_inno_task/utils/margins.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:string_extensions/string_extensions.dart';

class UserDetail extends StatefulWidget {
  final id, lastname, firstname, title, picture;

  const UserDetail(
      {Key? key,
      this.id,
      this.lastname,
      this.firstname,
      this.title,
      this.picture})
      : super(key: key);

  @override
  _UserDetailState createState() => _UserDetailState();
}

class _UserDetailState extends State<UserDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 30,
        backgroundColor: white,
        elevation: 0,
        iconTheme: IconThemeData.fallback(),
      ),
      backgroundColor: white,
      body: ListView(
        shrinkWrap: true,
        children: [
          Column(
            children: [
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
                color: accentColor,
                child: Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(
                      color: accentColor,
                      width: 6.0,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(100)),
                    // ignore: unnecessary_null_comparison
                    child: CachedNetworkImage(
                      imageUrl: widget.picture.toString(),
                      imageBuilder: (context, imageProvider) => Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          shape: BoxShape.rectangle,
                          image: DecorationImage(
                              image: imageProvider, fit: BoxFit.contain),
                        ),
                      ),
                      placeholder: (context, url) => CircularProgressIndicator(
                          strokeWidth: 1.2, backgroundColor: accentColor),
                    ),
                  ),
                ),
              ),
              const YMargin(10),
              Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(top: 00, left: 20, right: 20),
                    child: Card(
                      elevation: 5.0,
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 16.0, bottom: 16.0, right: 10.0, left: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            new Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(top: 6.0),
                                  child: Row(
                                    children: [
                                      new Text(
                                        widget.firstname,
                                        style: GoogleFonts.mulish(
                                            fontSize: 20.0,
                                            color: primaryColor,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      const XMargin(3),
                                      new Text(
                                        widget.lastname,
                                        style: GoogleFonts.mulish(
                                            fontSize: 20.0,
                                            color: primaryColor,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      const XMargin(3),
                                      new Text(
                                        "${[widget.title]}"
                                            .toUpperCase()
                                            .toString(),
                                        style: GoogleFonts.mulish(
                                            fontSize: 20.0,
                                            color: primaryColor,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const YMargin(20),
              Container(
                  padding: EdgeInsets.all(10),
                  child: Card(
                    color: Colors.white,
                    child: Container(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.all(15),
                      child: Column(
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                             
                              Divider(),
                                ListTile(
                                leading: Icon(Icons.person, color: primaryColor),
                                title: Text("Title",
                                    style: GoogleFonts.mulish(
                                        fontSize: 18, color: Colors.black)),
                                subtitle: Text(widget.title,
                                    style: GoogleFonts.mulish(
                                        fontSize: 15, color: Colors.black54)),
                              ),
                              Divider(),
                                ListTile(
                                leading: Icon(Icons.person, color: primaryColor),
                                title: Text("First Name",
                                    style: GoogleFonts.mulish(
                                        fontSize: 18, color: Colors.black)),
                                subtitle: Text(widget.firstname,
                                    style: GoogleFonts.mulish(
                                        fontSize: 15, color: Colors.black54)),
                              ),
                              Divider(),
                                ListTile(
                                leading: Icon(Icons.person, color: primaryColor),
                                title: Text("Last Name",
                                    style: GoogleFonts.mulish(
                                        fontSize: 18, color: Colors.black)),
                                subtitle: Text(widget.lastname,
                                    style: GoogleFonts.mulish(
                                        fontSize: 15, color: Colors.black54)),
                              ),
                              Divider(),
                              ListTile(
                                leading: Icon(Icons.email, color: primaryColor),
                                title: Text("User-ID",
                                    style: GoogleFonts.mulish(
                                        fontSize: 18, color: Colors.black)),
                                subtitle: Text(widget.id,
                                    style: GoogleFonts.mulish(
                                        fontSize: 15, color: Colors.black54)),
                              ),
                              Divider(),
                            
                              Divider(),
                            ],
                          )
                        ],
                      ),
                    ),
                  )),
            ],
          )
        ],
      ),
    );
  }
}
