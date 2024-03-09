import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lab_app/src/page/auth/controller/auth_controller.dart';
import 'package:lab_app/src/page/auth/view/components/forgot_password.dart';
import 'package:lab_app/src/page/commom_widgets/custom_headline_text.dart';
import 'package:lab_app/src/page/commom_widgets/custom_text_field.dart';
import 'package:lab_app/src/page_route/app_route.dart';
import 'package:lab_app/src/services/utils_services.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  final UtilsServices utilsServices = UtilsServices();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.green,
      body: SingleChildScrollView(
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CustomHeadlineText(color: Colors.white),
                    SizedBox(
                      height: 30,
                      child: DefaultTextStyle(
                        style: const TextStyle(
                          fontSize: 25,
                        ),
                        child: AnimatedTextKit(
                          repeatForever: true,
                          pause: Duration.zero,
                          animatedTexts: [
                            FadeAnimatedText("Frutas"),
                            FadeAnimatedText("Cereais"),
                            FadeAnimatedText("Vegetais"),
                            FadeAnimatedText("Lacticínios"),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(17),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        CustomTextField(
                          label: "Email",
                          icon: Icons.email,
                          controller: emailController,
                          textInput: TextInputType.emailAddress,
                          validator: (email) {
                            if (email!.isEmpty) {
                              return "Digite o seu email";
                            }

                            if (!email.isEmail) {
                              return "Digite um email válido";
                            }

                            return null;
                          },
                        ),
                        CustomTextField(
                          label: "Password",
                          icon: Icons.lock,
                          isSecret: true,
                          controller: passwordController,
                          validator: (password) {
                            if (password!.isEmpty) {
                              return "Digite a sua password";
                            }

                            if (password.length < 7) {
                              return "Digite uma password no minímo com 7 carateres";
                            }
                            return null;
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: SizedBox(
                            height: 50,
                            child: GetX<AuthController>(
                              builder: (authController) {
                                return ElevatedButton(
                                  onPressed: authController.isLoading.value
                                      ? null
                                      : () {
                                          FocusScope.of(context).unfocus();
                                          if (formKey.currentState!
                                              .validate()) {
                                            final email = emailController.text;
                                            final password =
                                                passwordController.text;
                                            authController.signIn(
                                              email: email,
                                              password: password,
                                            );
                                          }
                                          // Get.offNamed(PagesRoutes.baseroute);
                                        },
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(22),
                                    ),
                                  ),
                                  child: authController.isLoading.value
                                      ? const CircularProgressIndicator()
                                      : const Text(
                                          "Entrar",
                                          style: TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                );
                              },
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () async {
                              final bool? result = await showDialog(
                                context: context,
                                builder: (_) {
                                  return ForgotPasswordDialog(
                                    email: emailController.text,
                                  );
                                },
                              );
                              if (result ?? false) {
                                utilsServices.showToast(
                                  label: "Um link foi enviado para o seu email",
                                );
                              }
                            },
                            child: const Text(
                              "Esqueceu a Senha?",
                              style: TextStyle(
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Divider(
                                color: Colors.grey.shade300,
                                thickness: 2,
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 12,
                              ),
                              child: Text("OU"),
                            ),
                            Expanded(
                              child: Divider(
                                color: Colors.grey.shade300,
                                thickness: 2,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 50,
                          child: OutlinedButton(
                            onPressed: () {
                              Get.toNamed(PagesRoutes.signuproute);
                            },
                            style: OutlinedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              side: const BorderSide(
                                color: Colors.green,
                                width: 2,
                              ),
                            ),
                            child: const Text(
                              "Criar Conta",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
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
