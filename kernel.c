#include "include/nanoc-std.h"
#include <stdint.h>
void kernel(){
  uint8_t color = 0x11;
  while(color){
    print("O", color);
    color ++;
  }
}
