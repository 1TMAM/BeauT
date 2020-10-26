import 'package:buty/Base/AllTranslation.dart';
import 'package:buty/Bolcs/get_all_beutions.dart';
import 'package:buty/UI/CustomWidgets/AppLoader.dart';
import 'package:buty/UI/CustomWidgets/CustomTextFormField.dart';
import 'package:buty/UI/component/single_provider_item_row.dart';
import 'package:buty/UI/searchBy_cat_id.dart';
import 'package:buty/helpers/appEvent.dart';
import 'package:buty/helpers/appState.dart';
import 'package:buty/models/all_providers_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../search_by_address.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    allProvicersBloc.add(Hydrate());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.width / 1.5,
            decoration: BoxDecoration(color: Theme.of(context).primaryColor),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5)),
                      child: CustomTextField(
                        hint: allTranslations.text("search"),
                        icon: Icon(Icons.search),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SearchByAddress()));
                        },
                        child: Card(
                          child: Container(
                              width: MediaQuery.of(context).size.width / 2.3,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                child: Text(allTranslations.text("where")),
                              )),
                        ),
                      ),
                      Card(
                        child: Container(
                            width: MediaQuery.of(context).size.width / 2.3,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              child: Text(allTranslations.text("when")),
                            )),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SearchResult(
                                      cat_id: 1,
                                    )));
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width / 3.3,
                        child: Column(
                          children: [
                            Container(
                              height: 80,
                              child: Center(
                                child: Image.asset(
                                  "assets/images/makeup.png",
                                  width: 50,
                                  height: 50,
                                ),
                              ),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.white),
                            ),
                            Text(
                              allTranslations.text("makeup"),
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SearchResult(
                                      cat_id: 2,
                                    )));
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width / 3.3,
                        child: Column(
                          children: [
                            Container(
                              height: 80,
                              child: Center(
                                child: Image.asset(
                                  "assets/images/hair.png",
                                  width: 50,
                                  height: 50,
                                ),
                              ),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.white),
                            ),
                            Text(
                              allTranslations.text("hair"),
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 3.3,
                      child: Column(
                        children: [
                          Container(
                            height: 80,
                            child: Center(
                              child: Image.asset(
                                "assets/images/nails.png",
                                width: 50,
                                height: 50,
                              ),
                            ),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: Colors.white),
                          ),
                          Text(
                            allTranslations.text("nails"),
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "${allTranslations.text("makeup")} (110)",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          BlocListener<AllProvicersBloc, AppState>(
            bloc: allProvicersBloc,
            listener: (context, state) {},
            child: BlocBuilder(
              bloc: allProvicersBloc,
              builder: (context, state) {
                var data = state.model as AllProvidersResponse;
                return data == null
                    ? AppLoader()
                    : AnimationLimiter(
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: data.beauticians.length,
                          itemBuilder: (BuildContext context, int index) {
                            return AnimationConfiguration.staggeredList(
                              position: index,
                              duration: const Duration(milliseconds: 375),
                              child: SlideAnimation(
                                verticalOffset: 50.0,
                                child: FadeInAnimation(
                                  child: SingleProviderItemRow(
                                    beautic: data.beauticians[index],
                                  ),
                                ),
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
