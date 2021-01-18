import 'package:flutter/material.dart';

class Updaten extends StatefulWidget {
  @override
  _UpdatenState createState() => _UpdatenState();
}

class _UpdatenState extends State<Updaten> {
  List<int> numbers=[2,3,4,5,6];
  var temp;
  void updatenum(index) async{
   
    var number=numbers[index];
    Navigator.pop(context,{
      'num':number});

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
        backgroundColor: Colors.grey[900],
        appBar: AppBar(
          backgroundColor:Colors.teal[600],
          centerTitle:true,
          title:Text('CHOOSE NUMBER',
          style: TextStyle(
            fontFamily: 'Oswald',
            color: Colors.grey[900]
            
          ),)
        ),
         

        body: Padding(
          padding: const EdgeInsets.all(25.0),
          child: ListView.builder(
            itemCount: numbers.length,
            itemBuilder: (context,index){
                temp=numbers.elementAt(index);
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    color: Colors.grey[900],
                    
                    shape:CircleBorder(
                      side: BorderSide(
                        color:Colors.teal
                      )
                    ),
                    child: Padding( 
                      padding: const EdgeInsets.all(5.0),
                      child: ListTile(
                        onTap: (){
                          updatenum(index);
                        },
                        title:Center(child:Text('$temp',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontFamily: 'Oswald',
                          color: Colors.white38
                        ),),),
                      ),
                    ),

                  ),
                );
            }
            ),
        ),
      ),
    );
  }
}