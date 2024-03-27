import de.bezier.guido.*;
//Declare and initialize NUM_ROWS and NUM_COLS = 20
private final static int NUM_COLS = 20;
private final static int NUM_ROWS = 20;
private final static int NUM_BOMBS = 30;
private int numMarked = 0;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs; //ArrayList of just the minesweeper buttons that are mined
private boolean gameOver = false;

void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    
    //your code to declare and initialize buttons goes here
    buttons = new MSButton[NUM_ROWS][NUM_COLS];

     for(int r = 0; r < NUM_ROWS; r++)
     {
        for(int c = 0; c < NUM_COLS; c++)
        {
            buttons[r][c] = new MSButton(r,c);        
        }
     }
    bombs = new ArrayList <MSButton>();  
    setBombs();
}
public void setBombs()
{
    //your code
     while(bombs.size() < NUM_BOMBS)
     {
         int r = (int)(Math.random()*NUM_ROWS);
         int c = (int)(Math.random()*NUM_COLS);

         if(!bombs.contains(buttons[r][c]))
         {
            bombs.add(buttons[r][c]);
         }   
     }

}

public void draw ()
{
    background( 0 );
    fill(255);
    if(isWon())
        displayWinningMessage();

}
public boolean isWon()
{
    //your code here
     for(int r = 0; r < NUM_ROWS; r++)
     {
        for(int c = 0; c < NUM_COLS; c++)
        {
            if(buttons[r][c].isClicked() == false && buttons[r][c].isMarked() == false && numMarked != NUM_BOMBS)
            return false;        
        }
    }
    return true;
}
public void displayLosingMessage()
{
        buttons[10][10].setLabel("Lose");
     

}
public void displayWinningMessage()
{
    //your code here
    if(isWon() == true)
    {
        buttons[10][10].setLabel("Win");
        
    }

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
        if(gameOver == false)
        {        
            clicked = true;
            if(mousePressed && mouseButton == RIGHT)
            {
                if(marked == true)
                {
                    marked = false;
                    numMarked --;                
                }

                else if (marked == false)
                {
                    marked = true;
                    numMarked ++;            
                }

                if(marked == false)
                    clicked = false;  
            }
            else if(bombs.contains(this))
            {
                gameOver = true;
            }
            else if (countBombs(r,c) > 0)
            {
                label = ""+countBombs(r,c);
            }

            else
            {
                if(isValid(r+1,c) == true && buttons[r+1][c].isClicked() == false)
                    buttons[r+1][c].mousePressed();              

                if(isValid(r,c-1) == true && buttons[r][c-1].isClicked() == false)
                    buttons[r][c-1].mousePressed();
             
                if(isValid(r-1,c) == true && buttons[r-1][c].isClicked() == false)
                    buttons[r-1][c].mousePressed();

                if(isValid(r,c+1) == true && buttons[r][c+1].isClicked() == false)
                    buttons[r][c+1].mousePressed();

                if(isValid(r-1,c-1) == true && buttons[r-1][c-1].isClicked() == false)
                    buttons[r-1][c-1].mousePressed();

                if(isValid(r+1,c-1) == true && buttons[r+1][c-1].isClicked() == false)
                    buttons[r+1][c-1].mousePressed();

                if(isValid(r+1,c+1) == true && buttons[r+1][c+1].isClicked() == false)
                    buttons[r+1][c+1].mousePressed();

                if(isValid(r-1,c+1) == true && buttons[r-1][c+1].isClicked() == false)
                    buttons[r-1][c+1].mousePressed();
            }
        }
      
    }

    public void draw () 
    {    
        if (marked)
            fill(0);
         else if( clicked && bombs.contains(this) ) 
             fill(255,0,0);
         else if(gameOver == true && bombs.contains(this))
             fill(255, 0, 0);
        else if(clicked)
            fill(0, 255, 0 );
        else 
            fill( 100, 100, 100 );

        rect(x, y, width, height);
        fill(0);
        text(label,x+width/2,y+height/2);


        if(gameOver == true && bombs.contains(this))
        {                
            displayLosingMessage();
        }
    }

    public void setLabel(String newLabel)
    {
        label = newLabel;
    }

    public boolean isValid(int row, int col)
    {
        //your code here
        if(row >= 0 && col >= 0 && row < NUM_ROWS && col < NUM_COLS)
            return true;

        else
        return false;
    }
    public int countBombs(int row, int col)
    {
        int numBombs = 0;
        //your code here
        if(isValid(row-1, col) == true && bombs.contains(buttons[row-1][col]))
            numBombs ++;

        if(isValid(row, col-1) == true && bombs.contains(buttons[row][col-1]))
            numBombs ++;

        if(isValid(row-1, col-1) == true && bombs.contains(buttons[row-1][col-1]))
            numBombs ++;

        if(isValid(row+1, col) == true && bombs.contains(buttons[row+1][col]))
            numBombs ++;

        if(isValid(row, col+1) == true && bombs.contains(buttons[row][col+1]))
            numBombs ++;

        if(isValid(row+1, col+1) == true && bombs.contains(buttons[row+1][col+1]))
            numBombs ++;

        if(isValid(row-1, col+1) == true && bombs.contains(buttons[row-1][col+1]))
            numBombs ++;

        if(isValid(row+1, col-1) == true && bombs.contains(buttons[row+1][col-1]))
            numBombs ++;

        return numBombs;   
    }
}
