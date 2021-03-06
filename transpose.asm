extern printf

section .data
    fmt0 db "4x4 double precision matrix transpose", 10, 0
    fmt1 db 10, "matrix result:", 10, 0
    fmt2 db 10, "transpose unpack result:", 10, 0
    fmt3 db 10, "transpose shuffle result:", 10, 0
    align 32
    matrix  dq 1.,  2.,  3.,  4.
            dq 5.,  6.,  7.,  8.
            dq 9.,  10., 11., 12.
            dq 13., 14., 15., 16.

section .bss
alignb 32
transpose resd 16

section .text
global main
main:
    push rbp
    mov rbp, rsp
    mov rdi, fmt1
    call printf

    mov rdi, matrix
    mov rsi, transpose
    call transpose_unpack_4x4

    mov rdi, matrix
    mov rsi, transpose
    call transpose_shuffle_4x4

    mov rsp, rbp
    pop rbp

transpose_unpack_4x4:
    push rbp
    mov rbp, rsp
    vmovapd ymm0, [rdi]
    vmovapd ymm1, [rdi+32]
    vmovapd ymm2, [rdi+64]
    vmovapd ymm3, [rdi+96]
    vunpcklpd ymm12, ymm0, ymm1
    vunpcklpd ymm13, ymm0, ymm1
    vunpcklpd ymm14, ymm2, ymm3
    vunpcklpd ymm15, ymm2, ymm3
    vperm2f128 ymm0, ymm12, ymm14, 0b00100000
    vperm2f128 ymm1, ymm13, ymm15, 0b00100000
    vperm2f128 ymm2, ymm12, ymm14, 0b00110001
    vperm2f128 ymm3, ymm13, ymm15, 0b00110001
    vmovapd [rsi], ymm0
    vmovapd [rsi+32], ymm1
    vmovapd [rsi+64], ymm2
    vmovapd [rsi+96], ymm3
    mov rsp, rbp
    pop rbp

transpose_shuffle_4x4:
    push rbp
    mov rbp, rsp
    vmovapd ymm0, [rdi]
    vmovapd ymm1, [rdi+32]
    vmovapd ymm2, [rdi+64]
    vmovapd ymm3, [rdi+96]
    vshufpd ymm12, ymm0, ymm1, 0b0000
    vshufpd ymm13, ymm0, ymm1, 0b1111
    vshufpd ymm14, ymm2, ymm3, 0b0000
    vshufpd ymm15, ymm2, ymm3, 0b1111
    vperm2f128 ymm0, ymm12, ymm14, 0b00100000
    vperm2f128 ymm1, ymm13, ymm15, 0b00100000
    vperm2f128 ymm2, ymm12, ymm14, 0b00110001
    vperm2f128 ymm3, ymm13, ymm15, 0b00110001
    vmovapd [rsi], ymm0
    vmovapd [rsi+32], ymm1
    vmovapd [rsi+64], ymm2
    vmovapd [rsi+96], ymm3
    mov rsp, rbp
    pop rbp