.section .data
buffer:     .fill 256, 1, 0
filename:   .asciz "testfile.txt"
filetext:   .asciz "AArch64!\n"
filedesc:   .4byte 0

.section .text
.global _start

_start:
    // Get current directory
    ldr x0, =buffer
    mov x1, #256
    mov x8, #17
    svc #0
    mov x10, x0

    // Print directory
    mov x0, #1
    ldr x1, =buffer
    mov x2, x10
    mov x8, #64
    svc #0

    // Open/create file
    mov x0, #-100
    ldr x1, =filename
    mov x2, #0x241
    mov x3, #420
    mov x8, #56
    svc #0
    mov x9, x0

    // Write to file
    ldr x1, =filetext
    mov x2, #9
    mov x8, #64
    svc #0

    // Close file
    mov x0, x9
    mov x8, #57
    svc #0

    // Change permissions
    mov x0, #-100
    ldr x1, =filename
    mov x2, #511
    mov x3, #0
    mov x8, #52
    svc #0

    // Reopen file
    mov x0, #-100
    ldr x1, =filename
    mov x2, #0
    mov x8, #56
    svc #0
    mov x9, x0

    // Read file
    ldr x1, =buffer
    mov x2, #256
    mov x8, #63
    svc #0
    mov x10, x0

    // Print file content
    mov x0, #1
    ldr x1, =buffer
    mov x2, x10
    mov x8, #64
    svc #0

    // Close file
    mov x0, x9
    mov x8, #57
    svc #0

    // Exit
    mov x0, #1
    mov x8, #93
    svc #0