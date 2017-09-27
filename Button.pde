class Button {
   float x, y, w, h, r, g, b;
   String txt;
   Boolean selected = false;
  Button(float tx, float ty, float tw, float th, String ttxt,float tr,float tg,float tb) {
      x = tx;
      y = ty;
      w = tw;
      h = th;
      txt = ttxt;
      r = tr;
      g = tg;
      b = tb;
  }
  
  void display() {
     rectMode(CENTER);
     fill(r,g,b);
     rect(x,y,w,h);
     fill(255,255,255);
     textSize(20);
     textAlign(CENTER, CENTER);
     text(txt,x,y);
  }
  
}