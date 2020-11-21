import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'Posts.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<String> chips = [
    'All',
    'General',
    'Discussion',
    'Polling',
    'Travel'
  ];
  Widget _chipTemplate(String text){
    return(
      Chip(
        label: Text(text),
        elevation: 4,
      )
    );
  }
  List<Posts> posts = [
    Posts(post: 'Enjoying a nice summer evening!',author: 'Tim Joe',likes: 32, handle: 'Joey', tag: 'General',liked:false, img : 'https://images.unsplash.com/photo-1508341591423-4347099e1f19?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80'),
    Posts(post: 'EXAMSSS!! Zzzzzz..' , author: 'Lodu Lalit',likes:50, handle: 'lodu' , tag: 'Discussion',liked:false, img : 'https://memetemplatehouse.com/wp-content/uploads/2020/10/brahma-mishra.jpg'),
    Posts(post: 'Ye Bhi theek hai..' , author: 'Robin' ,likes:45, handle:'Roby',tag:'General' ,liked:false, img :'https://in.bmscdn.com/content-buzz/2020/10/priyanshu-painyuli-featured.jpg'),
    Posts(post: 'Gaadi nikaalo Maqbool!' , author : 'Kaleen Tripathi' ,likes:123, handle:'Kaleeen',tag:'travel', liked:false, img:'https://images.firstpost.com/wp-content/uploads/2018/11/mirzapur-3801.jpg')
  ];
  Widget _postTemplate(Posts post){
    return(

        Column(
          children: [

          Card(
            child: ListTile(
              leading: CircleAvatar(
                        backgroundImage: NetworkImage('${post.img}'),
                        radius: 25,
                      ),
                title: Padding(
                  padding: const EdgeInsets.only(top:10.0),
                  child: Row(
                    children: [
                      Text('${post.author} ',style: TextStyle(
                        fontSize: 20
                      ),),
                      Text('@${post.handle}',style: TextStyle(
                        color: Colors.grey
                      ),)
                    ],
                  ),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top:8.0),
                  child: Column(
                    children: [
                      Text('${post.post}',style: TextStyle(
                        fontSize:17,
                      ),),
                      Padding(
                        padding: const EdgeInsets.only(top:8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image(
                            image: NetworkImage('https://i.pinimg.com/originals/cc/18/8c/cc188c604e58cffd36e1d183c7198d21.jpg',

                            ),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon:post.liked?Icon(LineIcons.heart,color: Colors.red,):Icon(LineIcons.heart_o),
                            onPressed: (){
                              setState(() {
                                post.liked = !post.liked;
                                if(post.liked)
                                  post.likes++;
                                else
                                  post.likes--;
                              });
                            },

                          ),

                          Text('${post.likes}'),


                        ],
                      ),
                      Divider(
                        color: Colors.grey,
                        height: 1,
                      ),
                    ],
                  ),
                ),
                trailing: _chipTemplate('${post.tag}'),

              ),
            )

      ],
    )
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEBF2FA),
      body:Column(

        children: [
          SafeArea(
            child: Container(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal:8.0),
                child: Row(

                  children: <Widget>[
                    // IconButton(
                    //   icon: Icon(LineIcons.adjust),
                    //   onPressed: (){},
                    //
                    // ),
                    Image.asset('assets/images/banner_color.png',
                      scale: 4.5,
                    ),
                    SizedBox(width: 160,),
                    IconButton(
                        icon: Icon(LineIcons.search),
                      onPressed: (){},
                    ),
                    CircleAvatar(
                      backgroundImage: NetworkImage('https://images.hdqwalls.com/download/naruto-with-cat-6d-2932x2932.jpg'),
                      radius: 20,

                    ),
                  ],
                ),
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: chips.map((chips) => _chipTemplate(chips)).toList(),
                ),

                    SizedBox(
                      height: 642,
                      width: 400,
                      child: Container(


                        child: ListView.builder(
                          itemCount: posts.length,
                          itemBuilder: (
                            context,index
                          ){
                            return _postTemplate(posts[index]);
                          }
                        ),
                      ),
                    ),

              ],
            ),
          )
        ],
      ),


    );
  }
}
