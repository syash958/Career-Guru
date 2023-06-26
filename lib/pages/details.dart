import 'package:chat_gpt_02/Steps/AcademicDetails.dart';
import 'package:chat_gpt_02/Steps/PersonalDetails.dart';
import 'package:chat_gpt_02/constants/string_constants.dart';
import 'package:chat_gpt_02/pages/automate_results.dart';
import 'package:flutter/material.dart';

class Details extends StatefulWidget {
  const Details({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  int _activeStepIndex = 0;
  TextEditingController nameController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController classController = TextEditingController();
  final formPersonalGlobalKey = GlobalKey<FormState>();
  final formAcademicGlobalKey = GlobalKey<FormState>();
  late PersistentBottomSheetController _modalSheetController;
  bool _open = false;
  String favSubject = 'Maths';

  List<Step> stepList() => [
        Step(
          state: _activeStepIndex <= 0 ? StepState.editing : StepState.complete,
          isActive: _activeStepIndex >= 0,
          title: const Text('Personals'),
          content: PersonalDetails(
              key: UniqueKey(),
              formGlobalKey: formPersonalGlobalKey,
              nameController: nameController,
              cityController: cityController),
        ),
        Step(
          state: _activeStepIndex <= 1 ? StepState.editing : StepState.complete,
          isActive: _activeStepIndex >= 1,
          title: const Text('Academics'),
          content: AcademicDetails(
            key: UniqueKey(),
            classController: classController,
            formGlobalKey: formAcademicGlobalKey,
            favSubject: favSubject,
            onChanged: (String? newValue) {
              setState(() {
                favSubject = newValue!;
              });
            },
          ),
        ),
        Step(
          state: StepState.complete,
          isActive: _activeStepIndex >= 2,
          title: const Text('Confirm'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('Name: ${nameController.text}'),
              Text('City: ${cityController.text}'),
              Text('Class: ${classController.text}'),
              Text('Favourite subject : $favSubject'),
            ],
          ),
        )
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      body: Stepper(
          type: StepperType.vertical,
          currentStep: _activeStepIndex,
          steps: stepList(),
          onStepContinue: () {
            if (_activeStepIndex < (stepList().length - 1)) {
              if (_activeStepIndex == 0 &&
                  formPersonalGlobalKey.currentState!.validate()) {
                formPersonalGlobalKey.currentState!.save();
                setState(() {
                  _activeStepIndex += 1;
                });
              }
              if (_activeStepIndex == 1 &&
                  formAcademicGlobalKey.currentState!.validate()) {
                formAcademicGlobalKey.currentState!.save();
                setState(() {
                  _activeStepIndex += 1;
                });
              }
            } else if (formPersonalGlobalKey.currentState!.validate() &&
                formAcademicGlobalKey.currentState!.validate()) {
              if (!_open) {
                _modalSheetController = _key.currentState!.showBottomSheet(
                  (_) => SizedBox(
                    width: double.maxFinite,
                    child: AutomateResults(
                      requestString: getReq(
                          nameController.text,
                          cityController.text,
                          classController.text,
                          favSubject),
                    ),
                  ),
                );
              } else {
                _modalSheetController.close();
              }
              setState(() => _open = !_open);
            }
          },
          onStepCancel: () {
            if (_activeStepIndex == 0) {
              return;
            }

            setState(() {
              _activeStepIndex -= 1;
            });
          },
          onStepTapped: (int index) {
            setState(() {
              _activeStepIndex = index;
            });
          },
          controlsBuilder: (BuildContext context, ControlsDetails controls) {
            final isLastStep = _activeStepIndex == stepList().length - 1;
            return Column(
              children: [
                const SizedBox(height: 18),
                ElevatedButton(
                  onPressed: controls.onStepContinue,
                  child: (isLastStep)
                      ? formPersonalGlobalKey.currentState!.validate() &&
                              formAcademicGlobalKey.currentState!.validate()
                          ? const Text('Get Suggestions')
                          : const Text('Please complete form')
                      : const Text('Next'),
                ),
                const SizedBox(width: 20),
                if (_activeStepIndex > 0)
                  ElevatedButton(
                    onPressed: controls.onStepCancel,
                    child: const Text('Back'),
                  )
              ],
            );
          }),
    );
  }
}
