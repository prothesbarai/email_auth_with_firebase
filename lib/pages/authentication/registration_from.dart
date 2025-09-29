import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emailauthwithfirebase/pages/authentication/login_form.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({super.key});

  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {

  bool isLoading = false;
  String? emailError;
  final nameController = TextEditingController();
  final phnNumberController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;
  bool _obscureConfirm = true;


  /// >>> Helper Text & Icon Here
  Icon nameIcon = Icon(Icons.person,color: Colors.grey, size: 15,);
  Icon phoneIcon = Icon(Icons.phone,color: Colors.grey, size: 15,);
  Icon emailIcon = Icon(Icons.email,color: Colors.grey, size: 15,);
  Icon passIcon = Icon(Icons.password,color: Colors.grey, size: 15,);
  Icon conPassIcon = Icon(Icons.password,color: Colors.grey, size: 15,);
  String nameHelperText = "Your Full Name";
  String phoneHelperText = "Example : 01317818826";
  String emailHelperText = "Example : prothes19@gmail.com";
  String passHelperText = "At least 8 chars, Example : Prothes@123";
  String conPassHelperText = "Re-type Password";


  @override
  void dispose() {
    nameController.dispose();
    phnNumberController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }


  /// >>> Navigate Login Page
  void _navigateLoginPage(){
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginForm()), (Route<dynamic> route) => false,);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Registration Form"),),
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

                          /// >>> User Name Field Start Here ================
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: "Full Name",
                              hintStyle: TextStyle(color: Colors.blue),
                              labelText: "Full Name",
                              labelStyle: TextStyle(color: Colors.grey),
                              floatingLabelStyle: TextStyle(color: Colors.blue),
                              border: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                              focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
                              helper: Row(children: [nameIcon, SizedBox(width: 5,), Text(nameHelperText,style: TextStyle(color : Colors.grey),)],),
                            ),
                            keyboardType: TextInputType.text,
                            maxLength: 30,
                            cursorColor: Colors.blue,
                            controller: nameController,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            inputFormatters: [FilteringTextInputFormatter.deny(RegExp(r'[0-9]')),],
                            onChanged: (value){
                              setState(() {
                                if (RegExp(r'^[a-zA-Z\s.)(]+$').hasMatch(value)){
                                  nameHelperText = "Valid Name";
                                  nameIcon = Icon(Icons.verified,color: Colors.green, size: 15,);
                                }else{
                                  nameHelperText = "";
                                }
                              });
                            },
                            validator: (value){
                              if(value == null || value.trim().isEmpty){
                                return "Field is Empty";
                              }

                              if (!RegExp(r'^[a-zA-Z\s.)(]+$').hasMatch(value)){
                                return "Ignore Some Special Symbol";
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 20,),
                          /// <<< User Name Field End Here ==================


                          /// >>> Phone Number Field Start Here ================
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: "Phone Number",
                              hintStyle: TextStyle(color: Colors.blue),
                              labelText: "Phone Number",
                              labelStyle: TextStyle(color: Colors.grey),
                              floatingLabelStyle: TextStyle(color: Colors.blue),
                              border: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                              focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
                              helper: Row(children: [phoneIcon, SizedBox(width: 5,), Text(phoneHelperText,style: TextStyle(color : Colors.grey),)],),
                            ),
                            keyboardType: TextInputType.number,
                            maxLength: 11,
                            cursorColor: Colors.blue,
                            controller: phnNumberController,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            onChanged: (value){
                              setState(() {
                                if (value.length == 11 && RegExp(r'^(01[3-9])[0-9]{8}$').hasMatch(value)){
                                  phoneHelperText = "Valid Phone Number";
                                  phoneIcon = Icon(Icons.verified,color: Colors.green, size: 15,);
                                }else{
                                  phoneHelperText = "";
                                }
                              });
                            },
                            validator: (value){
                              if(value == null || value.trim().isEmpty){
                                return "Field is Empty";
                              }
                              if (!RegExp(r'^[0-9]+$').hasMatch(value)){
                                return "Invalid Number";
                              }
                              value = value.trim().replaceAll('+', '');
                              if (value.length != 11) {
                                return "11 Digit Phone Number";
                              }
                              final pattern = RegExp(r'^(01[3-9])[0-9]{8}$');
                              if (!pattern.hasMatch(value)) {
                                return "Invalid Number";
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 20,),
                          /// <<< Phone Number Field End Here ==================


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
                              errorText: emailError,
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
                                if (value.length >= 8 && RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[!@#$%^&*{}()\\.+=?/_-]).{8,}$').hasMatch(value)){
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


                          /// >>> Confirm Password Field Start Here ============
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: "Confirm Password",
                              hintStyle: TextStyle(color: Colors.blue),
                              labelText: "Confirm Password",
                              labelStyle: TextStyle(color: Colors.grey),
                              floatingLabelStyle: TextStyle(color: Colors.blue),
                              border: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                              focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
                              helper: Row(children: [conPassIcon, SizedBox(width: 5,), Text(conPassHelperText,style: TextStyle(color : Colors.grey),)],),
                              suffixIcon: IconButton(
                                icon: Icon(_obscureConfirm ? Icons.visibility_off : Icons.visibility, color: Colors.blue,),
                                onPressed: () {
                                  setState(() {_obscureConfirm = !_obscureConfirm;});
                                },
                              ),
                            ),
                            keyboardType: TextInputType.visiblePassword,
                            maxLength: 50,
                            cursorColor: Colors.blue,
                            controller: confirmPasswordController,
                            obscureText: _obscureConfirm,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            onChanged: (value){
                              setState(() {
                                if (value == passwordController.text){
                                  conPassHelperText = "Successfully Password Matched";
                                  conPassIcon = Icon(Icons.verified,color: Colors.green, size: 15,);
                                }else{
                                  conPassHelperText = "";
                                }
                              });
                            },
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return "Field is Empty";
                              }
                              if (value != passwordController.text) {
                                return "Password and Confirm Password do not match";
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 20,),
                          /// <<< Confirm Password Field End Here ==============



                          /// >>> Registration Button Start Here ===============
                          ElevatedButton(
                              onPressed: isLoading? null :() async{
                                FocusScope.of(context).unfocus();
                                if(_formKey.currentState!.validate()){
                                  String name = nameController.text.trim();
                                  String phnNumber = phnNumberController.text.trim();
                                  String email = emailController.text.trim();
                                  String password = confirmPasswordController.text.trim();
                                  try{
                                    setState(() {isLoading = true;});
                                    /// >>> Step 1: Register User in Firebase Auth
                                    UserCredential credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
                                    /// >>> Step 2: Get user UID For Saved Extra Data And Navigate
                                    String uid = credential.user!.uid;



                                    await FirebaseFirestore.instance.collection("users").doc(uid).set({
                                      "name": name,
                                      "phone": phnNumber,
                                      "email": email,
                                      "createdAt": FieldValue.serverTimestamp(),
                                    });

                                    setState(() {isLoading = false;});


                                    if(uid.isNotEmpty){
                                      _navigateLoginPage();
                                    }
                                  }on FirebaseAuthException catch(err){
                                    setState(() { isLoading = false; });

                                    if (err.code == 'email-already-in-use') {
                                      setState(() {emailError = "This email is already registered.";});
                                      _formKey.currentState!.validate();
                                    } else {
                                      debugPrint("Error: ${err.message}");
                                    }
                                  }
                                }
                              },
                              child: isLoading?Text("Wait.."):Text("Register")
                          ),
                          /// <<< Registration Button End Here =================



                          /// >>> =============== IF Already His / Her Account Exists so Login Here =================
                          SizedBox(height: 25,),
                          InkWell(
                            onTap:()=>_navigateLoginPage(),
                            child: Text("Already have an account ? Click Here",style: TextStyle(color: Colors.blue),),
                          ),
                          /// <<< =============== IF Already His / Her Account Exists so Login Here =================

                          SizedBox(height: 100,),
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
      )
    );
  }
}
