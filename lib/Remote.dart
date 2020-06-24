import 'package:cityapp/Model/countries.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart'as http;
import 'dart:convert';
import 'package:cityapp/Remote.dart';

class Remote extends StatefulWidget{
  @override
  _RemoteState createState() => _RemoteState();
}

class _RemoteState extends State<Remote>{
  Future<List<Countries>> _getCountries() async{
    var empData=await http.get("https://www.delivery-web.tk/api/v1/countries?fbclid=IwAR3E9oTmtj452yaskZMhEdFj_ZbJYSBHxZgzFFNc2YExDISQ3awWoasK4dY");
    var jsonData=json.decode(empData.body);
    List<Countries> countrieses=[];
    for(var d in jsonData)
    {
      Countries cities=Countries(d["id"], d["name"], d["created_at"], d["updated_at"], d["cities"]);
      countrieses.add(cities);
    }
    return countrieses;
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("Arabic Countries"),),
      body: Container(
        child: FutureBuilder(
          future: _getCountries(),
          builder: (BuildContext context, AsyncSnapshot snapshot){
            if(snapshot.data==null)
              {
                return Container( child: Center (child: Text("Loading..."),),

                );

              }else{
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index){

                    return ListTile(

                      title:Text(snapshot.data[index].name),
                      subtitle:Text(snapshot.data[index].department),



                      onTap: (){
                        Navigator.push(context,
                            new MaterialPageRoute(builder: (context) => Cities(snapshot.data[index].id))
                        );
                      },





                    );
                  },
              );
            }
          }
        ),

      ),

    );
  }
}


class Cities extends StatelessWidget{
  final Countries user;

  Cities(this.user);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold (
      appBar: AppBar (
        title: Text(user.name),
      ),
      body: Container(
        child: Center(
          child: Text(this.user.cities),
        ),
      ),
    );
  }

}

