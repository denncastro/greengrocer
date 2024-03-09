import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lab_app/src/page/auth/controller/auth_controller.dart';
import 'package:lab_app/src/page/commom_widgets/custom_text_field.dart';
import 'package:lab_app/src/services/validators.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final MaskTextInputFormatter phoneFormatter = MaskTextInputFormatter(
    mask: "********* ***** ",
    filter: {
      "*": RegExp(r"[0-9]"),
    },
  );

  final _formKey = GlobalKey<FormState>();

  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Stack(
        children: [
          Column(
            children: [
              const Expanded(
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Cadastro",
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 25,
                    horizontal: 25,
                  ),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(25),
                    ),
                  ),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          CustomTextField(
                            label: "Email",
                            icon: Icons.email,
                            textInput: TextInputType.emailAddress,
                            validator: emailValidator,
                            onSaved: (value) {
                              authController.user.email = value;
                            },
                          ),
                          CustomTextField(
                            label: "Name",
                            icon: Icons.person,
                            onSaved: (value) {
                              authController.user.name = value;
                            },
                            validator: nameValidator,
                          ),
                          CustomTextField(
                            label: "Password",
                            icon: Icons.lock,
                            onSaved: (value) {
                              authController.user.password = value;
                            },
                            isSecret: true,
                            validator: passwordValidator,
                          ),
                          CustomTextField(
                            label: "CPF",
                            icon: Icons.list_alt_rounded,
                            onSaved: (value) {
                              authController.user.cpf = value;
                            },
                            textInput: TextInputType.number,
                            validator: cpfValidator,
                          ),
                          CustomTextField(
                            label: "Phone",
                            icon: Icons.phone,
                            onSaved: (value) {
                              authController.user.phone = value;
                            },
                            textInput: TextInputType.number,
                            validator: phoneValidator,
                            inputFormatter: [phoneFormatter],
                          ),
                          const SizedBox(height: 5),
                          SizedBox(
                            height: 50,
                            child: Obx(
                              () => ElevatedButton(
                                onPressed: authController.isLoading.value
                                    ? null
                                    : () {
                                        if (_formKey.currentState!.validate()) {
                                          _formKey.currentState!.save();
                                          authController.signUp();
                                        }
                                      },
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                ),
                                child: authController.isLoading.value
                                    ? const CircularProgressIndicator()
                                    : const Text(
                                        "Criar Conta",
                                        style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            top: 4,
            left: 4,
            child: SafeArea(
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
