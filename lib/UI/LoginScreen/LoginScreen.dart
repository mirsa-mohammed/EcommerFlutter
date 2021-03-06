import 'package:ecommerceapi/Bloc/User/Login/login_bloc.dart';
import 'package:ecommerceapi/Bloc/obscureText/obscure_bloc.dart';
import 'package:ecommerceapi/UI/HomeScreen/homeScreen.dart';
import 'package:ecommerceapi/UI/SignUpScreen/ScreenSignUp.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:ecommerceapi/Consatants/colors.dart';
import 'package:ecommerceapi/Consatants/Sizes.dart';
import '../../CustomDesigns/CustomShapeLogin.dart';
import '../Widgets/validation.dart';

class ScreenLogin extends StatelessWidget {
  ScreenLogin({Key? key}) : super(key: key);

  final formKeyLogin = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginLoading) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return const AlertDialog(
                  title: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
            );
          }
          if (state is LoginIncorrect) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return const AlertDialog(
                  title: Center(
                    child: Text('Incorrect Username or Password'),
                  ),
                );
              },
            );
          }

          if (state is LoginLoaded) {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => const ScreenHome(),
                ),
                ModalRoute.withName('/'));
          }
          if (state is LoginError) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return const AlertDialog(
                  title: Center(
                    child: Text('Something went wrong'),
                  ),
                );
              },
            );
          }
        },
        child: Scaffold(
          //To avoid widget resize on keyboard appeares
          resizeToAvoidBottomInset: false,
          body: Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0x7D7D65EC), Colors.blue],
                    begin: FractionalOffset(0.5, 0.0),
                    end: FractionalOffset(0.0, 0.5),
                  ),
                ),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: ClipPath(
                  clipper: Customshape(),

                  //white container its displaying login screen backgraound
                  child: Container(
                    height: MediaQuery.of(context).size.height * .60,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.white,
                  ),
                ),
              ),
              Positioned(
                left: MediaQuery.of(context).size.width / 3,
                top: MediaQuery.of(context).size.width / 7,
                child: Column(
                  children: [
                    Text(
                      'Log In',
                      style: GoogleFonts.oswald(
                        fontSize: 50,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Log    into   your   account',
                      style: GoogleFonts.bebasNeue(
                        color: white05,
                      ),
                    )
                  ],
                ),
              ),
              Positioned(
                bottom: MediaQuery.of(context).size.height * .05,
                left: MediaQuery.of(context).size.width * .10,
                child: Container(
                  width: MediaQuery.of(context).size.width * .80,
                  height: MediaQuery.of(context).size.height * .75,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 8,
                        spreadRadius: 4,
                        offset: Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Form(
                      onChanged: (){formKeyLogin.currentState!.validate();},
                      key: formKeyLogin,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: nameController,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.person),
                              hintText: 'User Name',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            validator: (value) {
                              return validateName(value!);
                            },
                          ),
                          cHeight30,
                          TextFormField(
                            controller: emailController,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.person),
                              hintText: 'Email',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            validator: (value) {
                              return validateEmail(value!);
                            },
                          ),
                          cHeight30,
                          BlocBuilder<ObscureBloc, ObscureState>(
                            builder: (context, state) {
                              return TextFormField(
                                controller: passwordController,
                                obscureText: state.obscurePass,
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.key),
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      BlocProvider.of<ObscureBloc>(context)
                                          .add(obScureTrueFalse());
                                    },
                                    icon: state.obscurePass
                                        ? const Icon(
                                            Icons.remove_red_eye_outlined)
                                        : const Icon(
                                            FontAwesomeIcons.eyeSlash,
                                            size: 20,
                                          ),
                                  ),
                                  hintText: 'Password',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                validator: (value) {
                                  return validatePassword(value!);
                                },
                              );
                            },
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              'Forgot password ?',
                              style: TextStyle(color: cGrey),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * .65,
                            height: MediaQuery.of(context).size.height * .06,
                            child: ElevatedButton(
                              onPressed: () {
                                if (formKeyLogin.currentState!.validate()) {
                                  print("Validated");
                                  BlocProvider.of<LoginBloc>(context).add(
                                      UserLoginEvent(
                                          nameController.text,
                                          emailController.text,
                                          passwordController.text));
                                } else {
                                  print("Not Validated");
                                }
                                return;
                              },
                              child: const Text('Log In'),
                            ),
                          ),
                          cHeight30,
                          Row(
                            children: [
                              Expanded(
                                child: Divider(
                                  color: cGrey,
                                  thickness: 1,
                                ),
                              ),
                              const Text('or'),
                              Expanded(
                                child: Divider(
                                  color: cGrey,
                                  thickness: 1,
                                ),
                              )
                            ],
                          ),
                          cHeight30,
                          Container(
                            width: MediaQuery.of(context).size.width * .65,
                            height: MediaQuery.of(context).size.height * .06,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ElevatedButton(
                              onPressed: () {},
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: const [
                                  Icon(FontAwesomeIcons.google),
                                  Text('LOGIN WITH GOOGLE'),
                                ],
                              ),
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.red),
                              ),
                            ),
                          ),
                          cHeight10,
                          Container(
                            width: MediaQuery.of(context).size.width * .65,
                            height: MediaQuery.of(context).size.height * .06,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ElevatedButton(
                              onPressed: () {},
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: const [
                                  Icon(Icons.facebook),
                                  Text('LOGIN WITH FACEBOOK'),
                                ],
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Dont have an account'),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) => ScreenSignup()),
                                  );
                                },
                                child: const Text('Sign Up'),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
