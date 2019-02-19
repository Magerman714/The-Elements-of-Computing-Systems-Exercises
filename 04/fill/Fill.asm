// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Fill.asm

// Runs an infinite loop that listens to the keyboard input.
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel;
// the screen should remain fully black as long as the key is pressed. 
// When no key is pressed, the program clears the screen, i.e. writes
// "white" in every pixel;
// the screen should remain fully clear as long as no key is pressed.

    @8192
    D=A
    @loopend
    M=D      // sets up a test for max memory location to end later loops
(READKBD)
    @screenpointer
    M=0
    @KBD // Read keyboard
    D=M
    @WHITE
    D;JEQ  // If D=0, goto WHITE
    @BLACK
    0;JMP // Else goto BLACK 
(WHITE)
    @SCREEN
    M=0    // Set first block of screen pixels to white
(WLOOP)
    @SCREEN
    D=A              // selects screen's mem location
    @screenpointer   // use screenpointer as mem location incrementation so whole screen can be affected
    A=D+M            // screenpointer mem address=SCREEN+screenpointer
    M=0              // sets pixels in this mem block to white
    @screenpointer
    M=M+1            // increment screenpointer
    @loopend
    D=M              // D=8192, which should be the highest value needed for screenpointer
    @screenpointer
    D=D-M            // test to see if screenpointer is at max screen address
    @READKBD
    D;JEQ            // should be "if screenpointer=max screen address, end loop"
    @WLOOP
    0;JMP            // elseif, continue looping
(BLACK)
    @SCREEN
    M=-1     // Set first block of screen pixels to black
(BLOOP)
    @SCREEN
    D=A
    @screenpointer   // same as the WHITE loop, but sets to black
    A=D+M            
    M=-1             // sets pixels in this mem block to black
    @screenpointer
    M=M+1
    @loopend
    D=M              // D=8192, which should be the highest value needed for screenpointer
    @screenpointer
    D=D-M
    @READKBD
    D;JEQ
    @BLOOP
    0;JMP
