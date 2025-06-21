import processing.core.*;

float pathWidth = 200;
float pathHeight = 120;
float pathFloor = -80;
PVector pos = new PVector(0, 0, 0);
PShape arwingModel;
float yaw = 0;
float pitch = 0;
float roll = 0;
float targetYaw = 0;
float targetPitch = 0;
float targetRoll = 0;
float baseSpeed = 5;
boolean left, right, up, down, zKey, xKey;

void settings() {
  size(800, 600, P3D);
}

void setup() {
  pos.z = 0;
  try {
    arwingModel = loadShape("arwing.obj");
  } catch (Exception e) {
    // fall back to placeholder geometry
    arwingModel = null;
  }
}

void draw() {
  background(0);
  handleInput();
  updateMovement();
  PVector camPos = PVector.add(pos, new PVector(0, 10, 40));
  PVector camTarget = PVector.add(pos, new PVector(0, 0, -100));
  camera(camPos.x, camPos.y, camPos.z, camTarget.x, camTarget.y, camTarget.z, 0, 1, 0);

  lights();
  pushMatrix();
  translate(pos.x, pos.y, pos.z);
  scale(4);
  rotateX(radians(pitch));
  rotateY(radians(yaw));
  rotateZ(radians(roll));
  drawShip();
  popMatrix();
}

void handleInput() {
  // input state updated via keyPressed/keyReleased
}

void updateMovement() {
  float stickX = 0;
  if (left) stickX -= 1;
  if (right) stickX += 1;
  float stickY = 0;
  if (up) stickY += 1;
  if (down) stickY -= 1;

  float moveSpeed = 4.0;
  pos.x += stickX * moveSpeed;
  pos.y += stickY * moveSpeed;

  targetYaw = -stickX * 30;
  targetPitch = stickY * 20;
  targetRoll = -stickX * 45;
  yaw = lerp(yaw, targetYaw, 0.15);
  pitch = lerp(pitch, targetPitch, 0.15);
  roll = lerp(roll, targetRoll, 0.15);

  if (zKey) roll -= 15;
  if (xKey) roll += 15;
  pos.z -= baseSpeed;

  pos.x = constrain(pos.x, -pathWidth, pathWidth);
  pos.y = constrain(pos.y, pathFloor, pathHeight);
}

void drawShip() {
  if (arwingModel != null) {
    shape(arwingModel);
  } else {
    fill(150, 150, 255);
    noStroke();
    beginShape(TRIANGLES);
    vertex(0, 0, 30);
    vertex(-10, 0, -30);
    vertex(10, 0, -30);
    endShape();

    beginShape(QUADS);
    vertex(-10, 0, -30);
    vertex(10, 0, -30);
    vertex(5, 5, -40);
    vertex(-5, 5, -40);
    endShape();
  }
}

void keyPressed() {
  if (keyCode == LEFT) left = true;
  if (keyCode == RIGHT) right = true;
  if (keyCode == UP) up = true;
  if (keyCode == DOWN) down = true;
  if (key == 'z' || key == 'Z') zKey = true;
  if (key == 'x' || key == 'X') xKey = true;
}

void keyReleased() {
  if (keyCode == LEFT) left = false;
  if (keyCode == RIGHT) right = false;
  if (keyCode == UP) up = false;
  if (keyCode == DOWN) down = false;
  if (key == 'z' || key == 'Z') zKey = false;
  if (key == 'x' || key == 'X') xKey = false;
}
