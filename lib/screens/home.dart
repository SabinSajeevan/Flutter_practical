import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterpractical/providers/user_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Widget userDetailsWidget(type,image,text){
  return Row(
    children: <Widget>[
      type == "image" ? image == "" ? new Container() :
      Image.network(
        image,
        height: 20.0,
        fit: BoxFit.cover,) : Icon(image,size: 20,color: Colors.grey,),
      SizedBox(
        width: 8.0,
      ),
      Text(text,style: TextStyle(color: Colors.black87.withOpacity(0.7),fontSize: type == "image" ? 17.0 : 15.0,fontWeight: FontWeight.w500),)
    ],

  );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: new IconThemeData(color: Colors.black),
        title: Image.asset("images/logo.png"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.location_on),
            onPressed: (){},
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: (){},
          )
        ],
      ),
        drawer: Drawer(),
        body: Consumer<UserProvider>( //                    <--- Consumer
        builder: (context, userModel, child) {
          return userModel.isLoading() ? Center(
            child: CupertinoActivityIndicator(radius: 20.0),
          ) : userModel.isEmpty() ? Center(
            child: Text("No Users Yet!"),
          ):
            ListView.builder(
              itemCount: userModel.getUsers().length,
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              itemBuilder: (context,index){
                return Card(
                        elevation:2,
                        color:Colors.white,
                        margin: EdgeInsets.symmetric(vertical: 10.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                    child: InkWell(
                        borderRadius: BorderRadius.circular(10.0),
                      onTap: (){},
                      child:
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Stack(
                          children: <Widget>[
                            ClipRRect(
                              child:FadeInImage.assetNetwork(
                                placeholder: 'images/placeholder.png',
                                image: userModel.getUsers()[index].image,
                                height: 170.0,
                                width: double.maxFinite,
                                fit: BoxFit.cover,),
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0),topRight: Radius.circular(10.0)),
                            ),
                            Positioned(
                              top: 0.0,
                              right: 0.0,
                              child: Material(
                                color: Colors.transparent,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(50.0),
                                child: Container(
                                  padding: EdgeInsets.all(15.0),
                  alignment: Alignment.center,
                  child : Icon(userModel.getUsers()[index].favorite == "1" ? Icons.favorite : Icons.favorite_border,color: Colors.red,),
                  ),
                                onTap: (){
                                  userModel.changeFavorite(userModel.getUsers()[index].favorite, index);
                                },
                              ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 6.0,),
                        Text(
                            userModel.getUsers()[index].firstname,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w500),
                        ),
                        SizedBox(height: 6.0,),
                        Padding(
                          padding: EdgeInsets.only(left: 10.0,top: 15.0,bottom: 10.0,right: 10.0),
                          child: Column(
                            children: <Widget>[
                              userDetailsWidget("image", userModel.getUsers()[index].tag_image, userModel.getUsers()[index].tag_name == "" ? userModel.getUsers()[index].service_type_name : "${userModel.getUsers()[index].tag_name} - ${userModel.getUsers()[index].service_type_name}"),
                              SizedBox(height: 10.0,),
                              userDetailsWidget("icon",Icons.calendar_today, userModel.getUsers()[index].date),
                              SizedBox(height: 10.0,),
                              userDetailsWidget("icon",Icons.location_on,userModel.getUsers()[index].location),
                              SizedBox(height: 6.0,),
                          Row(
                            children: <Widget>[
                              Container(
                                  padding: EdgeInsets.symmetric(horizontal: 6.0,vertical: 5.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.0),
                                    color: Colors.green,
                                  ),
                                  child: Row(
                                children: <Widget>[
                                  Text(double.parse(userModel.getUsers()[index].rating).toString(),style: TextStyle(color: Colors.white),),
                                  SizedBox(width: 5.0,),
                                  Icon(Icons.star,color: Colors.white,size: 20,)
                                ],
                              )
                              ),
                        ],
                        )
                            ],
                          ),
                        ),
                        userModel.getUsers()[index].is_certified == "1" ? Container(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10.0),bottomRight: Radius.circular(10.0)),
                            color: Color.fromRGBO(241, 191, 65, 1),
                          ),
                          child: Text("Certified",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 17),),
                        ) : new Container()
                      ],
                    )
                    )
                );
              },
          );
        },
      )
    );
  }
}