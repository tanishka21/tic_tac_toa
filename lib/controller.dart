// ignore_for_file: avoid_print, unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';

class Controller extends GetxController {
  RxList<String> gameValue = ['', '', '', '', '', '', '', '', ''].obs;
  RxBool isX = false.obs;
  RxBool isWinner = false.obs;
  RxInt click = 0.obs;

  void addValue(int index) {
    // ignore: invalid_use_of_protected_member
    // gameValue[index] = "X";
    if (gameValue[index] == "") {
      if (isX.value) {
        gameValue[index] = "X";
        isX.value = !isX.value;
        click++;
      } else {
        gameValue[index] = "O";
        isX.value = !isX.value;
        click++;
      }
    } else {
      Get.snackbar(
        'Invalid Click',
        'You clicked on invalid value',
        duration: Duration(seconds: 2),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.blue,
        colorText: Colors.white,
      );
      print('Invalid Click');
    }
    print(click);
    if (isWinner.value == false) {
      checkDrawMsg(click);
    }
    checkWinner();
  }

  void checkDrawMsg(click) {
    if (click == 9) {
      Get.defaultDialog(
        title: 'Match Draw',
        // cancel: Text('Cancel '),
        confirm: TextButton(
          onPressed: () {
            gameValue.value = ['', '', '', '', '', '', '', '', ''];
            click.value = 0;
            Get.back();
          },
          child: Text('Play Again!!!'),
        ),
        // onConfirm: () {
        //   // gameValue.clear();
        //   gameValue.value = ['', '', '', '', '', '', '', '', ''];
        // },
      );
    }
  }

  void checkWinner() {
    //vertial
    if (gameValue[0] == gameValue[1] &&
        gameValue[0] == gameValue[2] &&
        gameValue[0] != "") {
      print('Winner 1');
      winnerDialogBox();
      return;
    } else if (gameValue[3] == gameValue[4] &&
        gameValue[3] == gameValue[5] &&
        gameValue[3] != "") {
      print('Winner 3');
      winnerDialogBox();
      return;
    } else if (gameValue[6] == gameValue[7] &&
        gameValue[6] == gameValue[8] &&
        gameValue[6] != "") {
      print('Winner 6');
      winnerDialogBox();
      return;
    }
    ///Horizontal
    else if (gameValue[0] == gameValue[3] &&
        gameValue[0] == gameValue[6] &&
        gameValue[0] != "") {
      print('Horizonal Winner 0');
      winnerDialogBox();
      return;
    } else if (gameValue[1] == gameValue[4] &&
        gameValue[1] == gameValue[7] &&
        gameValue[1] != "") {
      print('Horizonal Winner 1');
      winnerDialogBox();
      return;
    } else if (gameValue[2] == gameValue[5] &&
        gameValue[2] == gameValue[8] &&
        gameValue[2] != "") {
      print('Horizonal Winner 2');
      winnerDialogBox();
      return;
    }
    ///Diagonal
    else if (gameValue[0] == gameValue[4] &&
        gameValue[0] == gameValue[8] &&
        gameValue[0] != "") {
      print('Diagonal Winner 0');
      winnerDialogBox();
      return;
    } else if (gameValue[2] == gameValue[4] &&
        gameValue[2] == gameValue[6] &&
        gameValue[2] != "") {
      print('Diagonal Winner 2');
      winnerDialogBox();
      return;
    } else {
      Get.back();
    }
  }

  winnerDialogBox() {
    isWinner.value = true;
    Get.defaultDialog(
      title: 'Winner 🥳',
      content: Column(
        children: [
          Icon(Icons.celebration, size: 50, color: Colors.transparent),
          SizedBox(height: 10),
          isX.value
              ? const Text('O is winner', style: TextStyle(fontSize: 30))
              : const Text('X is winner', style: TextStyle(fontSize: 30)),

          // isX.value
          //     ? const Text('O is winner', style: TextStyle(fontSize: 30))
          //     : const Text('X is winner', style: TextStyle(fontSize: 30)),
          SizedBox(height: 20),
          Row(
            spacing: 10,
            children: [
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  iconColor: Colors.white,
                ),
                onPressed: () {
                  gameValue.value = ['', '', '', '', '', '', '', '', ''];
                  click.value = 0;
                  Get.back();
                },
                icon: Icon(Icons.close),
                label: Text('Close', style: TextStyle(color: Colors.white)),
              ),

              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  iconColor: Colors.white,
                ),
                onPressed: () {
                  gameValue.value = ['', '', '', '', '', '', '', '', ''];
                  click.value = 0;
                  isWinner.value = false;
                  Get.back();
                },
                icon: Icon(Icons.play_arrow),
                label: Text(
                  'Play Again!!!',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
