#include "include/nanoc-std.h"
#include <stdint.h>
void kernel(){
//  print("", 0x1E);
  volatile uint16_t* vga = (uint16_t*) 0xB8000;
  vga[0] = (0x1F << 8) | 'K';
}
