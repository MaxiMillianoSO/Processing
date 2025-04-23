int stangry = 0; 
PFont f;
String[] menu = {"Rozpocznij gre", "Jak grac", "Wyjscie"};
int wybmenu = 0;
int gwiazdki = 100;
float[] gwiazdX = new float[gwiazdki];
float[] gwiazdY = new float[gwiazdki];
float[] gwiazdszyb = new float[gwiazdki];

int lplanet = 3;
float[] planetX = new float[lplanet];
float[] planetY = new float[lplanet];
float[] planetszyb = new float[lplanet];

int laster = 10;
float[] asteroidX = new float[laster];
float[] asteroidY = new float[laster];
float[] asteroidszyb = new float[laster];

int lwrog = 5;
int lbazwrog = 5;
float[] wrogX;
float[] wrogY;
boolean[] wrogakt;
int wrogpzyciu;

int llaserwrog = 10;
float[] wroglaserX = new float[llaserwrog];
float[] wroglaserY = new float[llaserwrog];
boolean[] aktlaserwrog = new boolean[llaserwrog];
int indlaserwrog = 0;
int wroglasercooldown = 0;

float statekX;
float statekY;
float statekszyb = 2.5;
boolean ostrzstatek = true;
int lasercooldown = 0;

int llaser = 5;
float[] laserX = new float[llaser];
float[] laserY = new float[llaser];
boolean[] aktlaser = new boolean[llaser];
int indlaser = 0;

float wybuchX, wybuchY;
boolean aktwybuch = false;
int wybuchczas = 0;

int punkty = 0;
int finpunkty = 0;

void setup() {
  size(800, 600);
  f = createFont("Arial", 32, true);
  textFont(f);

  // gwiazdki
  for (int i = 0; i < gwiazdki; i++) {
    gwiazdX[i] = random(width);
    gwiazdY[i] = random(height);
    gwiazdszyb[i] = random(0.5, 1.5);
  }
  
  // planety
  for (int i = 0; i < lplanet; i++) {
    planetX[i] = random(width);
    planetY[i] = random(height);
    planetszyb[i] = random(0.2, 0.5);
  }
  
  // asteroidy
  for (int i = 0; i < laster; i++) {
    asteroidX[i] = random(width);
    asteroidY[i] = random(height);
    asteroidszyb[i] = random(0.5, 1.5);
  }
  
  // wrogowie
  resetwrog();

  // statek
  statekX = 50;
  statekY = height / 2;
  
  // lasery
  for (int i = 0; i < llaser; i++) {
    aktlaser[i] = false;
  }
  
  // lasery wrogów
  for (int i = 0; i < llaserwrog; i++) {
    aktlaserwrog[i] = false;
  }
}

void draw() {
  tlo();
}

void tlo() {
  background(0);
  switch (stangry) {
    case 0:
      rysmenu();
      break;
    case 1:
      rysjakgrac();
      break;
    case 2:
      grac();
      break;
    case 3:
      ryskongry();
      break;
    case 4:
      ryswygrana();
      break;
  }
}

void rysmenu() {
  rystlokosm();
  fill(255);
  textAlign(CENTER);
  text("Menu", width / 2, height / 2 - 100);
  for (int i = 0; i < menu.length; i++) {
    if (i == wybmenu) {
      fill(255, 0, 0);
    } else {
      fill(255);
    }
    text(menu[i], width / 2, height / 2 + i * 40);
  }
}

void rysjakgrac() {
  fill(255);
  textAlign(LEFT);
  textSize(24);
  text("Strzalka w gore - przejscie do gory\nStrzalka w dol - zejscie w doł\nStrzalka w prawo - lot w prawa strone\nStrzalka w lewo - lot w lewa strone\nSpacja - strzelanie laserem", 50, 100);
  textAlign(CENTER);
  fill(255, 0, 0);
  text("Powrot", width - 100, height - 50);
  textSize(32);
}

void ryskongry() {
  fill(255);
  textAlign(CENTER);
  text("Koniec gry", width / 2, height / 2 - 50);
  text("Twoje punkty: " + nf(finpunkty, 6), width / 2, height / 2);
  if (wybmenu == 0) {
    fill(255, 0, 0);
  } else {
    fill(255);
  }
  text("Rozpocznij ponownie", width / 2, height / 2 + 50);
  if (wybmenu == 1) {
    fill(255, 0, 0);
  } else {
    fill(255);
  }
  text("Wyjscie", width / 2, height / 2 + 100);
}

