import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reticare/constants.dart';
import 'package:reticare/controllers/object_main_controller.dart';
import 'package:flutter_svg/svg.dart';

import 'progress_bar.dart';
import 'main_question_card.dart';

class MainBody extends StatelessWidget {
  const MainBody({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // So that we have acccess our controller
    ObjectMainQuestionController _questionController = Get.put(ObjectMainQuestionController());
    return Stack(
      children: [
        SvgPicture.asset("assets/icons/bg.svg", fit: BoxFit.fill),
        SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                child: ProgressBar(),
              ),
              SizedBox(height: kDefaultPadding),
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                child: Obx(
                      () => Text.rich(
                    TextSpan(
                      text:
                      "Question ${_questionController.questionNumber.value}",
                      style: Theme.of(context)
                          .textTheme
                          .headline4
                          .copyWith(color: kSecondaryColor),
                      children: [
                        TextSpan(
                          text: "/${_questionController.objquestions.length}",
                          style: Theme.of(context)
                              .textTheme
                              .headline5
                              .copyWith(color: kSecondaryColor),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Divider(thickness: 1.5),
              SizedBox(height: kDefaultPadding),
              Expanded(
                child: PageView.builder(
                  // Block swipe to next qn
                  physics: NeverScrollableScrollPhysics(),
                  controller: _questionController.pageController,
                  onPageChanged: _questionController.updateTheQnNum,
                  itemCount: _questionController.objquestions.length,
                  itemBuilder: (context, index) => MainObjectQuestionCard(
                      question: _questionController.objquestions[index]),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
