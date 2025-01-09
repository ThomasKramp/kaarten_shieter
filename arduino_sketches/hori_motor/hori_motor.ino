#include <Stepper.h>

#define RED     32 // RED   -> pin 08 -> GPIO 32
#define BLUE    33 // BLUE  -> pin 09 -> GPIO 33
#define GREEN   25 // GREEN -> pin 10 -> GPIO 25
#define BLACK   26 // BLACK -> pin 11 -> GPIO 26
#define ENABLE  27 // EN_H  -> pin 12 -> GPIO 27

Stepper stepper(360, RED, BLUE, GREEN, BLACK);

void setup() {
  pinMode(RED, OUTPUT);
  pinMode(BLUE, OUTPUT);
  pinMode(GREEN, OUTPUT);
  pinMode(BLACK, OUTPUT);
  pinMode(ENABLE, OUTPUT);
  
  digitalWrite(ENABLE, HIGH);
  /*digitalWrite(BLACK, HIGH);
  digitalWrite(GREEN, LOW);
  digitalWrite(BLUE, HIGH);
  digitalWrite(RED, LOW);*/
  stepper.setSpeed(30);
}

void loop() {
  stepper.step(15);
}
