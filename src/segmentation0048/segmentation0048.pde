void setup() { 
  size(400, 300); 
  noLoop(); 
}

void draw() {
  PImage img = loadImage("0048.jpg"); 
  PImage segSobel = createImage(img.width, img.height, RGB); 
  PImage segMedia = createImage(img.width, img.height, RGB); 
  PImage segPB = createImage(img.width, img.height, RGB); 
  PImage segLim = createImage(img.width, img.height, RGB); 
  PImage segBB = createImage(img.width, img.height, RGB); 
  
  // Filtro de Sobel
  float[][] sobel_x = {
    {-1, 0, 1},
    {-2, 0, 2},
    {-1, 0, 1}
  };

  float[][] sobel_y = {
    {-1, -2, -1},
    {0, 0, 0},
    {1, 2, 1}
  };

  for (int y = 1; y < img.height - 1; y++) {
    for (int x = 1; x < img.width - 1; x++) {
      float sumx = 0;
      float sumy = 0;

      for (int i = -1; i <= 1; i++) {
        for (int j = -1; j <= 1; j++) {
          int pos = (y + i) * img.width + (x + j);
          float val = red(img.pixels[pos]);
          sumx += sobel_x[i + 1][j + 1] * val;
          sumy += sobel_y[i + 1][j + 1] * val;
        }
      }

      float val = sqrt(sq(sumx) + sq(sumy));
      segSobel.pixels[y * img.width + x] = color(val);
    }
  }

  // Filtro de média 6x6
  for(int y = 0; y < img.height; y++){
    for(int x = 0; x < img.width; x++){
      int pos = y * img.width + x;
      int qtde = 0;
      float media = 0;

      for (int i = -3; i <= 3; i++) {
        for (int j = -3; j <= 3; j++) {
          int newX = x + j;
          int newY = y + i;
          if (newX >= 0 && newX < img.width && newY >= 0 && newY < img.height) {
            media += red(img.pixels[newY * img.width + newX]);
            qtde++;
          }
        }
      }

      media /= qtde;
      segMedia.pixels[pos] = color(media);
    }
  }

  // Convertendo para preto e branco
  for (int y = 0; y < img.height; y++) {
    for (int x = 0; x < img.width; x++) { 
      int pos = y * img.width + x; 
      float media = red(segMedia.pixels[pos]);
      segPB.pixels[pos] = color(media);
    }
  }
  
  // Limearização
  for (int y = 0; y < img.height; y++) {
    for (int x = 0; x < img.width; x++) { 
      int pos = y * img.width + x; 
      if(red(segPB.pixels[pos]) < 100) segLim.pixels[pos] = color(255);
      else segLim.pixels[pos] = color(0); 
    }
  }
  
   // Bouding Box
  for (int y = 0; y < img.height; y++) {
    for (int x = 0; x < img.width; x++) { 
      int pos = y * img.width + x; 
        segBB.pixels[pos] = segLim.pixels[pos];
      if(x < 110 || x > 260 || y < 10) segBB.pixels[pos] = color(0);
    }
  }
  
  // Salvando as imagens
  image(segSobel, 0, 0);
  save("segSobel_0048.jpg");

  image(segMedia, 0, 0);
  save("segMedia_0048.jpg");
  
  image(segPB, 0, 0);
  save("segPB_0048.jpg");
  
  image(segLim, 0, 0); 
  save("segLim_0048.jpg");
  
  image(segBB, 0, 0); 
  save("segBB_0048.jpg");
}
