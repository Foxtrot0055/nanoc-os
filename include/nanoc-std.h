#include <stdint.h>

int cursor = 0;

void print(char input[], uint8_t color){
  uint16_t* vga_text_buffer = (uint16_t*)0xb8000;      //start of vga text buffer
  vga_text_buffer += cursor;                           //set start of buffer to current cursor
  char current_char = *input;                          //gets first char in string
  while (current_char != '\0'){                       //break loop if null: null terminated strings
    *vga_text_buffer = (color << 8) | current_char;   //writes color and char to vga text buffer
    vga_text_buffer += 1;                              //inc buffer cause again 2bytes per entry
    input += 1;                                        //inc input
    current_char = *input;                             //get next char
    cursor += 1;                                       //inc cursor
  }  
}
