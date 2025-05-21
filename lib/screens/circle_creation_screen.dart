import 'package:family/components/custom_textformfield.dart';
import 'package:family/components/wide_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CircleCreationScreen extends StatefulWidget {
  CircleCreationScreen({super.key});

  @override
  State<CircleCreationScreen> createState() => _CircleCreationScreenState();
}

class _CircleCreationScreenState extends State<CircleCreationScreen> {
  final circleNameTextEditingController = TextEditingController();
  ValueNotifier<bool> isDisabled = ValueNotifier(true);

  @override
  void initState() {
    super.initState();
    circleNameTextEditingController.addListener(() {
      isDisabled.value = circleNameTextEditingController.text.trim().isEmpty;
    });
  }

  @override
  void dispose() {
    circleNameTextEditingController.dispose();
    isDisabled.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Circle Creation",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              "Upload a cover photo for your circle and write down your circle name.",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(
              height: 40,
            ),
            Container(
                height: 170,
                decoration: BoxDecoration(
                    color: Color(0xfff0f0f0),
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/icons/paper_upload_icon.svg',
                        width: 32,
                        height: 32,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        "Upload cover photo",
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      //TODO: found Inter font in figma but used Urbanist
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        "Select JPG, JPEG or PNG image",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      //TODO: found Inter font in figma but used Urbanist
                    ],
                  ),
                )),
            const SizedBox(
              height: 20,
            ),
            CustomTextFormField(
              labelText: 'Type your circle name',
              prefixIconPath: 'assets/icons/circle_icon.svg',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Field cannot be empty'; // triggers errorBorder
                }
                return null;
              },
              textEditingController: circleNameTextEditingController,
            ),
            const SizedBox(
              height: 50,
            ),
            ValueListenableBuilder(
              valueListenable: isDisabled,
              builder: (context, disabled, child) {
                return WideButton(title: 'Create', disabled: disabled, onTap: () {});
              }
            )
          ],
        ),
      ),
    );
  }
}
