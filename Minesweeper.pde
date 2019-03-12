

import de.bezier.guido.*;
public final static int NUM_ROWS = 20;
public final static int NUM_COLS = 20;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs = new ArrayList<MSButton>(); //ArrayList of just the minesweeper buttons that are mined

void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    
    //your code to initialize buttons goes here
    buttons = new MSButton[NUM_ROWS][NUM_COLS];
    for(int r = 0; r< NUM_ROWS; r++)
      for(int c = 0; c< NUM_COLS; c++)
          buttons[r][c] = new MSButton(r,c); 
    while( bombs.size() < 20){
      setBombs();
    }
}
public void setBombs()
{

    int r = (int)(Math.random()* NUM_ROWS);
    int c = (int)(Math.random()* NUM_COLS);
    bombs.add(buttons[r][c]);
    System.out.println(r+ "," + c);
}

public void draw ()
{
    background( 0 );
    if(isWon())
        displayWinningMessage();
}
public boolean isWon()
{
    //your code here
    return false;
}
public void displayLosingMessage()
{
    background(#88EDF0);
    buttons[9][5].setLabel("G");
    buttons[9][6].setLabel("A");
    buttons[9][7].setLabel("M");
    buttons[9][8].setLabel("E");
    buttons[9][10].setLabel("O");
    buttons[9][11].setLabel("V"); 
    buttons[9][12].setLabel("E");
    buttons[9][13].setLabel("R");
    buttons[9][14].setLabel("!");

   
}
public void displayWinningMessage()
{
    buttons[8][7].setLabel("C");
    buttons[8][7].setLabel("O");
    buttons[8][7].setLabel("N");
    buttons[8][7].setLabel("G");
    buttons[8][7].setLabel("R");
    buttons[8][7].setLabel("A");
    buttons[8][7].setLabel("T");
    buttons[8][7].setLabel("S");
    buttons[9][6].setLabel("Y");
    buttons[9][7].setLabel("O");
    buttons[9][8].setLabel("U");
    buttons[9][10].setLabel("W");
    buttons[9][11].setLabel("I");
    buttons[9][12].setLabel("N");
    
}

public class MSButton
{
    private int r, c;
    private float x,y, width, height;
    private boolean clicked, marked;
    private String label;
    
    public MSButton ( int rr, int cc )
    {
        width = 400/NUM_COLS;
        height = 400/NUM_ROWS;
        r = rr;
        c = cc; 
        x = c*width;
        y = r*height;
        label = "";
        marked = clicked = false;
        Interactive.add( this ); // register it with the manager
    }
    public boolean isMarked()
    {
        return marked;
    }
    public boolean isClicked()
    {
        return clicked;
    }
    // called by manager
    
    public void mousePressed () 
    {
        clicked = true;
        if(mouseButton == RIGHT ){
          marked = !marked;
        }
        else if(bombs.contains(this)){
          displayLosingMessage();
        } 
        else if(countBombs(r,c)>0){
          setLabel(""+countBombs(r,c));
        }
        else {
          if(isValid(r-1,c-1) == true && buttons[r-1][c-1].isClicked() == false)
            buttons[r-1][c-1].mousePressed();
          if(isValid(r-1,c) == true && buttons[r-1][c].isClicked() == false)
            buttons[r-1][c].mousePressed();
           if(isValid(r-1,c+1) == true && buttons[r-1][c+1].isClicked() == false)
            buttons[r-1][c+1].mousePressed();
           if(isValid(r,c-1) == true && buttons[r][c-1].isClicked() == false)
            buttons[r][c-1].mousePressed();
           if(isValid(r,c+1) == true && buttons[r][c+1].isClicked() == false)
            buttons[r][c+1].mousePressed(); 
           if(isValid(r+1,c+1) == true && buttons[r+1][c+1].isClicked() == false)
            buttons[r+1][c+1].mousePressed(); 
           if(isValid(r+1,c-1) == true && buttons[r+1][c-1].isClicked() == false)
            buttons[r+1][c-1].mousePressed(); 
           if(isValid(r+1,c) == true && buttons[r+1][c].isClicked() == false)
            buttons[r+1][c].mousePressed(); 
          
        }
          
          
        
    }

    public void draw () 
    {    
        if (marked)
            fill(0);
        else if( clicked && bombs.contains(this) ) 
             fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );

        rect(x, y, width, height);
        fill(0);
        text(label,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        label = newLabel;
    }
    public boolean isValid(int r, int c)
    {
      if (r>=0 && r<20 && c>=0 && c<20)
        return true;
      else
        return false;
    }
    public int countBombs(int row, int col)
    {
        int numBombs = 0;
        if(isValid(row-1,col-1)==true && bombs.contains(buttons[row-1][col-1]))
          numBombs = numBombs + 1;
        if(isValid(row-1,col+1)==true && bombs.contains(buttons[row-1][col+1]))
          numBombs = numBombs + 1;
        if(isValid(row-1,col)==true && bombs.contains(buttons[row-1][col]))
          numBombs = numBombs + 1;
        if(isValid(row,col-1)==true && bombs.contains(buttons[row][col-1]))
          numBombs = numBombs + 1;
        if(isValid(row,col+1)==true && bombs.contains(buttons[row][col+1]))
          numBombs = numBombs + 1;
         if(isValid(row+1,col-1)==true && bombs.contains(buttons[row+1][col-1]))
          numBombs = numBombs + 1;
          if(isValid(row+1,col)==true && bombs.contains(buttons[row+1][col]))
          numBombs = numBombs + 1;
           if(isValid(row+1,col+1)==true && bombs.contains(buttons[row+1][col+1]))
          numBombs = numBombs + 1;
        return numBombs;
    }
}
