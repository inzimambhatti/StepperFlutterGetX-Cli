import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stepper'),
        centerTitle: true,
      ),
      body: Obx(() => Stepper(
            type: StepperType.horizontal,
            steps: buildStep(),
            currentStep: controller.currentStep.value,
            onStepContinue: () {
              if (controller.currentStep.value == buildStep().length - 1) {
                print("Send data to server");
              } else {
                controller.currentStep.value++;
              }
            },
            onStepCancel: () {
              controller.currentStep.value == 0
                  ? null
                  : controller.currentStep.value--;
            },
            onStepTapped: (index) {
              controller.currentStep.value = index;
            },
            controlsBuilder: (context, {onStepContinue, onStepCancel}) {
              return Container(
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        child: Text(controller.currentStep.value==buildStep().length-1?"Submit":"Next"),
                        onPressed: onStepContinue,
                      ),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    if(controller.currentStep.value!=0)
                      Expanded(
                        child: ElevatedButton(
                          child: Text("Previous"),
                          onPressed: onStepCancel,
                        ),
                      ),
                  ],
                ),
              );
            },
          )),
    );
  }

  List<Step> buildStep() {
    return [
      Step(
          title: Text('Personal'),
          content: Container(
            height: 100,
            color: Colors.red,
          ),
          isActive: controller.currentStep.value >= 0,
          state: controller.currentStep.value>0?StepState.complete:StepState.indexed
          ),
          
      Step(
          title: Text('Business'),
          content: Container(
            height: 100,
            color: Colors.green,
          ),
          isActive: controller.currentStep.value >= 1,
          state: controller.currentStep.value > 1
              ? StepState.complete
              : StepState.indexed),
         
      Step(
          title: Text('Confirm'),
          content: Container(
            height: 100,
            color: Colors.deepPurpleAccent,
          ),
          isActive: controller.currentStep.value >= 2)
    ];
  }
}