void ryswygrana() {
  fill(255);
  textAlign(CENTER);
  text("Runda wygrana!", width / 2, height / 2 - 50);
  if (wybmenu == 0) {
    fill(255, 0, 0);
  } else {
    fill(255);
  }
  text("Nastepna runda", width / 2, height / 2 + 50);
  if (wybmenu == 1) {
    fill(255, 0, 0);
  } else {
    fill(255);
  }
  text("Wyjscie", width / 2, height / 2 + 100);
}

void grac() {
  fill(255);
  for (int i = 0; i < gwiazdki; i++) {
    ellipse(gwiazdX[i], gwiazdY[i], 2, 2);
    gwiazdX[i] -= gwiazdszyb[i];
    if (gwiazdX[i] < 0) {
      gwiazdX[i] = width;
      gwiazdY[i] = random(height);
    }
  }
  for (int i = 0; i < lplanet; i++) {
    fill(100 + i * 50, 50 + i * 30, 200 - i * 40);
    ellipse(planetX[i], planetY[i], 50, 50);
    planetX[i] -= planetszyb[i];
    if (planetX[i] < -50) {
      planetX[i] = random(width, width * 2);
      planetY[i] = random(height);
    }
  }
  fill(150);
  for (int i = 0; i < laster; i++) {
    ellipse(asteroidX[i], asteroidY[i], 20, 20);
    asteroidX[i] -= asteroidszyb[i];
    if (asteroidX[i] < -20) {
      asteroidX[i] = random(width, width * 2);
      asteroidY[i] = random(height);
    }
  }
  fill(255, 0, 0);
  for (int i = 0; i < lwrog; i++) {
    if (wrogakt[i]) {
      rect(wrogX[i], wrogY[i], 30, 30);
      wrogX[i] -= 1.5;
      if (wrogX[i] < -30) {
        wrogX[i] = random(width, width * 2);
        wrogY[i] = random(height);
      }
    }
  }
  fill(255, 100, 0);
  for (int i = 0; i < llaserwrog; i++) {
    if (aktlaserwrog[i]) {
      rect(wroglaserX[i], wroglaserY[i], 10, 2);
      wroglaserX[i] -= 2;
      if (wroglaserX[i] < 0) {
        aktlaserwrog[i] = false;
      }
      // kolizja
      if (dist(wroglaserX[i], wroglaserY[i], statekX, statekY) < 10) {
        finpunkty = punkty;  // zapisywanie punktów
        stangry = 3;
        punkty = 0;
        lwrog = lbazwrog;
        wybmenu = 0;
      }
    }
  }
  if (wroglasercooldown <= 0 && frameCount % 50 == 0) {
    for (int i = 0; i < lwrog; i++) {
      if (wrogakt[i]) {
        wroglaserX[indlaserwrog] = wrogX[i];
        wroglaserY[indlaserwrog] = wrogY[i] + 15;
        aktlaserwrog[indlaserwrog] = true;
        indlaserwrog = (indlaserwrog + 1) % llaserwrog;
      }
    }
    wroglasercooldown = 50; // opóźnienie między strzałami wroga
  }
  
  if (wroglasercooldown > 0) {
    wroglasercooldown--;
  }
  // statek
  fill(0, 255, 0);
  triangle(statekX, statekY, statekX - 20, statekY + 10, statekX - 20, statekY - 10);
  // ruch statku
  if (keyPressed) {
    if (keyCode == UP) {
      statekY -= 5;
    } else if (keyCode == DOWN) {
      statekY += 5;
    } else if (keyCode == LEFT) {
      statekX -= 5;
    } else if (keyCode == RIGHT) {
      statekX += 5;
    }
  }
  if (statekX < 0) {
    statekX = width;
  } else if (statekX > width) {
    statekX = 0;
  }
  if (statekY < 0) {
    statekY = height;
  } else if (statekY > height) {
    statekY = 0;
  }
  if (keyPressed && key == ' ' && lasercooldown <= 0) {
    ostrzlaser();
    lasercooldown = 20; 
  }

  if (lasercooldown > 0) {
    lasercooldown--;
  }
  fill(0, 255, 0);
  for (int i = 0; i < llaser; i++) {
    if (aktlaser[i]) {
      rect(laserX[i], laserY[i], 10, 2);
      laserX[i] += 5;
      if (laserX[i] > width) {
        aktlaser[i] = false;
      }
    }
  }

  // sprawdzanie kolizji lasera z wrogami
  for (int i = 0; i < llaser; i++) {
    if (aktlaser[i]) {
      for (int j = 0; j < lwrog; j++) {
        if (wrogakt[j]) {
          if (laserX[i] > wrogX[j] && laserX[i] < wrogX[j] + 30 &&
              laserY[i] > wrogY[j] && laserY[i] < wrogY[j] + 30) {
            wybuchX = wrogX[j];
            wybuchY = wrogY[j];
            aktwybuch = true;
            wybuchczas = 30;
            aktlaser[i] = false;
            wrogakt[j] = false;
            wrogpzyciu--;
            punkty += 10;
            if (wrogpzyciu == 0) {
              ostrzstatek = false;
              stangry = 4;
              wybmenu = 0;
            }
          }
        }
      }
    }
  }
  // wybuch
  if (aktwybuch) {
    fill(255, 100, 0);
    ellipse(wybuchX, wybuchY, 30, 30);
    wybuchczas--;
    if (wybuchczas <= 0) {
      aktwybuch = false;
    }
  }

  // punkty
  fill(255);
  textAlign(RIGHT);
  text(nf(punkty, 6), width - 10, 30);
}

