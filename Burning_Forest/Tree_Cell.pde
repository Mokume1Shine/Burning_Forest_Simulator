class TreeCell {
  boolean Fire;    //火があった
  boolean Water;   //水がある（燃えない）
  boolean Burning; //燃えてる最中
  boolean unChange;
  boolean onMouse;
  float Fuel=100;
  int TCX;
  int TCY;
  int saveExtinctionTime;
  TreeCell[][] loadTC;
  int indexX;
  int indexY;
  int Size;
  color rectColor;

  int fromIndexX;
  int fromIndexY;

  TreeCell(boolean tmpWater, int tmpTCX, int tmpTCY, int tmpSize, int getIndexX, int getIndexY) {
    indexX=getIndexX;
    indexY=getIndexY;
    Water=tmpWater;
    TCX=tmpTCX;
    TCY=tmpTCY;
    Size=tmpSize;
  }

  void update(TreeCell[][] getTC) {
    unChange=true;
    loadTC=getTC;
    if (Fire) {
      if (Fuel>0) {
        Fuel-=0.1;
        saveExtinctionTime=frameCount;
      } else {
        Burning=false;
        if (frameCount-saveExtinctionTime>1000) {
          Fire=false;
        }
      }
    } else {
      if (!Water && Fuel>10) {
        for (int jx=-1; jx<=1; jx++) {
          for (int jy=-1; jy<=1; jy++) {
            if (loadTC[indexX+jx][indexY+jy].Burning && loadTC[indexX+jx][indexY+jy].unChange && int(random(1000))==0) {
              putFire();
              unChange=false;
              fromIndexX=indexX+jx;
              fromIndexY=indexY+jy;
            }
          }
        }
      }
      if (Fuel<100) {
        Fuel+=0.01;
      }
    }
    if (mouseX>=TCX && mouseY>=TCY && mouseX<TCX+Size && mouseY<TCY+Size) {
      onMouse=true;
    } else {
      onMouse=false;
    }
  }

  void display(boolean light) {
    noStroke();
    fill(255);
    rect(TCX, TCY, Size, Size);
    if (Fire) {
      if (light) {
        rectColor=color(map(Fuel, 0, 100, 0, 255), 0, 0);
      } else {
        rectColor=color(map(Fuel, 0, 100, 0, 255), 0, 0, map(Fuel, 0, 100, 200, 150));
      }
    } else if (Water) {
      int sumWater=0;
      for (int jx=-1; jx<=1; jx++) {
        for (int jy=-1; jy<=1; jy++) {
          if (loadTC[indexX+jx][indexY+jy].Water && !(jx==0 && jy==0)) {
            sumWater++;
          }
        }
      }
      if (light) {
        rectColor=color(0, 0, 255);
      } else {
        rectColor=color(0, 0, 255, 100+sumWater*5);
      }
    } else {
      if (light) {
        rectColor=color(0, map(Fuel, 0, 100, 0, 200), map(Fuel, 0, 100, 0, 100));
      } else {
        rectColor=color(0, map(Fuel, 0, 100, 0, 200), map(Fuel, 0, 100, 0, 100), map(Fuel, 0, 100, 200, 150));
      }
    }
    fill(rectColor);
    rect(TCX, TCY, Size, Size);
    if (fromIndexX==indexX && fromIndexY==indexY && Burning) {
      if (light) {
        fill(255, 0, 0);
      } else {
        fill(255, 0, 0, 200);
      }
      ellipse(TCX+Size/2, TCY+Size/2, Size*sin(frameCount/100.0)/2, Size*sin(frameCount/100.0)/2);
    }
    if (onMouse) {
      stroke(255);
      noFill();
      rect(TCX, TCY, Size-1, Size-1);
    }
  }

  void displayLine() {
    if (Burning) {
      stroke(255);
      line(TCX+Size/2, TCY+Size/2, loadTC[fromIndexX][fromIndexY].TCX+Size/2, loadTC[fromIndexX][fromIndexY].TCY+Size/2);
    }
  }

  void putFire() {
    Fire=true;
    Burning=true;
    fromIndexX=indexX;
    fromIndexY=indexY;
  }

  void putWater(boolean clear) {
    if (clear) {
      Water=false;
    } else {
      Water=true;
    }
  }
}