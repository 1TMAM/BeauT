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
                  visits: beautic.visits,
                  rate: beautic.totalRate !=null ? beautic.totalRate.value.toDouble() : 0.0,
                    )));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[300],
                    image: DecorationImage(
                        fit: BoxFit.cover, image: NetworkImage(beautic.photo))),
                height: MediaQuery.of(context).size.width/2.5,
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
                      Icon(Icons.star,color: Colors.yellowAccent,),
                      SizedBox(width: 5,),
                      Text("${beautic.totalRate==null ? 0: beautic.totalRate.value}",
                        style: TextStyle(color: Colors.white),)
                    ],
                  ),
                  Text("${beautic.visits}   ${translator.translate('reviews')}" , style: TextStyle(color: Colors.white),)
                ],
              ),
            ))
            ],
          ),
          Text(
            "${beautic.beautName}",
            textDirection: TextDirection.ltr,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          beautic.services.isEmpty?Container() : Row(
            children: [
              Text(
                "${translator.translate("services")} : ",
              ),
              Container(
                width: MediaQuery.of(context).size.width - 100,
                height: MediaQuery.of(context).size.width/8,
                child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: beautic.services.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Container(
                          width: 25,
                          height: 25,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(
                                      beautic.services[index].icon),
                                  fit: BoxFit.cover),
                              color: Colors.grey[200],
                              shape: BoxShape.circle),
                        ),
                      );
                    }),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              beautic.address==null? Container() : Text(
                "${translator.translate("service_city")} :  ${beautic.address}",
              ),
              Row(
                children: [
                  Container(
                    width:  MediaQuery.of(context).size.width/9,
                    height:  MediaQuery.of(context).size.width/9,
                    decoration: BoxDecoration(
                        color: Colors.grey[200], shape: BoxShape.circle),
                    child: Center(
                        child: Icon(
                      Icons.home,
                      color: Theme.of(context).primaryColor,
                    )),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 10),
                  //   child: Text(
                  //     "${beautic.services[0].location}",
                  //   ),
                  // ),
                ],
              )
            ],
          ),
         Divider(),
        ],
      ),
    );
  }
}