void ostrzlaser() {
  laserX[indlaser] = statekX;
  laserY[indlaser] = statekY;
  aktlaser[indlaser] = true;
  indlaser = (indlaser + 1) % llaser;
}

void keyPressed() {
  if (stangry == 0) {
    if (keyCode == UP) {
      wybmenu = (wybmenu + menu.length - 1) % menu.length;
    } else if (keyCode == DOWN) {
      wybmenu = (wybmenu + 1) % menu.length;
    } else if (keyCode == ENTER) {
      if (wybmenu == 0) {
        stangry = 2;
        resetgry();
      } else if (wybmenu == 1) {
        stangry = 1;
      } else if (wybmenu == 2) {
        exit();
      }
    }
  } else if (stangry == 1) {
    if (keyCode == ENTER) {
      stangry = 0;
    }
  } else if (stangry == 3 || stangry == 4) {
    if (keyCode == UP || keyCode == DOWN) {
      wybmenu = (wybmenu + 1) % 2;
    } else if (keyCode == ENTER) {
      if (wybmenu == 0) {
        stangry = 2;
        if (stangry == 3) {
          resetgry();
        } else {
          nastrunda();
        }
      } else if (wybmenu == 1) {
        exit();
      }
    }
  }
}

void resetgry() {
  statekX = 50;
  statekY = height / 2;
  statekszyb = 2.5;
  ostrzstatek = true;
  wrogpzyciu = lbazwrog;
  punkty = 0;
  lwrog = lbazwrog;
  resetwrog();
}

void resetwrog() {
  wrogX = new float[lwrog];
  wrogY = new float[lwrog];
  wrogakt = new boolean[lwrog];
  for (int i = 0; i < lwrog; i++) {
    wrogX[i] = random(width, width * 2);
    wrogY[i] = random(height);
    wrogakt[i] = true;
  }
}

void nastrunda() {
  lwrog += int(random(5, 11)); // dodaje losowo od 5 do 10 wrogów
  wrogpzyciu = lwrog;
  resetwrog();
  statekX = 50;
  statekY = height / 2;
  statekszyb = 2.5;
  ostrzstatek = true;
}

void rystlokosm() {
  fill(255);
  for (int i = 0; i < gwiazdki; i++) {
    ellipse(gwiazdX[i], gwiazdY[i], 2, 2);
    gwiazdX[i] -= gwiazdszyb[i];
    if (gwiazdX[i] < 0) {
      gwiazdX[i] = width;
      gwiazdY[i] = random(height);
    }
  }
  for (int i = 0; i < lplanet; i++) {
    fill(100 + i * 50, 50 + i * 30, 200 - i * 40);
    ellipse(planetX[i], planetY[i], 50, 50);
    planetX[i] -= planetszyb[i];
    if (planetX[i] < -50) {
      planetX[i] = random(width, width * 2);
      planetY[i] = random(height);
    }
  }
  fill(150);
  for (int i = 0; i < laster; i++) {
    ellipse(asteroidX[i], asteroidY[i], 20, 20);
    asteroidX[i] -= asteroidszyb[i];
    if (asteroidX[i] < -20) {
      asteroidX[i] = random(width, width * 2);
      asteroidY[i] = random(height);
    }
  }
}
