import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lab_app/src/page/auth/controller/auth_controller.dart';
import 'package:lab_app/src/page/commom_widgets/custom_text_field.dart';
import 'package:lab_app/src/config/app_data.dart' as app_data;

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  AuthController authController = Get.find<AuthController>();

  Future<bool?> switchPassword() {
    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: Text(
                        "Atualização de Senha",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const CustomTextField(
                      label: "Senha Atual",
                      icon: Icons.lock,
                      isSecret: true,
                    ),
                    const CustomTextField(
                      label: "Nova Senha",
                      icon: Icons.lock_outline,
                      isSecret: true,
                    ),
                    const CustomTextField(
                      label: "Confirmar Nova Senha",
                      icon: Icons.lock_outline,
                      isSecret: true,
                    ),
                    const SizedBox(height: 5),
                    SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: const Text(
                          "Atualizar",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 2,
                right: 2,
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.close),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "Perfil do Usuário",
          style: TextStyle(
            fontSize: 21,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              authController.signOut();
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 15,
        ),
        children: [
          CustomTextField(
            label: "Email",
            icon: Icons.email,
            initialValue: app_data.userModel.email,
            readOnly: true,
          ),
          CustomTextField(
            label: "Nome",
            icon: Icons.person,
            initialValue: app_data.userModel.name,
            readOnly: true,
          ),
          CustomTextField(
            label: "Phone",
            icon: Icons.phone,
            initialValue: app_data.userModel.phone,
            readOnly: true,
          ),
          CustomTextField(
            label: "Bilhete",
            icon: Icons.list,
            initialValue: app_data.userModel.cpf,
            readOnly: true,
            isSecret: true,
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 50,
            child: OutlinedButton(
              onPressed: switchPassword,
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                side: const BorderSide(
                  color: Colors.green,
                  width: 1.2,
                ),
              ),
              child: const Text(
                "Atualizar Senha",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
