import 'package:flutter/material.dart';
import 'package:flutternoop/Model/foods.dart';
import 'package:flutternoop/Json/Network.dart';


void main() {
  runApp(CafeCommendPage());
}

class CafeCommendPage extends StatelessWidget {
//  final String restaurantID;
//  final String restaurantName;
//  final String content;
//  final String description;
//  final String images;

//  CafeCommendPage(
//      {this.restaurantID,
//        this.restaurantName,
//        this.content,
//        this.description,
//        this.images});

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "DETAIL",
      debugShowCheckedModeBanner: false,
      home: new HomePage(
//        restaurantID: restaurantID,
//        restaurantName: restaurantName,
//        content: content,
//        description: description,
//        images: images,
      ),
    );
  }
}

class HomePage extends StatefulWidget {
//  final String restaurantID;
//  final String restaurantName;
//  final String content;
//  final String description;
//  final String images;

//  HomePage(
//      {this.restaurantID,
//        this.restaurantName,
//        this.content,
//        this.description,
//        this.images});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
   {


  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(

        backgroundColor: Colors.white,
        title: Text(
          'Test',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),

        bottomOpacity: 1,
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 300.0,
            child: SizedBox(
              height: 200,
              child: FutureBuilder<Menu>(
                  future: Network.loadFoodAsset(
                  ),
                  builder: (context, snapshot) {


                    if (snapshot.hasData) {


                      if (snapshot.data != null) {

                         print('Level1=====' + snapshot.data.ResultOk.toString());

                         print('Level2======' + snapshot.data.data[0].foodsTypeNameLevel2.toString());

                         print('Level3======' + snapshot.data.data[0].foodsItems[0].foodName.toString());



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
            ),
          )


        ]



      ),
      bottomNavigationBar: new BottomAppBar(
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            new IconButton(
                icon: new Icon(Icons.home),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context){}),
                  );
                }),
            //   new IconButton(icon: new Text('SAVE'), onPressed: null),



          ],
        ),
      ),
    );
  }

  // ALL WIDGET

  //List<detailFood> detailFoods = [];


  Widget _ListSection({Menu menu}) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      Expanded(

        child: SizedBox(

          height: 200.0,
          width: 100.0,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, int idx) {

              return Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Column(
                  children: <Widget>[
                    Container(
                      child: new ListTile(
                        leading: Text(menu.data[idx].foodsTypeNameLevel2,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold)),

                        // title: Text(menu.data[idx].foodsTypeNameLevel2),
                        trailing: Text(
                          'ทั้งหมด (${menu.data[idx].foodsItems.length})',
                          style: TextStyle(
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
//                        subtitle: Text(
//                          menu.data[idx].foodsItems[index].price.toString(),
//                        ),
                            onTap: () {

                            },
                          ),
                        );
                      },
                      itemCount: menu.data[idx].foodsItems.length,
                    )
                  ],
                ),
              );
            },
            itemCount: menu.data.length,
          ),
        ),
      ),
    ],
  );



}



