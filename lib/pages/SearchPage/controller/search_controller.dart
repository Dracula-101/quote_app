import 'package:get/get.dart';

class SearchController extends GetxController {
  RxBool isSearched = false.obs;
  toggleSearch() {
    isSearched.value = !isSearched.value;
    update();
  }

  makeTrue() {
    isSearched.value = true;
    update();
  }

  makeFalse() {
    isSearched.value = false;
    update();
  }

  var sampleData = {
    'Helmut Schmidt': "The biggest room in the world is room for improvement",
    'Amy Poehler': "There's power in looking silly and not caring that you do.",
    "Eric Hoffer":
        "In times of change, learners inherit the earth, while the learned find themselves beautifully equipped to deal with a world that no longer exists.",
    "Henry Ford":
        "Whether you think you can or you think you can't, you are right.",
    "Larry Page":
        "If you're changing the world, you're working on important things. You're excited to get up in the morning.",
    "Neil Gaiman":
        "The one thing that you have that nobody else has is you. Your voice, your mind, your story, your vision. So write and draw and build and play and dance and live as only you can.",
  };
}
