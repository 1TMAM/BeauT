import 'package:buty/Base/AllTranslation.dart';
import 'package:buty/UI/buty_details/buty_details.dart';
import 'package:buty/models/search_by_category.dart';
import 'package:flutter/material.dart';

class SearchReslutItem extends StatelessWidget {
  final BeauticianServices beautic;

  const SearchReslutItem({Key key, this.beautic}) : super(key: key);

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
                    )));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                  image: DecorationImage(
                      fit: BoxFit.cover, image: NetworkImage(beautic.photo))),
              height: 200,
            ),
            Text(
              "${beautic.beautName}",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Row(
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
                      itemCount: beautic.services.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Container(
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(beautic.services[index].icon),
                                    fit: BoxFit.cover),
                                color: Colors.grey[200],
                                shape: BoxShape.circle),

                          ),
                        );
                      }),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${allTranslations.text("service_address")} : ",
                ),
                Row(
                  children: [
                    Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                          color: Colors.grey[200], shape: BoxShape.circle),
                      child: Center(
                          child: Icon(
                        Icons.home,
                        color: Theme.of(context).primaryColor,
                      )),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        "${beautic.services[0].location}",
                      ),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
