import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:notes/componet/drawer.dart';
import 'package:popover/popover.dart';

class HomePages extends StatefulWidget {
  const HomePages({super.key});

  @override
  State<HomePages> createState() => _HomePagesState();
}

class _HomePagesState extends State<HomePages> {
  
  String? name;
  // var  _formkey = GlobalKey<FormState>();
  var _formkey = GlobalKey<FormState>();

  // AlertDialog for createNotes

  void createNotes(){
    showDialog(context: context, builder: (context)=>AlertDialog(
       backgroundColor: Theme.of(context).colorScheme.background,
      content: Form(
          key: _formkey,
          child: TextFormField(
            enableSuggestions: true,
            decoration: const InputDecoration(
              border:OutlineInputBorder() 
            ),
       validator: (input) {
         if(input!.isEmpty){
           return "Pleseas fill the This form";
         }        
       },
       onSaved: (input) {
         name = input;
       },
      ),
     
    ), 
      actions: [
       MaterialButton(
         onPressed: (){
           if(_formkey.currentState!.validate()){
             _formkey.currentState!.save();
             

             FirebaseFirestore.instance
             .collection("contacts").
             add({"name":name});
           }
           Navigator.pop(context); 
         },
         child: const  Text('Create',style: TextStyle(fontWeight: FontWeight.bold),),
         ),
      ],
    )
    );
  }
  @override
  Widget build(BuildContext context) {
     return Scaffold(
       drawer: const MyDrawer(),
      appBar: AppBar(
        title: Center(child: Text("Notes",style: TextStyle(fontSize: 38,color: Theme.of(context).colorScheme.inversePrimary),)),
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        children: [
         
          FutureBuilder(
            future: FirebaseFirestore.instance.collection("contacts").get(),
             builder: (context, snapshot) {
               if(snapshot.connectionState == ConnectionState.waiting){
                 return const Center(
                   child: CircularProgressIndicator(),
                 );
               }else if(snapshot.hasError){
                 return  Center(
                   child: Text("Error",style: TextStyle(
                     fontWeight: FontWeight.bold,
                     color: Theme.of(context).colorScheme.inversePrimary,
                   ),),
                 );
               }
               List  contacts = (snapshot.data!.docs as List);

               return Expanded(

                 // listView to show input

                 child: ListView.builder(
                   itemCount: contacts.length,
                   itemBuilder: (context, index){
                     return Container(
                       decoration: BoxDecoration(
                         color:Theme.of(context).colorScheme.primary,
                         borderRadius: BorderRadius.circular(8),
                       ),
                       margin:const EdgeInsets.symmetric(horizontal: 10),
                       child: Card(
                         
                         child: ListTile(
                           title: Text(contacts[index]["name"],
                           style:const TextStyle(fontWeight: FontWeight.bold),),
                           

                           // this is for showpopover

                           trailing: Builder(builder: (context)=>IconButton(
                             icon:const Icon(Icons.more_vert),
                             onPressed: () => showPopover(
                               width: 100,
                               height: 100,
                               backgroundColor: Theme.of(context).colorScheme.primary,
                              
                              context: context,
                             bodyBuilder: (context) => Column(
                               mainAxisAlignment: MainAxisAlignment.center,
                              children: [

                                // The Edit or update button

                                 GestureDetector(
                                   onTap: () {
                                     Navigator.pop(context);
                                      var id = (contacts[index]as DocumentSnapshot).id;
                                         showAlert(context, contacts[index], id);
                                   },
                                   child: MaterialButton(
                                     hoverColor: Theme.of(context).colorScheme.inversePrimary,
                                       shape: const StadiumBorder(),
                                     onPressed: (){ 
                                       var id = (contacts[index]as DocumentSnapshot).id;
                                         showAlert(context, contacts[index], id);
                                       },child: const Center(child: Text("Edit",style: TextStyle(fontWeight: FontWeight.bold,
                                        color:Color.fromARGB(255, 115, 111, 111),
                                     ),)),),
                                 ),
                            const SizedBox(width: 20,),

                             //The Delete button

                            
                                MaterialButton(
                                 hoverColor: Theme.of(context).colorScheme.inversePrimary,
                                 shape: const StadiumBorder(),
                                 onPressed: (){ 
                                   Navigator.pop(context);
                                   var id = (contacts[index]as DocumentSnapshot).id;
                               showAlert1(context, contacts[index], id);
                               },child:const  Center(child: Text("Delete",style: TextStyle(fontWeight: FontWeight.bold,
                               color:Color.fromARGB(255, 115, 111, 111),
                               ),)),),
                               
                            
                              ],
                            ),
                            ), 
                           ),),
                         
                           
                         ),
                       ),
                     );
                   }
                   ),
               );
             }),
        ],
      ),
      floatingActionButton:  FloatingActionButton(
        onPressed: createNotes,
        backgroundColor: Theme.of(context).colorScheme.primary,
        child:  Icon(Icons.add,
         color: Theme.of(context).colorScheme.inversePrimary,
        )
        
        ),
    );
  }
  // AlertDialog for Edit or update

   showAlert(BuildContext context, var contact, String id){
    TextEditingController nameContraller = TextEditingController();
    nameContraller.text = contact["name"];
    AlertDialog alertDialog = AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.background,
      title:const Center(child:   Text("Update Notes",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)),
      content: Form(
        child: Column(
          mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: nameContraller,
          ),const SizedBox(height: 10,),
          MaterialButton(
            color: Theme.of(context).colorScheme.inversePrimary,
            shape: const StadiumBorder(),
            onPressed: (){
              Navigator.pop(context);
              if(nameContraller.text.isNotEmpty
               ){
                FirebaseFirestore.instance
                .collection("contacts")
                .doc(id)
                .update({
                  "name":nameContraller.text,
                }
                );
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Update Successfully"),));
              }else{
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("name or phone number too short"),));
              }
            },
              child: const Text("Update",style: TextStyle(fontWeight: FontWeight.bold,),),)
        ],
      )
      ),
    );
    showDialog(context: context, builder: (BuildContext context){
      return alertDialog;
    }
    );
  }
   // AlertDialog for Delete button

  showAlert1(BuildContext context, var contact, String id){
    TextEditingController nameContraller = TextEditingController();
    nameContraller.text = contact["name"];
    AlertDialog alertDialog = AlertDialog(
       backgroundColor: Theme.of(context).colorScheme.background,
      title: const Text("Did you want to delect"),
      content: Form(
        child: Column(
          mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: nameContraller,
          ),const SizedBox(height: 10,),
          MaterialButton(
            hoverColor: Theme.of(context).colorScheme.inversePrimary,
            shape: const StadiumBorder(),
            onPressed: (){
              Navigator.pop(context);
              if(nameContraller.text.trim().isNotEmpty
               ){
                FirebaseFirestore.instance
                .collection("contacts")
                .doc(id)
                .delete();
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Delete Successfully"),));
              }else{
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Noting to delect"),));
              }
            },
              child:const  Text("Delect",style: TextStyle(fontWeight: FontWeight.bold),),)
        ],
      )
      ),
    );
    showDialog(context: context, builder: (BuildContext context){
      return alertDialog;
    }
    );
  }
}