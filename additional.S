.data
prompt:     .asciz  "Enter color sequence (up to 16 chars, B,r,g,b,y,w,c,m): "
input:      .space  17
color_codes:
            .asciz  "Brgbywcm"

black:      .asciz  "\033[40m  \033[0m"
red:        .asciz  "\033[41m  \033[0m"
green:      .asciz  "\033[42m  \033[0m"
blue:       .asciz  "\033[44m  \033[0m"
yellow:     .asciz  "\033[43m  \033[0m"
white:      .asciz  "\033[47m  \033[0m"
cyan:       .asciz  "\033[46m  \033[0m"
magenta:    .asciz  "\033[45m  \033[0m"

color_table:
            .quad black, red, green, blue, yellow, white, cyan, magenta
newline:    .asciz  "\n"

.text
.global _start

_start:
    mov x0, #1
    adr x1, prompt
    mov x2, #55
    mov x8, #64
    svc #0

    mov x0, #0
    adr x1, input
    mov x2, #17
    mov x8, #63
    svc #0

    adr x19, input
    adr x20, color_codes
    adr x21, color_table

process_loop:
    ldrb w22, [x19], #1
    cbz w22, print_done

    cmp w22, #'A'
    blt check_color
    cmp w22, #'Z'
    bgt check_color
    add w22, w22, #32

check_color:
    mov x23, #0
color_search:
    ldrb w24, [x20, x23]
    cbz w24, process_loop
    cmp w22, w24
    beq print_color
    add x23, x23, #1
    b color_search

print_color:
    mov x0, #1
    ldr x1, [x21, x23, lsl #3]
    mov x2, #11
    mov x8, #64
    svc #0

    mov x25, #0x100000
delay_loop:
    subs x25, x25, #1
    bne delay_loop

    b process_loop

print_done:
    mov x0, #1
    adr x1, newline
    mov x2, #1
    mov x8, #64
    svc #0

    mov x0, #0
    mov x8, #93
    svc #0