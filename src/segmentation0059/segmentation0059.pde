void setup() { 
  size(300, 400); 
  noLoop(); 
}

void draw() {
  PImage img = loadImage("0059.jpg"); 
  PImage imgPB = createImage(img.width, img.height, RGB); 
  PImage seg1 = createImage(img.width, img.height, RGB);
  PImage seg2 = createImage(img.width, img.height, RGB);
  PImage seg = createImage(img.width, img.height, RGB);
  
  // Filtro escala de cinza 
  for (int y = 0; y < img.height; y++) {
    for (int x = 0; x < img.width; x++) { 
      int pos = (y)*img.width + (x); 
      float media = green(img.pixels[pos]);
      imgPB.pixels[pos] = color(media);
    }
  }
  
  image(imgPB, 0, 0); 
  save("imgPB_0059.jpg");
  
  //int pos = mouseY*width + mouseX;
  //float r = red(imgPB.pixels[pos]);
  //float g = green(imgPB.pixels[pos]);
  //float b = blue(imgPB.pixels[pos]);
  
  //text(r+ " " + g + " " + b,mouseX,mouseY);
  
  for (int y = 0; y < img.height; y++) {
    for (int x = 0; x < img.width; x++) { 
      int pos = (y)*img.width + (x); 
       if(green(imgPB.pixels[pos]) < 40) seg1.pixels[pos] = color(255);
       else seg1.pixels[pos] = color(0);
    }
  }
  
  image(seg1, 0, 0); 
  save("seg1_0059.jpg");
  
  for (int y = 0; y < img.height; y++) {
    for (int x = 0; x < img.width; x++) { 
      int pos = (y)*img.width + (x); 
       if(green(imgPB.pixels[pos])   > 195) seg2.pixels[pos] = color(255);
       else seg2.pixels[pos] = color(0);
    }
  }
  
  image(seg2, 0, 0); 
  save("seg2_0059.jpg");
  
  for (int y = 0; y < img.height; y++) {
    for (int x = 0; x < img.width; x++) { 
      int pos = (y)*img.width + (x); 
      if(red(seg1.pixels[pos]) == 255 || red(seg2.pixels[pos]) == 255) {
        seg.pixels[pos] = color(255);
      } else {
        seg.pixels[pos] = color(0); 
      }
    }
  }
  
  image(seg, 0, 0); 
  save("seg_0059.jpg");
 
}
