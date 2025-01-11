#include <ESP32Servo.h>

Servo myservo;  // create servo object to control a servo
// twelve servo objects can be created on most boards
int pos = 0;    // variable to store the servo position

void setup() {
  Serial.begin(115200);
  myservo.attach(2);  // attaches the servo on pin 9 to the servo object
}

void loop() {
  go_down();
  //myservo.write(90);
  delay(1000);
}
// 144 is top
// 108 is bottom

void go_up() {
  for (pos = 0; pos <= 180; pos += 3) {
    Serial.print("Angle:\t"); Serial.println(pos);
    myservo.write(pos);
    delay(1000);
  }
}

void go_down() {
  for (pos = 120; pos >= 0; pos -= 3) {
    Serial.print("Angle:\t"); Serial.println(pos);
    myservo.write(pos);
    delay(1000);
  }
}
