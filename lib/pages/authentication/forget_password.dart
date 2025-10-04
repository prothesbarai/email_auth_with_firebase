import 'package:emailauthwithfirebase/pages/authentication/login_form.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {

  bool isLoading = false;
  final emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();


  /// >>> Helper Text & Icon Here
  Icon emailIcon = Icon(Icons.email,color: Colors.grey, size: 15,);
  String emailHelperText = "Example : prothes19@gmail.com";

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }


  /// >>> Navigate Login Page
  void _showPopUpAndNavigateLoginPage(){
    showDialog(
        context: context, 
        builder: (context) => AlertDialog(
          title: Text("Reset Password"),
          content: Text("Password reset email sent! Check your email inbox."),
          actions: [
            ElevatedButton(
                onPressed: ()=>Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginForm()), (Route<dynamic> route) => false,),
                child: Text("OK")
            )
          ],
        ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Forget Password"),),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        behavior: HitTestBehavior.opaque,
        child: Stack(
          children: [
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 50.0,left: 10.0,right: 10.0,bottom: 10.0),
                  child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [



                          /// >>> Email Field Start Here =======================
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: "Email",
                              hintStyle: TextStyle(color: Colors.blue),
                              labelText: "Email",
                              labelStyle: TextStyle(color: Colors.grey),
                              floatingLabelStyle: TextStyle(color: Colors.blue),
                              border: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                              focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
                              helper: Row(children: [emailIcon, SizedBox(width: 5,), Text(emailHelperText,style: TextStyle(color : Colors.grey),)],),
                            ),
                            keyboardType: TextInputType.emailAddress,
                            maxLength: 50,
                            cursorColor: Colors.blue,
                            controller: emailController,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            onChanged: (value){
                              setState(() {
                                if (RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(value)){
                                  emailHelperText = "Valid Email";
                                  emailIcon = Icon(Icons.verified,color: Colors.green, size: 15,);
                                }else{
                                  emailHelperText = "";
                                }
                              });
                            },
                            validator: (value){
                              if(value == null || value.trim().isEmpty){
                                return "Field is Empty";
                              }
                              if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(value)){
                                return "Invalid Email";
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 20,),
                          /// <<< Email Field End Here =========================


                          /// >>> Registration Button Start Here ===============
                          ElevatedButton(
                              onPressed: isLoading? null :() async{
                                FocusScope.of(context).unfocus();
                                if(_formKey.currentState!.validate()){
                                  String email = emailController.text.trim();
                                  try{
                                    setState(() {isLoading = true;});
                                    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
                                    setState(() {isLoading = false;});
                                    _showPopUpAndNavigateLoginPage();
                                  }catch(err){
                                    debugPrint("Firebase Error $err");
                                  }
                                }
                              },
                              child: isLoading?Text("Wait.."):Text("Reset Password")
                          ),
                          /// <<< Registration Button End Here =================

                        ],
                      )
                  ),
                ),
              ),
            ),

            if (isLoading)
              Positioned(
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.6),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        CircularProgressIndicator(color: Colors.white),
                        SizedBox(height: 15),
                        Text("Loading...", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold,),),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
