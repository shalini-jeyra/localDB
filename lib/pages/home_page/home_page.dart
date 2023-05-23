import 'package:flutter/material.dart';
import 'package:w2s_task/pages/profile_page/profile_page.dart';
import 'package:w2s_task/services/api_service.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key,required this.email});
final String email;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
        backgroundColor: Colors.black,
          bottom: TabBar(
            tabs: [
              Tab(text: 'Home'),
              Tab(text: 'Profile'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
         
           FutureBuilder(
             future: ApiService().getService(),
            builder: (context,snap ){
            
              if(snap.data!=null){
              return ListView.builder(
                itemCount: snap.data.length,
                itemBuilder: (BuildContext context,int index){
                return Column(

                  children: [
                   
                    Container(
                      height: 300,
                      child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemCount: snap.data[index]['im:image'].length,
                        itemBuilder: (BuildContext context,int index1){
                          return Container( height:double.parse(snap.data[index]['im:image'][index1]['attributes']['height']) , decoration: BoxDecoration(
 
    image: DecorationImage(
      
      image: NetworkImage(snap.data[index]['im:image'][index1]['label']),
    ),
  ),);
                        }),
                    ),
                     Text(snap.data[index]['im:name']['label'],style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),textAlign: TextAlign.center,),
                    Divider()
                  ],
                );
              });
              }
              return Center(child: CircularProgressIndicator());
            }),
            
    
          ProfilePage(email: email)
          ],
        ),
      ),
    );
  }
}
