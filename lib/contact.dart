 import 'package:calamigo/setting.dart';
import 'package:contacts_service/contacts_service.dart';
 import 'package:flutter/material.dart';
 import 'package:flutter/services.dart';
 import 'package:permission_handler/permission_handler.dart';
 import 'package:url_launcher/url_launcher.dart';
 import 'dart:math';
 class AccessContacts extends StatefulWidget {
   @override
   _AccessContactsState createState() => _AccessContactsState();
 }

 class _AccessContactsState extends State<AccessContacts> {
   
   Iterable<Contact> _contacts;
   List<Contact> con=[];
   List<Contact> cont=[];
   var number;
   dynamic result;

   @override
   void initState() {
    super.initState();
    getingContacts(3);
    }

   getrand(con,len){
    cont=[];
    while(cont.length<len)
    { 
      var rng = new Random();
      var len=con.length;
      var ind=rng.nextInt(len);
      var ele=con[ind];
      if(!cont.contains(ele) && ele.phones.length!=0 )
        cont.add(ele);
    }
    return cont;
   }

   getingContacts(res) async {
     PermissionStatus permissionStatus = await _getPermission();
     if (permissionStatus == PermissionStatus.granted) {
       var contacts = await ContactsService.getContacts(
         withThumbnails: false,
         photoHighResolution:false, 
       );
       print("Got contacts");
       setState(() {
         _contacts = contacts;
         con=_contacts.toList();
         getrand(con,res);
       });
     } 
     else {
       throw PlatformException(
         code: 'PERMISSION_DENIED',
         message: 'Access to data denied',
         details: null,
       );
     }
  }
 
   Future<PermissionStatus> _getPermission() async {
    
     PermissionStatus permission = await Permission.contacts.status;
     if (permission != PermissionStatus.granted) {
      await Permission.contacts.request();
      PermissionStatus permission = await Permission.contacts.status;
      return permission;
     } else {
       return permission;
     }
   }

   @override
   Widget build(BuildContext context) {
     return 
          Scaffold(
         backgroundColor: Colors.grey[900],

         //appBar: AppBar(title: Center(child: Text('Calamigo')),
         //),
         body: ListView(
           children: <Widget>[
            SizedBox(height: 85.0),
            Padding(
              padding: EdgeInsets.only(top: 10.0),
              child:Center(
                child: Text('CALAMIGO',
                        style: TextStyle(
                            letterSpacing: 10.0,
                            color: Colors.teal[800],
                            fontFamily: 'Simplifica',
                            fontWeight: FontWeight.bold,
                            fontSize: 50.0)),
              )),
            SizedBox(height: 65.0),
            Container(
              height: MediaQuery.of(context).size.height - 150.0,
              decoration: BoxDecoration(
              color: Colors.grey[900],
              borderRadius: BorderRadius.only(topLeft: Radius.circular(85.0)),
            ),
            child:ListView.separated(
                      separatorBuilder: (context, index) => Divider(
                      thickness: 0.3,
                      color: Colors.teal[800],
                      endIndent: 20.0,
                      indent: 20.0,
                       ),
                     padding: EdgeInsets.only(top:25.0),
                     itemCount: cont?.length ?? 0,
                     itemBuilder: (context, index) {
                       Contact c = cont?.elementAt(index);
                         final number=c.phones.elementAt(0).value;
                         return ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.grey[900],
                            child: Text(c.initials(),style: TextStyle(
                            letterSpacing: 2.0,
                            color: Colors.teal[800],
                            fontFamily: 'Oswald',
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0
                            ))),
                          title: Text(c.displayName??'',style: TextStyle(
                            //letterSpacing: 2.0,
                            color: Colors.white38,
                            fontFamily: 'Oswald',
                            //fontWeight: FontWeight.bold,
                            fontSize: 18.0
                            )
                         ),
                          subtitle: Text(c.phones.elementAt(0).value??'',
                          style: TextStyle(
                           // letterSpacing: 2.0,
                            color: Colors.teal[800],
                            fontFamily: 'Oswald',
                            //fontWeight: FontWeight.bold,
                            //fontSize: 10.0
                            )),
                          trailing: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                             FlatButton(onPressed: () => launch("tel://$number"),
                               child: new Icon(Icons.call,
                               color: Colors.white38,)),
                             FlatButton(onPressed: () => launch("sms://$number"),
                               child:new Icon(Icons.message,
                               color: Colors.white38,),),
                             ]
                           ),
                        );
                     },
                   ),
            )],
         ),
          floatingActionButton: FloatingActionButton(
            highlightElevation: 20.0,
            backgroundColor: Colors.teal,
            onPressed: ()async{
              result = await Navigator.of(context).push(
            new MaterialPageRoute(builder: (context) => new Updaten()));
              var res=result['num'];
              getingContacts(res);
          },
          child:Icon(Icons.settings,
          color: Colors.grey[800],
          size:30.0)),
       
     );
   }
 }