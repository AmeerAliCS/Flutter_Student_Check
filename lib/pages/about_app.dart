import 'package:flutter/material.dart';
import 'package:students_check/constants.dart';

class AboutApp extends StatelessWidget {
  static const String id = 'about_app';
  const AboutApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          const SizedBox(height: 40.0,),
          const Center(child: Text('Developed By', style: TextStyle(color: kColor, fontSize: 34, fontWeight: FontWeight.bold),)),
          const SizedBox(height: 50.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: const [
                  CircleAvatar(
                    radius: 63,
                    backgroundColor: bColor,
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage: AssetImage('assets/images/students/maryam.jpg'),
                    ),
                  ),
                  Center(child: Text('مريم احمد', style: TextStyle(fontSize: 18.0),)),
                ],
              ),

              Column(
                children: const [
                  CircleAvatar(
                    radius: 63,
                    backgroundColor: bColor,
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage: AssetImage('assets/images/students/mustafa_shakir.jpg'),
                    ),
                  ),
                  Center(child: Text('مصطفى شاكر', style: TextStyle(fontSize: 18.0),))
                ],
              )
            ],
          ),
          const SizedBox(height: 25.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: const [
                  CircleAvatar(
                    radius: 63,
                    backgroundColor: bColor,
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage: AssetImage('assets/images/students/hussain.jpg'),
                    ),
                  ),
                  Center(child: Text('حسين هشام', style: TextStyle(fontSize: 18.0),)),
                ],
              ),

              Column(
                children: const [
                  CircleAvatar(
                    radius: 63,
                    backgroundColor: bColor,
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage: AssetImage('assets/images/students/mohammed_ali.jpg'),
                    ),
                  ),
                  Center(child: Text('محمد علي', style: TextStyle(fontSize: 18.0),))
                ],
              )
            ],
          ),
          const SizedBox(height: 25.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: const [
                  CircleAvatar(
                    radius: 63,
                    backgroundColor: bColor,
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage: AssetImage('assets/images/students/mohammed_sattar.jpg'),
                    ),
                  ),
                  Center(child: Text('محمد ستار', style: TextStyle(fontSize: 18.0),)),
                ],
              ),

              Column(
                children: const [
                  CircleAvatar(
                    radius: 63,
                    backgroundColor: bColor,
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage: AssetImage('assets/images/students/omar.jpg'),
                    ),
                  ),
                  Center(child: Text('عمر عباس', style: TextStyle(fontSize: 18.0),))
                ],
              )
            ],
          ),
          const SizedBox(height: 40.0),
          const Center(child: Text('Supervised By', style: TextStyle(color: kColor, fontSize: 34, fontWeight: FontWeight.bold),)),
          const SizedBox(height: 30.0,),
          const CircleAvatar(
            radius: 63,
            backgroundColor: bColor,
            child: CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage('assets/images/students/yasir.jpg'),
            ),
          ),
          const Center(child: Text('د. ياسر داود', style: TextStyle(fontSize: 18.0),)),
          const SizedBox(height: 50.0,),
        ],
      ),
    );
  }
}
