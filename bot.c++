byte trigPin = 19;
byte echoPin = 18;
byte dir1PinA = 5;
byte dir2PinA = 17;

long duration;
long distance;

void setup() {
  Serial.begin(9600);
  pinMode(dir1PinA, OUTPUT);
  pinMode(dir2PinA, OUTPUT);
  pinMode(trigPin, OUTPUT);
  pinMode(echoPin, INPUT);
}

void loop() {
  digitalWrite(trigPin, LOW);
  delayMicroseconds(2);
  digitalWrite(trigPin, HIGH);
  delayMicroseconds(10);
  digitalWrite(trigPin, LOW);

  duration = pulseIn(echoPin, HIGH);
  distance = duration * 0.034 / 2;

  Serial.print("Distance: ");
  Serial.print(distance);
  Serial.println(" cm");

  if (distance < 10) {
    digitalWrite(dir1PinA, HIGH);
    digitalWrite(dir2PinA, HIGH);
    Serial.println("Motor 1 brake");
  } else {
    digitalWrite(dir1PinA, LOW);
    digitalWrite(dir2PinA, HIGH);
    Serial.println("Motor 1 Forward");
  }

  delay(500);
}
