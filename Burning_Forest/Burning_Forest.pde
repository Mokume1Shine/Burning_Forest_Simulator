TreeCell[][] tc;
int CellSize=15;
boolean Lines;
boolean lightMode=false;
boolean pmousePressed;
color[] UIColors={color(255), color(200), color(150)};

void setup() {
  size(750, 600);
  if (width-height!=150)exit();
  tc=new TreeCell[height/CellSize+2][height/CellSize+2];
  worldGenerator();
}

void draw() {
  background(0);
  for (int ix=1; ix<tc.length-1; ix++) {
    for (int iy=1; iy<tc[0].length-1; iy++) {
      tc[ix][iy].update(tc);
      tc[ix][iy].display(lightMode);
      if (tc[ix][iy].onMouse) {
        if (mousePressed && !pmousePressed) {
          if (mouseButton==LEFT && !tc[ix][iy].Water) {
            tc[ix][iy].putFire();
          } else if (mouseButton==RIGHT && !tc[ix][iy].Fire) {
            if (tc[ix][iy].Water) {
              tc[ix][iy].Water=false;
            } else {
              tc[ix][iy].Water=true;
            }
          }
        }
      }
    }
  }
  if (Lines) {
    for (int ix=1; ix<tc.length-1; ix++) {
      for (int iy=1; iy<tc[0].length-1; iy++) {
        tc[ix][iy].displayLine();
      }
    }
  }
  textAlign(LEFT, TOP);
  fill(255);
  text("fps:"+int(frameRate), width-140, 0);
  Lines=checkBox(Lines, width-130, 50, "View Fire Lines");
  lightMode=checkBox(lightMode, width-130, 80, "Light Mode");
  if (button(width-75, 100, CENTER, TOP, "World Regenerate"))worldGenerator();
}

void worldGenerator() {
  noiseSeed(int(random(100000)));
  for (int ix=0; ix<tc.length; ix++) {
    for (int iy=0; iy<tc[0].length; iy++) {
      boolean tmpWater=false;
      if (noise(ix/10.0, iy/10.0)+random(0.1)>0.7) {
        tmpWater=true;
      }
      tc[ix][iy]=new TreeCell(tmpWater, (ix-1)*CellSize, (iy-1)*CellSize, CellSize, ix, iy);
    }
  }
}