import 'package:buty/UI/CustomWidgets/Carousel.dart';
import 'package:buty/UI/buty_details/buty_details.dart';
import 'package:buty/models/all_providers_response.dart';
import 'package:buty/models/providers_response.dart';
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class SingleProviderItemRow extends StatelessWidget {
  final AllButicans beautic;

  const SingleProviderItemRow({Key key, this.beautic}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ButyDetails(
                      id: beautic.id,
                      name: beautic.beautName,
                  beautician_name: beautic.ownerName,
                  insta_link: beautic.instaLink,
                  reviews: beautic.visits,
                  rate: beautic.totalRate !=null ? beautic.totalRate.value.toDouble() : 0.0,
                  gallery: beautic.gallery,

                    )));
      },
      child: Padding(
        padding: EdgeInsets.only(top: 10,bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                /*   Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[300],
                    image: DecorationImage(
                        fit: BoxFit.cover, image: NetworkImage(beautic.photo))),
                height: MediaQuery.of(context).size.width/2.5,
              ),*/
                beautic.gallery.length==1?  Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.width * 0.6,
            child: Image.network(beautic.gallery[0].photo, fit: BoxFit.fitWidth,
            filterQuality: FilterQuality.high,)

                ):  CustomCarousel(
                  img:  beautic.gallery,
                ),
                Positioned(
                    top: 0,
                    left: 20,
                    child: Container(
                      color: Colors.grey.shade700,
                      width: MediaQuery.of(context).size.width/4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,

                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("${beautic.totalRate==null ? 0.0: beautic.totalRate.value}",
                                style: TextStyle(color: Colors.white),),
                              SizedBox(width: 5,),
                              Icon(Icons.star,color: Theme.of(context).primaryColor,size: 15,),


                            ],
                          ),
                          Text("${beautic.reviewsCount}   ${translator.translate('reviews')}" , style: TextStyle(color: Colors.white),)
                        ],
                      ),
                    ))
              ],
            ),
            Text(
              "${beautic.ownerName}",
              textDirection: TextDirection.ltr,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            beautic.categories ==null || beautic.categories.isEmpty?Container() : Row(
              children: [
                Expanded(
                    flex: 1,
                    child: Text(
                      "${translator.translate( "Categories" )} : ",
                    )),
                Expanded(
                    flex: 3,
                    child:  Container(
                      //   width: MediaQuery.of(context).size.width *0.8,
                      height: MediaQuery.of(context).size.width/8,
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: beautic.categories.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 5),
                              child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  //color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(15),
                                  //shape: BoxShape.circle
                                ),
                                child: Padding(
                                    padding: EdgeInsets.only(left: 5,right: 5),
                                    child:  Image.network(beautic.categories[index].icon,
                                      height: MediaQuery.of(context).size.width * 0.1,
                                      width: MediaQuery.of(context).size.width * 0.1,)

                                  /* Text(translator.currentLanguage =='ar'?  beautic.categories[index].nameAr
                                : beautic.categories[index].nameEn),*/
                                )
                                ,
                              ),
                            );
                          }),
                    ))
                ,
              ],
            ),
            beautic.city==null? Container() : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Expanded(
                    flex: 1,
                    child:  Text(
                      "${translator.translate("service_city")} :",
                    )),
                Expanded(
                    flex: 4,
                    child: Text(
                      "${translator.currentLanguage =='ar'? beautic.city.nameAr : beautic.city.nameEn}",
                    )
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    width:  MediaQuery.of(context).size.width/9,
                    height:  MediaQuery.of(context).size.width/9,
                    child: Center(
                        child: Image.asset(
                          "assets/images/home.png",
                        )),
                  ),)
              ],
            ),
            Divider(),

          ],
        ),
      )
    );
  }
}
