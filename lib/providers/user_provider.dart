import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutterpractical/models/user_model.dart';
import 'package:http/http.dart' as http;

class UserProvider with ChangeNotifier {
  UserProvider(){
    getUsersList();
  }

  List<User> usersList = new List();

  bool loading = true;
  bool isNoData = false;

  Future getUsersList() async {

    var url = "https://trainer.fmv.cc/api/User/getUsers";
    var type = "";
    var distance = "";
    var latitute = "23.022505";
    var gender = "";
    var keyword = "";
    var ratingSort = "asc";
    var price = "asc";
    var age = "";
    var longitute = "72.5713621";
    var page = "1";
    var user_id = "1";
    var role = "2";
    var ratingFilter = "";
    var sport = "['1']";
    var start_date = "";

    try {

      Map<String, String> headers = {
        "Content-Type": "application/x-www-form-urlencoded"
      };

      var body = {
        'type': type,
        'distance': distance,
        'latitute': latitute,
        'gender': gender,
        'keyword': keyword,
        'ratingSort': ratingSort,
        'price': price,
        'age': age,
        'longitute': longitute,
        'page': page,
        'user_id': user_id,
        'role': role,
        'ratingFilter': ratingFilter,
        'sport': sport,
        'start_date': start_date
      };

      await http.post(url, headers: headers, body: body).then((
          response) {
        if(response.statusCode == 200 && json.decode(response.body)['message'] == "Success"){

          Iterable list = json.decode(response.body)['data'];
          setUsers(list.map((model) => User.fromJson(model)).toList());
          if(usersList.length == 0){
            setEmptyData(true);
          }
          setLoading(false);
        }else{
          print(response.body);
          setLoading(false);
          setEmptyData(true);
        }
        //print(json.decode(response.body));
      });
    }catch (e){
      print(e.toString());
      setLoading(false);
      setEmptyData(true);
    }
  }

  set dataList(List<User> list){
    usersList = list;
    notifyListeners();
  }

  void setLoading(value) {
    loading = value;
    notifyListeners();
  }

  bool isLoading() {
    return loading;
  }

  void setEmptyData(value) {
    isNoData = value;
    notifyListeners();
  }

  bool isEmpty() {
    return isNoData;
  }


  void setUsers(value) {
    usersList = value;
    notifyListeners();
  }

  List<User> getUsers() {
    return usersList;
  }

  void changeFavorite(value,index){
    if(value == "1")
      usersList[index].favorite = "0";
    else
      usersList[index].favorite = "1";
    notifyListeners();
  }

}