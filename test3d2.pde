float angle;

Vector[] cubeVertices2;

void keyPressed() {
  setup();
}

void setup() {
  size(800, 800, P3D);
  frameRate(60);
  smooth(8);
  
  cubeVertices2 = new Vector[cubeVertices.length];
  for (int i = 0; i < cubeVertices.length; i++) {
    float[] v = cubeVertices[i];
    cubeVertices2[i] = new Vector(v[0], v[1], v[2]);
  }
  
  angle = 0;
}

void draw() {
  background(0);
  stroke(0, 224, 32);
  strokeWeight(1);
  
  angle += 0.01;
  
  Vector[] cubeVertices3 = new Vector[cubeVertices2.length];
  
  for (int i = 0; i < cubeVertices2.length; i++) {
    Vector v = cubeVertices2[i];
    
    //v = rotate(v, 0, angle);
    v = rotateY(v, angle);
    v = rotateX(v, -PI/4);
    v = translate(v, 0, 0, 2);
    v = projection(v, (float) Math.toRadians(70));
    v = wldToScr(v, height);
    
    cubeVertices3[i] = v;
  }
  
  drawLines(cubeVertices3, cubeIndices);
}

float[][] cubeVertices = {
  { -1, -1, -1 }, // 0
  { -1, -1,  1 }, // 1
  {  1, -1,  1 }, // 2
  {  1, -1, -1 }, // 3
  
  { -1,  1, -1 }, // 4
  { -1,  1,  1 }, // 5
  {  1,  1,  1 }, // 6
  {  1,  1, -1 }, // 7
};

int[][] cubeIndices = {
  { 0, 1 },
  { 1, 2 },
  { 2, 3 },
  { 3, 0 },
  
  { 4, 5 },
  { 5, 6 },
  { 6, 7 },
  { 7, 4 },
  
  { 0, 4 },
  { 1, 5 },
  { 2, 6 },
  { 3, 7 },
};

void drawLines(Vector[] vertices, int[][] indices) {
  for (int i = 0; i < indices.length; i++) {
    int[] indexPair = indices[i];
    Vector v1 = vertices[indexPair[0]];
    Vector v2 = vertices[indexPair[1]];
    line(v1.x, v1.y, v2.x, v2.y);
  }
}

void drawPoints(Vector[] vertices) {
  for (int i = 0; i < vertices.length; i++) {
    Vector v = vertices[i];
    point(v.x, v.y);
  }
}

Vector translate(Vector v, float x, float y, float z) {
  Vector o = new Vector();
  o.x = v.x + x;
  o.y = v.y + y;
  o.z = v.z + z;
  return o;
}

Vector rotate(Vector v, float p, float y) {
  Vector o = new Vector();
  float sp = sin(p);
  float cp = cos(p);
  float sy = sin(y);
  float cy = cos(y);
  o.x = v.x * cp + v.z * sp;
  o.y = (v.z * cp + v.x * -sp) * sy + v.y * -cy;
  o.z = (v.z * cp + v.x * -sp) * cy + v.y * sy;
  return o;
}

Vector rotateX(Vector v, float a) {
  Vector o = new Vector();
  float s = sin(a);
  float c = cos(a);
  o.x = v.x;
  o.y = v.y * c + v.z * -s;
  o.z = v.y * s + v.z *  c;
  return o;
}

Vector rotateY(Vector v, float a) {
  Vector o = new Vector();
  float s = sin(a);
  float c = cos(a);
  o.x = v.x * c + v.z * s;
  o.y = v.y;
  o.z = v.x * -s + v.z * c;
  return o;
}

Vector projection(Vector v, float fov) {
  Vector o = new Vector();
  o.x = v.x / (v.z * tan(fov/2));
  o.y = v.y / (v.z * tan(fov/2));
  return o;
}

Vector wldToScr(Vector v, int height) {
  Vector o = new Vector();
  int cy = height/2;
  o.x = cy - v.x * cy;
  o.y = cy - v.y * cy;
  return o;
}

class Vector {
  float x, y, z;
  public Vector() { }
  public Vector(float x, float y, float z) {
    this.x = x;
    this.y = y;
    this.z = z;
  }
}
