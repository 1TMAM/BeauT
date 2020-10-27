import 'package:buty/Base/AllTranslation.dart';
import 'package:buty/Bolcs/search_by_address_bloc.dart';
import 'package:buty/Bolcs/search_by_time_bloc.dart';
import 'package:buty/UI/CustomWidgets/CustomTextFormField.dart';
import 'package:buty/helpers/appEvent.dart';
import 'package:buty/helpers/appState.dart';
import 'package:buty/models/search_by_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import 'CustomWidgets/AppLoader.dart';
import 'CustomWidgets/EmptyItem.dart';
import 'component/searchResultItem.dart';

class SearchByTime extends StatefulWidget {
  @override
  _SearchByTimeState createState() => _SearchByTimeState();
}

class _SearchByTimeState extends State<SearchByTime> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Image.asset(
            "assets/images/header.png",
            fit: BoxFit.contain,
            width: 100,
            height: 30,
          )),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5)),
                child: CustomTextField(
                  hint: "${allTranslations.text("enter_time")}",
                  value: (String val) {
                    print(val);
                    searchByAddressBloc.updateAddress(val);
                  },
                  icon: InkWell(
                      onTap: () {
                        print("CliCCKKK");

                        searchByTimeBloc.add(Hydrate());
                      },
                      child: Icon(Icons.search)),
                )),
          ),
          BlocListener<SearchByTimeBloc, AppState>(
            bloc: searchByTimeBloc,
            listener: (context, state) {},
            child: BlocBuilder(
              bloc: searchByTimeBloc,
              builder: (context, state) {
                var data = state.model as SearchByCategoryResponse;
                return data == null
                    ? EmptyItem(text: data==null ?"${allTranslations.text("enter_location")}" :data.msg,)
                    : data.data == null
                    ? Center(
                    child: EmptyItem(
                      text: data.msg,
                    ))
                    : AnimationLimiter(
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: data.data.beauticianServices.length,
                    itemBuilder: (BuildContext context, int index) {
                      return AnimationConfiguration.staggeredList(
                        position: index,
                        duration: const Duration(milliseconds: 375),
                        child: SlideAnimation(
                          verticalOffset: 50.0,
                          child: FadeInAnimation(
                              child: SearchReslutItem(
                                beautic:
                                data.data.beauticianServices[index],
                              )),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
