import 'package:buty/Bolcs/search_by_category_bloc.dart';
import 'package:buty/UI/component/searchResultItem.dart';
import 'package:buty/helpers/appEvent.dart';
import 'package:buty/helpers/appState.dart';
import 'package:buty/models/search_by_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import 'CustomWidgets/AppLoader.dart';
import 'CustomWidgets/EmptyItem.dart';

class SearchResult extends StatefulWidget {
  final int cat_id;
  final String name;

  const SearchResult({Key key, this.cat_id, this.name}) : super(key: key);

  @override
  _SearchResultState createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  @override
  void initState() {
    searchByCategoryBloc.updateId(widget.cat_id);
    searchByCategoryBloc.add(Hydrate());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          "${widget.name}",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: BlocListener<SearchByCategoryBloc, AppState>(
        bloc: searchByCategoryBloc,
        listener: (context, state) {},
        child: BlocBuilder(
          bloc: searchByCategoryBloc,
          builder: (context, state) {
            var data = state.model as SearchByCategoryResponse;
            return data == null
                ? AppLoader()
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
                                  beautic: data.data.beauticianServices[index],
                                )),
                              ),
                            );
                          },
                        ),
                      );
          },
        ),
      ),
    );
  }
}
