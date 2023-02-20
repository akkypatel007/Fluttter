import 'package:flutter/material.dart';
import 'package:rto_app/model/rto_offices_model.dart';
import 'package:url_launcher/url_launcher.dart';

class RtoTile extends StatelessWidget {
  final RTOofficeModel rtOofficeModel;

  RtoTile({required this.rtOofficeModel});

  /*String userTitle() {
    String title = "";
    if (user.gender == "Male") {
      title = "Mr.";
    } else if (user.gender == "Female") {
      title = "Ms.";
    }
    return title;
  }
*/
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.blueGrey[700],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                      child: Text(
                    rtOofficeModel.code!,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  )),
                  height: 40,
                  width: 100,
                ),
                SizedBox(width: 10),
                Text(rtOofficeModel.name!)
              ],
            ),
            SizedBox(height: 10),
            Container(
              width: double.infinity,
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.location_pin),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(rtOofficeModel.address!),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(Icons.phonelink_sharp),
                      SizedBox(width: 8),
                      Expanded(
                        child: InkWell(
                          child: Text(rtOofficeModel.url.toString()),
                          onTap: () async {
                            Uri url = Uri.parse(rtOofficeModel.url.toString());

                            await launchUrl(url);
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(Icons.call),
                      SizedBox(width: 8),
                      InkWell(
                        child: Text(rtOofficeModel.phone!),
                        onTap: () async {
                          var url = Uri.parse("tel:${rtOofficeModel.phone}");
                          await launchUrl(url);
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
    /*Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        children: [
          ListTile(
            leading: Hero(
              tag: rtOofficeModel.name!,
              child: CircleAvatar(
                  // backgroundImage: NetworkImage(user.product),
                  ),
            ),
            title: Text('${rtOofficeModel.name!} ${rtOofficeModel.name!}'),
            //subtitle: Text(user.product_name),
            */
    /*onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      //builder: (context) => UserDetailsPage(user: user)));
            },*/
    /*
          ),
          Divider(
            thickness: 2.0,
          ),
        ],
      ),
    );*/
  }
}
