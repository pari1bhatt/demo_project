import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}




class MyApp extends StatelessWidget {
   const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusManager.instance.primaryFocus!.unfocus();
      },
      child: MaterialApp(
        title: 'Flutter Demo',
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  //
  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  String textLength1 = "0";
  String textLength2 ="0";
  AnimationController? rotationController;
  //
  @override
  void initState() {
    rotationController = AnimationController(duration: const Duration(milliseconds: 500), vsync: this);
    animate();
    controller1.addListener(() {
      setState(() {
        textLength1 = controller1.text.length.toString();
      });
      animate();
    });
    controller2.addListener(() {
      setState(() {
        textLength2 = controller2.text.length.toString();
      });
      animate();
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Test app"),
      ),
      body: ListView(
        children: [
          Column(
            children: <Widget>[
              Row(
                children:  [
                  Flexible(child: TextField(
                    controller: controller1,
                      maxLines: 5,
                      keyboardType: TextInputType.multiline,
                      decoration: const InputDecoration(
                    border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black))
                  ))),
                  Flexible(child: TextField(
                    controller: controller2,
                      maxLines: 5,
                      keyboardType: TextInputType.multiline,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black))
                      ))),
                ],
              ),

              SizedBox(
                height: 400,
                child: Center(
                  child: RotationTransition(
                    turns: Tween(begin: -0.05, end: 0.05).animate(rotationController!),
                    // turns: Tween(begin: 0.0, end: 0.05).animate(rotationController!),
                    // angle: 0.5,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 15),
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.blue),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // SizedBox(
                          //   // height: 40,
                          //   // width: 70,
                          //   child: TextField(
                          //     keyboardType: TextInputType.number,
                          //     maxLength: 3,
                          //     decoration: InputDecoration(
                          //       counterText: "",
                          //       isDense: true,
                          //       filled: true,
                          //         fillColor: Colors.white,
                          //         border: OutlineInputBorder(borderSide: BorderSide(color: Colors.white))
                          //     ),
                          //   )),
                          // SizedBox(
                          //     height: 60,
                          //     width: 60,
                          //     child: TextField())
                          Container(
                            padding: const EdgeInsets.all(5),
                            color: Colors.white,
                            child: Text(textLength1),
                          ),
                          Container(
                            padding: const EdgeInsets.all(5),
                            color: Colors.white,
                            child: Text((textLength2)),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )


            ],
          ),
        ],
      ),
    );
  }

  animate(){
    if(controller1.text.length > controller2.text.length){
      // print("controller1 lenght is more");
      rotationController!.animateTo(0,duration: Duration(milliseconds: 1000),curve: Curves.bounceOut);
    } else if(controller1.text.length < controller2.text.length){
      // print("controller2 lenght is more");
      rotationController!.animateTo(1,duration: Duration(milliseconds: 1000),curve: Curves.bounceOut);
    } else {
      rotationController!.animateTo(0.5,duration: Duration(milliseconds: 1000),curve: Curves.bounceOut);
      // print("length equal");
    }
  }
}
