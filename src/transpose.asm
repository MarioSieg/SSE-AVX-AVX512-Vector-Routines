# Transpose for 4x4 double precision matrices
# Matrix bytes must be in rdi and aligned to 32 bytes!

transpose_unpack_4x4:
    pushq %rbp
    movq %rsp, %rbp

    vmovapd 00(%rdi), %ymm0
    vmovapd 32(%rdi), %ymm1 
    vmovapd 64(%rdi), %ymm2
    vmovapd 96(%rdi), %ymm3
    vunpcklpd %ymm1, %ymm0, %ymm12
    vunpcklpd %ymm1, %ymm0, %ymm13
    vunpcklpd %ymm3, %ymm2, %ymm14
    vunpcklpd %ymm3, %ymm2, %ymm15
    vperm2f128 $0b00100000, %ymm14, %ymm12, %ymm0
    vperm2f128 $0b00100000, %ymm15, %ymm13, %ymm1
    vperm2f128 $0b00110001, %ymm14, %ymm12, %ymm2
    vperm2f128 $0b00110001, %ymm15, %ymm13, %ymm3
    vmovapd %ymm0, 00(%rdi)
    vmovapd %ymm1, 32(%rdi) 
    vmovapd %ymm2, 64(%rdi)
    vmovapd %ymm3, 96(%rdi)
    
    movq %rbp, %rsp
    popq %rbp
    retq

transpose_shuffle_4x4:
    pushq %rbp
    movq %rsp, %rbp

    vmovapd 00(%rdi), %ymm0
    vmovapd 32(%rdi), %ymm1 
    vmovapd 64(%rdi), %ymm2
    vmovapd 96(%rdi), %ymm3
    vshufpd $0b0000, %ymm1, %ymm0, %ymm12
    vshufpd $0b1111, %ymm1, %ymm0, %ymm13
    vshufpd $0b0000, %ymm3, %ymm2, %ymm14
    vshufpd $0b1111, %ymm3, %ymm2, %ymm15
    vperm2f128 $0b00100000, %ymm14, %ymm12, %ymm0
    vperm2f128 $0b00100000, %ymm15, %ymm13, %ymm1
    vperm2f128 $0b00110001, %ymm14, %ymm12, %ymm2
    vperm2f128 $0b00110001, %ymm15, %ymm13, %ymm3
    vmovapd %ymm0, 00(%rdi)
    vmovapd %ymm1, 32(%rdi) 
    vmovapd %ymm2, 64(%rdi)
    vmovapd %ymm3, 96(%rdi)

    movq %rbp, %rsp
    popq %rbp
    retq
