import 'package:buty/Base/AllTranslation.dart';
import 'package:buty/models/providers_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import 'bottom_nav_bar/main_page.dart';
import 'component/single_provider_item_row.dart';

class SearchResult extends StatefulWidget {
  final String name;
  final List<AllButicans> beauticianServices;

  const SearchResult({Key key, this.name, this.beauticianServices})
      : super(key: key);

  @override
  _SearchResultState createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => MainPage(),
            ),
            (Route<dynamic> route) => false);
      },
      child: Directionality(
        textDirection: allTranslations.currentLanguage =="ar"?TextDirection.rtl :TextDirection.ltr ,
        child: Scaffold(
            appBar: AppBar(
              actions: [
                Padding(padding: EdgeInsets.only(right: 10,left: 10),
                  child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child:  Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                      )),)
              ],
              title: Text(
                "${translator.translate("result")}",
                style: TextStyle(color: Colors.white),
              ),
              centerTitle: true,
            ),
            body: AnimationLimiter(
              child: widget.beauticianServices == null
                  ? Center(
                      child: Text("عفوا لا  يوجد  خبراء تجميل"),
                    )
                  : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
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
                                  child: SingleProviderItemRow(
                                beautic: widget.beauticianServices[index],
                              )),
                            ),
                          );
                        },
                      ),
                  ),
            )),
      ),
    );
  }
}
