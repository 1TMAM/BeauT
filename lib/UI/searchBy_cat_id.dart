import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:buty/Bolcs/search_by_category_bloc.dart';
import 'package:buty/UI/component/searchResultItem.dart';
import 'package:buty/helpers/appEvent.dart';
import 'package:buty/helpers/appState.dart';
import 'package:buty/models/search_by_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import 'CustomWidgets/AppLoader.dart';
import 'CustomWidgets/EmptyItem.dart';
import 'bottom_nav_bar/main_page.dart';

class SearchResult extends StatefulWidget {
  final int cat_id;
  final String name;
  final List<BeauticianServices> beauticianServices;

  const SearchResult({Key key, this.cat_id, this.name, this.beauticianServices})
      : super(key: key);

  @override
  _SearchResultState createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => MainPage(),
            ),
                (Route<dynamic> route) => false);
      },
      child: Scaffold(
          appBar: AppBar(
            leading: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                )),
            title: Text(
              "${translator.translate("result")}",
              style: TextStyle(color: Colors.white),
            ),
            centerTitle: true,
          ),
          body: AnimationLimiter(
            child: widget.beauticianServices == null ? Center(
              child: Text("عفوا لا  يوجد  خبراء تجميل"),) : ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: widget.beauticianServices.length,
              itemBuilder: (BuildContext context, int index) {
                return AnimationConfiguration.staggeredList(
                  position: index,
                  duration: const Duration(milliseconds: 375),
                  child: SlideAnimation(
                    verticalOffset: 50.0,
                    child: FadeInAnimation(
                        child: SearchReslutItem(
                          beautic: widget.beauticianServices[index],
                        )),
                  ),
                );
              },
            ),
          )
      ),
    );
  }
}
