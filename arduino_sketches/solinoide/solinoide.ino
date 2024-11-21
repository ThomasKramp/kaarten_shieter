uint8_t del = 500;

void setup() {
  pinMode(16, OUTPUT);
  pinMode(18, OUTPUT);
  pinMode(19, OUTPUT);
  digitalWrite(16, HIGH);
  digitalWrite(18, LOW);
  digitalWrite(19, LOW);
}

void loop() {
  digitalWrite(18, HIGH);
  delay(del);
  digitalWrite(18, LOW);
  delay(del);
  digitalWrite(19, HIGH);
  delay(del);
  digitalWrite(19, LOW);
  delay(del);
}
