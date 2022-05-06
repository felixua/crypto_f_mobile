import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);

  Widget buildListTile(BuildContext ctx, String title, String titleShort,
      void Function() tapHandler) {
    return ListTile(
      dense: true,
      minLeadingWidth: 10.0,
      leading: Padding(
        padding: const EdgeInsets.all(2.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          clipBehavior: Clip.hardEdge,
          child: Container(
            width: 40.0,
            height: 20.0,
            alignment: Alignment.center,
            color: Theme.of(ctx).primaryColor,
            child: Text(
              titleShort,
              style:
                  TextStyle(fontSize: 14, color: Theme.of(ctx).backgroundColor),
            ),
          ),
        ),
      ),
      title: Text(
        title,
        style: TextStyle(fontSize: 16, color: Theme.of(ctx).primaryColorLight),
      ),
      onTap: tapHandler,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(children: <Widget>[
        const SizedBox(
          height: 30,
        ),
        Container(
          width: double.infinity,
          height: 40,
          alignment: Alignment.center,
          child: const Text(
            "Crypto Fucking Sheet",
            style: TextStyle(
              fontWeight: FontWeight.w900,
              color: Colors.black,
              fontSize: 16,
            ),
          ),
        ),
        buildListTile(context, "Bitcoin", "BTC", () {
          print("test");
        }),
        buildListTile(context, "Ethereum", "ETH", () {}),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              TextButton.icon(
                style: TextButton.styleFrom(
                    minimumSize: const Size(30, 30),
                    padding: const EdgeInsets.all(0.0),
                    alignment: Alignment.center),
                icon: const Icon(
                  Icons.add,
                  size: 18,
                ),
                label: const Text(""),
                onPressed: () {},
              ),
              TextButton.icon(
                style: TextButton.styleFrom(
                  minimumSize: const Size(30, 30),
                  padding: const EdgeInsets.all(2.0),
                  alignment: Alignment.center,
                ),
                icon: const Icon(
                  Icons.remove,
                  size: 18,
                ),
                label: const Text(""),
                onPressed: () {},
              ),
            ],
          ),
        ),
        const Divider(height: 10.0, color: Colors.grey),
        ListTile(
          minLeadingWidth: 10.0,
          leading: const Icon(
            Icons.exit_to_app,
            size: 20.0,
          ),
          title: Text(
            "Sign Out",
            style: TextStyle(
                fontSize: 16, color: Theme.of(context).primaryColorLight),
          ),
          onTap: () {},
        ),
      ]),
    );
  }
}
