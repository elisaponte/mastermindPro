  mastermind master = new mastermind();
  int row = 0;
  int col = 0;
  String[] cs;
  boolean[] full;
  boolean end = false;
  color[] cols = {color(230, 20, 20), color(230, 120, 20), color(230, 230,20), color(20, 230,20),
                  color(20, 20, 230), color(230, 20,230), color(230, 230,230), color(20, 20,20)};
  String[] colStrings1 = {"RED", "ORANGE", "YELLOW", "GREEN", "BLUE", "PURPLE", "WHITE", "BLACK"};

  void setup() {
    size(500, 720);
    background(170,140,110);
    fill(140,110,80);
    
    for(int x=0; x<6; x++) { //draw main holes in board
      for(int y=0; y<10; y++){
        ellipse(180+50*x,50+60*y, 30, 30);
      }
    }
    for(int i=0; i<cols.length; i++){ //draw circles on bottom of screen
      fill(cols[i]);
      ellipse(80 + 50*i, 671, 30, 30);
    }
    for(int y=0; y<10; y++){ //draw rectangles with small holes in board
      fill(140,110,80);
      rect(30, 20+60*y, 90, 60);
      for(int x=0; x<3;x++){
        fill(100,60,50);
        ellipse(45+30*x, 35+60*y, 10, 10);
        ellipse(45+30*x, 65+60*y, 10, 10);
      }
    }
    full = new boolean[6];
    for(int k=0; k<6; k++){
      full[k]=false;
    }
    cs = new String[6];
  }

  void draw() {
    if(end) noLoop();
  }
  
  void mouseClicked(){
    if(mouseX>50 && mouseX<450 && mouseY>641 && mouseY<701){
      if(col!=5 && full[col]==false){ //fill in (not last) holes with selected color
        int arrayIndex = (int)(mouseX/50)-1;
        cs[col]=colStrings1[arrayIndex];
        fill(cols[arrayIndex]);
        ellipse(180+50*col,590-60*row, 30, 30);
        full[col]=true;
        col++;
      }
      else if(col!=5 && full[col]==true){ //skip over (not last) holes already filled in 
        col++;
        mouseClicked();
      }
      else if(col==5){ //fill in last hole and pass colors through guesser
        int arrayIndex = (int)(mouseX/50)-1;
        cs[col]=colStrings1[arrayIndex];
        fill(cols[arrayIndex]);
        ellipse(180+50*col,590-60*row, 30, 30);
        int[] g= new int[6];
        String[] guessList = {cs[0], cs[1], cs[2], cs[3], cs[4], cs[5]};
        g=master.guess(guessList);
        for(int x=0; x<6;x++){ //display black and white dots to show result for row
          if(g[x]==2){
            fill(20,20,20);
          }
          else if(g[x]==1){
            fill(230,230,230);
          }
          else if(g[x]==0){
            fill(100,60,50);
          }
          ellipse(45+30*(x%3), 575+(int)(x/3)*30-60*row, 10, 10);
        }
        int countee=0;
        for(int k=0; k<6; k++){ //count number of correct placements
          if(g[k]==2){
            countee++;
          }
        }
        if(countee==6){ //show the player they have won
          fill(255);
          rect(75, 300, 350, 100);
          fill(0);
          textSize(60);
          end=true;
          text("YOU WIN!", 110, 370);
        }
        col=0;
        row++;
        if(row==10){ //show the player they have lost
          fill(255);
          rect(75, 300, 350, 100);
          fill(0);
          textSize(60);
          end=true;
          text("YOU LOSE!", 97, 375);
        }
        for(int k=0; k<6; k++){ //reset full
          full[k]=false;
        }
      }
    }
    else if(mouseY>-row*60+560 && mouseY<-row*60+630){ //remove a color placed in board
      if(mouseX>155 && mouseX<405){
        col = int((mouseX-155)/50);
        fill(140,110,80);
        ellipse(180+ 50*col,590-60*row, 30, 30);
        full[col]=false;
        col=0;
      }
    }
  }

class mastermind {
  ArrayList<String> allColors= new ArrayList<String>();
  String[] colStrings = {"RED", "ORANGE", "YELLOW", "GREEN", 
                         "BLUE", "PURPLE", "WHITE", "BLACK"};
  mastermind() {
    for(int k=0; k<6; k++){
      allColors.add(colStrings[(int)(Math.random()*(8))]); //create random color code
    }
  }

  int[] guess(String[] gList) {
    ArrayList<Integer> rowResult = new ArrayList<Integer>(); // 2 represents correct 
    //color in correct location, 1 represents correct color in incorrect loaction
    //0 represents none or no more of that color present
    ArrayList<String> replace = new ArrayList<String>(); //what colors are left 
    //after passing through
    for(int k=0; k<6; k++){ //copy allColors into replace
      replace.add(allColors.get(k));
    }
    for(int i = 0; i<6; i++){ //check if correct color in correct location
      if(gList[i].equals(allColors.get(i))){
        rowResult.add(2);
        replace.remove(gList[i]);
      }
    }
    for(int i = 0; i<6; i++){ //check if correct color in wrong location
      if(replace.contains(gList[i]) && !gList[i].equals(allColors.get(i))){
        rowResult.add(1);
        replace.remove(gList[i]);
      }
    }
    for(int k=rowResult.size(); k<6; k++){
      rowResult.add(0);
    }
    int[] guesscode = {1, 1, 1, 1, 1, 1}; //will be altered so that rowResult
    //values are in increasing order
    int mini = 0;
    int maxi = 5;
    for(int r=0; r<6; r++){
      if(rowResult.get(r) == 2){
        guesscode[maxi] = rowResult.get(r);
        maxi--;
      }
      else if(rowResult.get(r) == 0){
        guesscode[mini] = rowResult.get(r);
        mini++;
      }
    }
    return guesscode;
  }  
}
