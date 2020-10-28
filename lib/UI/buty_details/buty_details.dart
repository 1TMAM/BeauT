import 'package:buty/Base/AllTranslation.dart';
import 'package:buty/Bolcs/getBeauticianDetailsBloc.dart';
import 'package:buty/UI/CustomWidgets/AppLoader.dart';
import 'package:buty/UI/CustomWidgets/Carousel.dart';
import 'package:buty/UI/CustomWidgets/CustomButton.dart';
import 'package:buty/UI/bottom_nav_bar/main_page.dart';
import 'package:buty/UI/buty_details/choose_date.dart';
import 'package:buty/helpers/appEvent.dart';
import 'package:buty/helpers/appState.dart';
import 'package:buty/models/BeauticianDetails.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ButyDetails extends StatefulWidget {
  final int id;
  final String name;

  const ButyDetails({Key key, this.id, this.name}) : super(key: key);

  @override
  _ButyDetailsState createState() => _ButyDetailsState();
}

class _ButyDetailsState extends State<ButyDetails> {
  int _current =0;

  @override
  void initState() {
    getBeauticianDetailsBloc.updateId(widget.id);
    getBeauticianDetailsBloc.add(Hydrate());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MainPage(
                              index: 0,
                            )));
              },
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              )),
          centerTitle: true,
          title: Text(
            widget.name ?? "Buty Name",
            style: TextStyle(color: Colors.white, fontSize: 17),
          )),
      body: BlocListener<GetBeauticianDetailsBloc, AppState>(
        bloc: getBeauticianDetailsBloc,
        listener: (context, state) {},
        child: BlocBuilder(
          bloc: getBeauticianDetailsBloc,
          builder: (context, state) {
            var data = state.model as BeauticianDetailsResponse;
            return data == null
                ? AppLoader()
                : ListView(
                    children: [
                      CustomCarousel(img: data.beautician[0].gallery,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          "${widget.name}",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          children: [
                            Text(
                              "${allTranslations.text("services")} : ",
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width - 100,
                              height: 50,
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: data.beautician[0].services.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                      child: Container(
                                        width: 35,
                                        height: 35,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: NetworkImage(data
                                                    .beautician[0]
                                                    .services[index]
                                                    .icon),
                                                fit: BoxFit.cover),
                                            color: Colors.grey[200],
                                            shape: BoxShape.circle),
                                      ),
                                    );
                                  }),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(horizontal: 10),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //     children: [
                      //       Text(
                      //         "${allTranslations.text("service_address")} : ",
                      //       ),
                      //       Row(
                      //         children: [
                      //           Container(
                      //             width: 35,
                      //             height: 35,
                      //             decoration: BoxDecoration(
                      //                 color: Colors.grey[200],
                      //                 shape: BoxShape.circle),
                      //             child: Center(
                      //                 child: Icon(
                      //               Icons.home,
                      //               color: Theme.of(context).primaryColor,
                      //             )),
                      //           ),
                      //           Padding(
                      //             padding: const EdgeInsets.symmetric(
                      //                 horizontal: 10),
                      //             child: Text(
                      //               "${allTranslations.text("at_home")}",
                      //             ),
                      //           ),
                      //         ],
                      //       )
                      //     ],
                      //   ),
                      // ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                            "${allTranslations.text("location")}  : ${data.beautician[0].address}  "),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          "${allTranslations.text("services")}  ",
                        ),
                      ),
                      ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: data.beautician[0].services.length,
                          itemBuilder: (context, index) {
                            return serviceRow(
                                allTranslations.currentLanguage == "ar"
                                    ? data.beautician[0].services[index].nameAr
                                    : data.beautician[0].services[index].nameEn,
                                allTranslations.currentLanguage == "ar"
                                    ? data
                                        .beautician[0].services[index].detailsAr
                                    : data.beautician[0].services[index]
                                        .detailsEn,
                                data.beautician[0].services[index].price,
                                data.beautician[0].services[index]
                                    .estimatedTime,
                                data.beautician[0].services[index].count);
                          }),

                      InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ChooseDate()));
                          },
                          child: CustomButton(
                            text:
                                "${allTranslations.text("choose_time")} 35 ريال",
                          ))
                    ],
                  );
          },
        ),
      ),
    );
  }

  Widget serviceRow(
      String title, String details, String price, String time, int count) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: MediaQuery.of(context).size.width / 2.1,
                child: Row(
                  children: [
                    Text(
                      "${title}",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 2.1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      allTranslations.text("persons"),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.add,
                          size: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Text(
                            "${count}",
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        Icon(
                          Icons.remove,
                          size: 15,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: MediaQuery.of(context).size.width / 2.5,
                child: Text(
                  "${details}  ",
                  style: TextStyle(fontSize: 10),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        children: [
                          Text(
                            "${price} ريال",
                            style: TextStyle(fontSize: 10),
                          ),
                          Text(
                            "${time} دقيقة",
                            style: TextStyle(fontSize: 10),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          allTranslations.text("reserve"),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Icon(
                            Icons.check_circle_outline,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
