import 'package:buty/UI/bottom_nav_bar/main_page.dart';
import 'package:buty/UI/component/single_provider_item_row.dart';
import 'package:buty/models/providers_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class SearchByTimeResults extends StatefulWidget{
  final List<AllButicans> data ;
  SearchByTimeResults({this.data});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SearchByTimeResultsState();
  }
  
}

class SearchByTimeResultsState extends State<SearchByTimeResults>{
  @override
  Widget build(BuildContext context) {
      return Container(
        color: Theme.of(context).primaryColor,
        child:SafeArea(
            child: Scaffold(
              appBar: AppBar(
                  automaticallyImplyLeading: false,
                  centerTitle: true,
                  title:Text(translator.translate( "Search By Time Results"),style: TextStyle(fontWeight: FontWeight.normal),
                  ),
                actions: [
                  Padding(padding: EdgeInsets.only(right: 10,left: 10),
                    child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MainPage(
                                    index: 0,
                                  )));
                        },
                        child:  Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                        )),)
                ],),
              body: widget.data ==null ?      Padding(
            padding: const EdgeInsets.symmetric(vertical: 150),
          child: Center(
              child: Text(translator.translate("Sorry, there are no beauticians"))),
        ): Directionality(
                textDirection:  translator.currentLanguage == 'ar' ? TextDirection.rtl : TextDirection.ltr,
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: widget.data.length,
                              itemBuilder: (context, index) {
                                return Padding(padding: EdgeInsets.symmetric(vertical: 5),
                                  child: SingleProviderItemRow(
                                    beautic:widget.data[index],
                                  ),) ;
                              })
                        ],
                      ),
                    ),


                  ],
                ),
              ) ,
            )));
  }
  
}