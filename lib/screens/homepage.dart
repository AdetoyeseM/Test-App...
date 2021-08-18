import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intelligent_inno_task/core/viewModel/userViewModel.dart';
import 'package:intelligent_inno_task/models/userHiveModel.dart';
import 'package:intelligent_inno_task/models/userListModels.dart';
import 'package:intelligent_inno_task/utils/colors.dart';
import 'package:intelligent_inno_task/utils/customLoader.dart';
import 'package:intelligent_inno_task/utils/margins.dart';
import 'package:intelligent_inno_task/utils/navigationUtil.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:string_extensions/string_extensions.dart';

import 'detailScreen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController searchController = TextEditingController();
  late UsersViewModel usersViewModel;
  String? userName;

  bool _isInit = true;
  @override
  void didChangeDependencies() async {
    if (_isInit) {
      await Provider.of<UsersViewModel>(context, listen: false).getUsersName(context);
    }
    setState(() {
      _isInit = false;
    });

    super.didChangeDependencies();
  }

  List<UserHiveList> userHiveList = [];
  @override
  Widget build(BuildContext context) {
    usersViewModel = context.watch<UsersViewModel>();
    var i = userName;
    final data = usersViewModel.searchForUser(i ?? "");
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: white,
          title: Text(
            'Users List',
            style: GoogleFonts.mulish(
                color: black, fontSize: 20, fontWeight: FontWeight.w700),
          ),
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).dividerColor,
                  borderRadius: BorderRadius.circular(30),
                ),
                margin: EdgeInsets.symmetric(horizontal: 24),
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        controller: searchController,
                        decoration: InputDecoration(
                            hintText: "Search Users", border: InputBorder.none),
                        onChanged: (value) {
                          setState(() {
                            userName = value.toString();
                          });
                        },
                      ),
                    ),
                    Spacer(),
                    IconButton(
                        icon: Icon(Icons.close),
                        color: accentColor,
                        onPressed: () {
                          searchController.clear();
                        })
                  ],
                ),
              ),
            ),
          ),
        ),
        backgroundColor: white,
        body: _isInit
            ? Center(child: Loading())
            : ListView.separated(
                separatorBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20),
                    child: Divider(),
                  );
                },
                itemCount: data.length,
                itemBuilder: (BuildContext contet, int index) {
                  return GestureDetector(
                    onTap: () {
                      navigate(
                          context,
                          UserDetail(
                            id: data[index].id,
                            title: data[index].title,
                            lastname: data[index].lastName,
                            firstname: data[index].firstName,
                            picture: data[index].picture,
                          ));
                    },
                    child: AllUsers(
                      data: data[index],
                    ),
                  );
                }));
  }
}

class AllUsers extends StatelessWidget {
  final UserHiveList data;

  const AllUsers({required this.data});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CachedNetworkImage(
        imageUrl: data.picture.toString(),
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
            data.title!.toTitleCase().toString(),
            style: GoogleFonts.mulish(
                color: black, fontSize: 14, fontWeight: FontWeight.w700),
          ),
          const XMargin(3),
          Text(
            data.firstName!.toTitleCase().toString(),
            style: GoogleFonts.mulish(
                color: black, fontSize: 14, fontWeight: FontWeight.w700),
          ),
          const XMargin(3),
          Text(
            data.lastName!.toTitleCase().toString(),
            style: GoogleFonts.mulish(
                color: black, fontSize: 14, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:intelligent_inno_task/core/viewModel/userViewModel.dart';
// import 'package:intelligent_inno_task/models/userHiveModel.dart';
// import 'package:intelligent_inno_task/utils/customLoader.dart';
// import 'package:intelligent_inno_task/utils/navigationUtil.dart';
// import 'package:provider/provider.dart';

// import 'detailScreen.dart';
 

// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);

//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   late UsersViewModel userViewModel;

//   @override
//   Widget build(BuildContext context) {
//     userViewModel = context.watch<UsersViewModel>();
//     return Scaffold(
//         body: FutureBuilder(
//             future: userViewModel.getUsers(context),
//             builder: (BuildContext context, AsyncSnapshot snapshot) {
//               // if (!snapshot.hasData) {
//               //   return Loading();
//               // }
//               return ListView.separated(
//                   separatorBuilder: (BuildContext context, int index) {
//                     return Padding(
//                       padding: const EdgeInsets.only(left: 20.0, right: 20),
//                       child: Divider(),
//                     );
//                   },
//                   itemCount:  20,
//                   itemBuilder: (BuildContext context, int index) {
//                     return GestureDetector(
//                         onTap: () {
//                           navigate(
//                               context,
//                               UserDetail(
//                                   // id: data[index].id,
//                                   // title: data[index].title,
//                                   // lastname: data[index].lastName,
//                                   // firstname: data[index].firstName,
//                                   // picture: data[index].picture,
//                                   ));
//                         },
//                         child: ListTile(
//                           leading: Text(snapshot.data[index].id),
//                         ));
//                   });

//               // return Container();
//             }));
//   }
// }
