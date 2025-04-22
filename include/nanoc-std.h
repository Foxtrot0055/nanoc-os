#include <stdint.h>

static int cursor = 0;

static void print(char input[], uint8_t color){
  volatile uint16_t* vga_text_buffer = (uint16_t*)0xb8000;      //start of vga text buffer
  vga_text_buffer += cursor;                           //set start of buffer to current cursor
  *input;                          //gets first char in string
  
  while (*input){                                     //break loop if null: null terminated strings
    *vga_text_buffer = (color << 8) | *input;   //writes color and char to vga text buffer
    vga_text_buffer += 1;                              //inc buffer cause again 2bytes per entry
    input += 1;                                        //inc input
    cursor += 1;                                       //inc cursor
  }  
}
