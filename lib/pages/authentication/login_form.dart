import 'package:emailauthwithfirebase/pages/authentication/registration_from.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {

  bool isLoading = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;


  /// >>> Helper Text & Icon Here
  Icon emailIcon = Icon(Icons.email,color: Colors.grey, size: 15,);
  Icon passIcon = Icon(Icons.password,color: Colors.grey, size: 15,);
  String emailHelperText = "Example : prothes19@gmail.com";
  String passHelperText = "At least 8 chars, Example : Prothes@123";

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login Page"),),
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



                          /// >>> Password Field Start Here ====================
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: "Password",
                              hintStyle: TextStyle(color: Colors.blue),
                              labelText: "Password",
                              labelStyle: TextStyle(color: Colors.grey),
                              floatingLabelStyle: TextStyle(color: Colors.blue),
                              border: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                              focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
                              helper: Row(children: [passIcon, SizedBox(width: 5,), Text(passHelperText,style: TextStyle(color : Colors.grey),)],),
                              suffixIcon: IconButton(
                                icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility, color: Colors.blue,),
                                onPressed: () {
                                  setState(() {_obscurePassword = !_obscurePassword;});
                                },
                              ),
                            ),
                            keyboardType: TextInputType.visiblePassword,
                            maxLength: 22,
                            cursorColor: Colors.blue,
                            controller: passwordController,
                            obscureText: _obscurePassword,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            onChanged: (value){
                              setState(() {
                                if (value.length > 8 && RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[!@#$%^&*{}()\\.+=?/_-]).{8,}$').hasMatch(value)){
                                  passHelperText = "Valid Password";
                                  passIcon = Icon(Icons.verified,color: Colors.green, size: 15,);
                                }else{
                                  passHelperText = "";
                                }
                              });
                            },
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return "Field is Empty";
                              }
                              if (!RegExp(r'[A-Z]').hasMatch(value)) {
                                return "Must contain at least one uppercase letter (A-Z)";
                              }
                              if (!RegExp(r'[a-z]').hasMatch(value)) {
                                return "Must contain at least one lowercase letter (a-z)";
                              }
                              if (!RegExp(r'[0-9]').hasMatch(value)) {
                                return "Must contain at least one number (0-9)";
                              }
                              if (!RegExp(r'[!@#$%^&*{}()\\.+=?/_-]').hasMatch(value)) {
                                return "Must contain at least one Symbol";
                              }
                              if (value.length < 8) {
                                return "Password must be at least 8 characters long";
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 20,),
                          /// <<< Password Field End Here ======================





                          /// >>> Registration Button Start Here ===============
                          ElevatedButton(
                              onPressed: isLoading? null :() async{
                                FocusScope.of(context).unfocus();
                                if(_formKey.currentState!.validate()){
                                  String email = emailController.text.trim();
                                  String password = passwordController.text.trim();
                                  try{
                                    setState(() {isLoading = true;});
                                  }catch(err){
                                    debugPrint("Firebase Error $err");
                                  }
                                }
                              },
                              child: isLoading?Text("Wait.."):Text("Login")
                          ),
                          /// <<< Registration Button End Here =================


                          /// >>> =============== IF You New User So Registration Here =================
                          SizedBox(height: 25,),
                          InkWell(
                            onTap:()=>Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => RegistrationForm()), (Route<dynamic> route) => false,),
                            child: Text("New User? Click Here",style: TextStyle(color: Colors.blue),),
                          )
                          /// <<< =============== IF You New User So Registration Here =================
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
