uint8_t del = 500;

void setup() {
  pinMode(5, OUTPUT);
  pinMode(16, OUTPUT);
  pinMode(17, OUTPUT);
  digitalWrite(16, HIGH);
  digitalWrite(17, LOW);
}

void loop() {
  digitalWrite(5, HIGH);
  delay(del);
  digitalWrite(5, LOW);
  delay(del);
}
