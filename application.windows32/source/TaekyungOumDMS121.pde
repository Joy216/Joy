

import processing.sound.*;
SoundFile file;
 PImage bg ;
 int y;
    int score = 0;
    boolean gameOver = false;
 
    ArrayList petal = new ArrayList();
 
    public void setup() {
 
          size(670, 1199);
 
        for (int i = 0; i < 25; i++) {
            petal.add(new Petal(247,204,223));
            petal.add(new Petal(248,214,230));
            petal.add(new Petal(228,185,205));
            bg=loadImage("school.jpg");
           file=new SoundFile(this,"AprilFeeling.mp3");
            
            file.play();
file.amp(-1);
file.rate(1);
            
        }
 
    }
        
 
    
 
 
    public void draw() {
 
        if(!gameOver) {
            background(bg);
            textSize(20);
            fill(255, 189, 210);
            textAlign(LEFT);
            text("score : " + score, 10 ,30);
        }
        else {
            background(255, 189, 210);
            textSize(20);
            fill(255);
            textAlign(LEFT);
            text("score : " + score, 10 ,30);
            
            textAlign(CENTER);
            fill(255);
            textSize(30);
            text("CherryBlossom Ending",width/2,height/2);
            textSize(20);
            text("PuzzleLeaf",width/2,height/2 + 40);
        }
 
 
        if(!gameOver)
            for (int i = 0; i < petal.size (); i++) {
                Petal p = (Petal) petal.get(i);
 
                if(mousePressed) {
                    fill(247,204,205,30);
                    ellipse(mouseX,mouseY,30,30);
                    score += 100 * p.crash();
                }
 
                gameOver = p.checkLevel(score);
                p.draw();
                p.boundaries();
            }
    }
 
 

 
 
    class Petal {
        PVector loc;
        PVector vel;
        float R;
        float G;
        float B;
 
        float s = random(-10, 10);
        float petalSize = (float) 0.12;
        float speedLevel;
        float rot = random(250,260);
 
        Petal(float R, float G, float B) {
 
            loc = new PVector(random(width), random(height));
 
            this.R = R;
            this.G = G;
            this.B= B;
 
            speedLevel = 5;
            vel = new PVector(random(0, 2), random(-1, 1)+speedLevel);
        }
 
        void draw() {
            noStroke();
            fill(R, G, B, 100);
            loc.add(vel);
            pushMatrix();
            translate(loc.x, loc.y);
            scale(petalSize);
            rotate(rot);
            beginShape();
 
            
            for (int i = 0; i <= 180; i+=10) {
                float x = sin(radians(i)) * i/2;
                float angle = sin(radians(i+s+frameCount*5)) * loc.x/15;
                vertex(x-angle, i*2);
            }
 
            for (int i = 180; i >= 0; i-=5) {
                float x = sin(radians(i)) * i/2;
                float angle = sin(radians(i+s+frameCount*5)) * loc.y/20;
                vertex(-x-angle, i*2);
            }
            endShape();
            popMatrix();
        }
      
        int crash()
        {
            if(mouseX > loc.x-200*petalSize && mouseX< loc.x+200*petalSize &&
                    mouseY>loc.y - 200 * petalSize && mouseY<loc.y + 200 * petalSize)
            {
                loc.y = -50;
                return 1;
            }
            return 0;
        }
 
        boolean checkLevel(int score)
        {
            speedLevel += 0.001 * score/1000;
            vel = new PVector(random(0, 2), random(-1, 1)+speedLevel);
 
            if(speedLevel > 70)
                return true;
 
            return false;
        }
 
        void boundaries() {
            if (loc.x < -20) loc.x = width+50;
            if (loc.x > width+50) loc.x = -50;
            if (loc.y < -50) loc.y = height+50;
            if (loc.y > height+50) loc.y = -50;
        }
 
        void setRGB(float R, float G, float B)
        {
            this.R = R;
            this.G = G;
            this.B = B;
        }
    }
 
