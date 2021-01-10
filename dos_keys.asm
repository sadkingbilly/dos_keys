; Waits until a key is pressed, and outputs the corresponding scan/char codes
; returned by 0 function of int 0x16.
;
; Compile with: nasm dos_keys.asm -o dos_keys.com

keyboard_loop:
  ; Check if a key press is waiting.
  mov ah,0x1
  int 0x16
  jz keyboard_loop
  ; Read the key press.
  mov ah,0x0
  int 0x16
  ; ah now contains scan code, al - character code.
  ; Printing functions will modify ax, so save it first.
  mov bx, ax
  call print_bx
  ; Terminate
  int 0x20

; Prints the contents of bx using hex digits.
; Contents of bx are not modified, ax and dx are altered.
print_bx:
  mov dx, bx
  shr dx, 12
  call print_digit
  mov dx, bx
  shr dx, 8
  call print_digit
  mov dx, bx
  shr dx, 4
  call print_digit
  mov dx, bx
  call print_digit
  ret

test_print_bx:
  mov bx, 0xBEEF
  call print_bx

; Prints the hex digit contained in the lowest 4 bits of dl.
; Other bits of dl may be modified.
print_digit:
  ; Leave only 4 lowest bits.
  and dl, 0xF
  cmp dl, 0x9
  jle decimal_digit
  ; Add extra 0x7 to get A-F digits.
  add dl, 0x7
decimal_digit:
  ; Add 0x30 to get ASCII code.
  add dl, 0x30
  ; Call print.
  mov ah, 2
  int 0x21
  ret

test_print_digit:
  mov dl, 0x0
  call print_digit
  mov dl, 0x1
  call print_digit
  mov dl, 0x2
  call print_digit
  mov dl, 0x3
  call print_digit
  mov dl, 0x4
  call print_digit
  mov dl, 0x5
  call print_digit
  mov dl, 0x6
  call print_digit
  mov dl, 0x7
  call print_digit
  mov dl, 0x8
  call print_digit
  mov dl, 0x9
  call print_digit
  mov dl, 0xA
  call print_digit
  mov dl, 0xB
  call print_digit
  mov dl, 0xC
  call print_digit
  mov dl, 0xD
  call print_digit
  mov dl, 0xE
  call print_digit
  mov dl, 0xF
  call print_digit
  ret
