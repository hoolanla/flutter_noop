import 'package:flutter/material.dart';
import 'package:flutternoop/Model/foods.dart';
import 'package:flutternoop/Json/Network.dart';
import 'package:flutternoop/screen/ShowDetail.dart';
import 'package:intl/intl.dart';
import 'package:flutternoop/Global.dart' as globals;
import 'package:flutternoop/service/AlertForm.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

String _txtTitle;

void main() {
  runApp(LoadFoods());
}

class LoadFoods extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "DETAIL",
      debugShowCheckedModeBanner: false,
      home: new HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;



  @override
  void initState() {
    _tabController = new TabController(length: 3, vsync: this);
    super.initState();
    _txtTitle = 'MENU';
    _getInformation();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Restaurant',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.black,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'Kanit'),
        ),
        bottom: TabBar(
          indicator: UnderlineTabIndicator(
            borderSide: BorderSide(width: 1.0),
            insets: EdgeInsets.only(left: 0.0, right: 8.0, bottom: 4.0),
          ),
          //  isScrollable: true,
          labelPadding: EdgeInsets.only(left: 0, right: 0),

          tabs: [
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: new Tab(
                child: Text(
                  'ALL',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: new Tab(
                child: Text(
                  'RECOMMEND',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: new Tab(
                child: Text(
                  'TAB 3',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ],
          controller: _tabController,
//          indicatorColor: Colors.white,
//          indicatorSize: TabBarIndicatorSize.tab,
        ),
        bottomOpacity: 0.5,
      ),
      body: TabBarView(
        children: [
          Page1(),
          Page2(),
          Page3(),
        ],
        controller: _tabController,
      ),
    );
  }

  Widget Page1() {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          expandedHeight: 100,
          pinned: true,
          floating: false,
          flexibleSpace: new FlexibleSpaceBar(
              title: Text(
                'พอใจอาหารตามสั่ง',
                style: TextStyle(
                    fontFamily: 'Kanit',
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0),
              ),
              background: Container(
                  height: 100.0,
                  width: 420.0,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Colors.black.withOpacity(0.1), Colors.black],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter),
                  ),
                  child: Text(''))),
        ),
        SliverFillRemaining(
          child: FutureBuilder<Menu>(
              future: Network.loadFoodAsset(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data != null) {
                    return new Container(
                      child: _ListSection(menu: snapshot.data),
                    );
                  } else {
                    return Container(
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                              child: CircularProgressIndicator(),
                              height: 10.0,
                              width: 10.0,
                            )
                          ],
                        ),
                      ),
                    );
                  }
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                } else {
                  return Container(
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            child: CircularProgressIndicator(),
                            height: 10.0,
                            width: 10.0,
                          )
                        ],
                      ),
                    ),
                  );
                }
              }),
        )
      ],
    );
  }

  Widget Page2() {
    return Text(
      'This is TAB 2',
      style: TextStyle(fontFamily: 'Kanit'),
    );
  }

  Widget Page3() {
    return Container(
      //   width: 200,
      height: 10,
      child: Card(
        semanticContainer: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: Colors.pink,
        elevation: 5,
        margin: EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const ListTile(
              leading: Icon(Icons.album, size: 70),
              title:
                  Text('Heart Shaker', style: TextStyle(color: Colors.white)),
              subtitle: Text('TWICE', style: TextStyle(color: Colors.white)),
            ),
            ButtonTheme.bar(
              child: ButtonBar(
                children: <Widget>[
                  FlatButton(
                    child: const Text('Edit',
                        style: TextStyle(color: Colors.white)),
                    onPressed: () {},
                  ),
                  FlatButton(
                    child: const Text('Delete',
                        style: TextStyle(color: Colors.white)),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _ListSection({Menu menu}) => ListView.builder(
        itemBuilder: (context, int idx) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: Column(
              children: <Widget>[
                Container(
                  child: new ListTile(
                    leading: Text(menu.data[idx].foodsTypeNameLevel2,
                        style: TextStyle(
                            fontFamily: 'Kanit',
                            color: Colors.black,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold)),

                    // title: Text(menu.data[idx].foodsTypeNameLevel2),
                    trailing: Text(
                      'ทั้งหมด (${menu.data[idx].foodsItems.length})',
                      style: TextStyle(
                          fontFamily: 'Kanit',
                          color: Colors.green,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                ListView.builder(
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 8.0,
                      ),
                      child: ListTile(
                        leading: Container(
                          height: 50,
                          width: 50,
                          child: ClipOval(
                            child: Image.network(
                              menu.data[idx].foodsItems[index].images,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        title: Text(menu.data[idx].foodsItems[index].foodName),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          size: 12,
                        ),
                        onTap: () {
                          print('============ on tab');
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ShowDetail(
                                      imagePath: menu.data[idx].foodsItems[index].images,
                                  price: menu.data[idx].foodsItems[index].price,
                                  name: menu.data[idx].foodsItems[index].foodName,
                                  desc:   menu.data[idx].foodsItems[index].description,
                                    )),
                          );
                        },
                      ),
                    );
                  },
                  itemCount: menu.data[idx].foodsItems.length,
                  shrinkWrap: true,
                  // todo comment this out and check the result
                  physics:
                      ClampingScrollPhysics(), // todo comment this out and check the result
                )
              ],
            ),
          );
        },
        itemCount: menu.data.length,
      );



  void _getInformation() async {

    if (true) {


      String DateTimeformatted1;
      String DateTimeformatted2;

      format(Duration d) => d.toString().split('.').first.padLeft(8, "0");


      final tClose = Duration(hours: 21, minutes: 00); // 21:00 close time
      final tOpen = Duration(hours: 04, minutes: 00); // 04:00 open titme

      var now = new DateTime.now();
      var formatter = new DateFormat('yyyy-MM-dd');
      String Dateformatted = formatter.format(now);

      DateTimeformatted1 = Dateformatted + ' ' + format(tClose);
      DateTimeformatted2 = Dateformatted + ' ' + format(tOpen);
      DateTime dtClose = DateTime.parse(DateTimeformatted1);
      DateTime dtOpen = DateTime.parse(DateTimeformatted2);
      globals.curfew = "0";
      if (["", null, false, 0].contains(globals.showDialogFirstRun))
      {

        globals.showDialogFirstRun = "0";
      }
      if (globals.showDialogFirstRun == "0") {
        globals.showDialogFirstRun == "1";
        WidgetsBinding.instance
            .addPostFrameCallback((_) {
          AlertService tmp = new AlertService(title: 'COVID0-19',desc: 'เนื่องด้วยสถานการณ์โควิดที่เกินขึ้นตอนนี้ APP จะเปิดให้สั่งอาหารได้เฉพาะ ช่วงเวลา 21:00 - 04:00');
          tmp.showAlertFirstRun(context);
        });
      }
    }
    else
    {
      globals.curfew = "0";
    }
  }


}
