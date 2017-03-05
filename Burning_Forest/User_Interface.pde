boolean checkBox(boolean getVal, int CBx, int CBy, String CBName) {
  boolean val=getVal;
  noStroke();
  textSize(11);
  if (dist(mouseX, mouseY, CBx, CBy)<10) {
    if (mousePressed && !pmousePressed) {
      if (getVal) {
        val=false;
      } else {
        val=true;
      }
    }
    if (mousePressed) {
      fill(UIColors[2]);
    } else {
      fill(UIColors[1]);
    }
    ellipse(CBx, CBy, 25, 25);
  } else {
    fill(UIColors[0]);
    ellipse(CBx, CBy, 20, 20);
  }
  fill(255);
  text(CBName, CBx+15, CBy-7);
  if (getVal) {
    fill(0);
    ellipse(CBx, CBy, 10, 10);
  }
  return val;
}

boolean button(int Bx, int By, int alignX, int alignY, String BName) {
  boolean val=false;
  float Bwidth=100;
  textSize(11);
  if (textWidth(BName)*1.5>100)Bwidth=textWidth(BName)*1.5;
  if (alignX==CENTER)Bx-=Bwidth/2;
  if (alignY==CENTER)By-=10;
  if (mouseX>Bx && mouseY>By && mouseX<Bx+Bwidth && mouseY<By+20) {
    if (mousePressed) {
      if (!pmousePressed) {
        val=true;
      }
      fill(UIColors[2]);
    } else {
      fill(UIColors[1]);
    }
    Bwidth+=20;
    Bx-=10;
  } else {
    fill(UIColors[0]);
  }
  noStroke();
  rect(Bx, By, Bwidth, 20, 10);
  fill(0);
  textAlign(CENTER, CENTER);
  text(BName, Bx+Bwidth/2, By+8);
  return val;
}