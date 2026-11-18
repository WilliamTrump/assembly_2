.text

    .globl sum_positive_ints
    .type sum_positive_ints, @function
sum_positive_ints:
    # TODO: Problem 1
    movq $0, %rax
    movq $0, %rcx

.Lsum_loop:
    cmpq %rsi, %rcx
    jge .Lsum_done

    movq %rcx, %rdx
    imulq $4, %rdx
    addq %rdi, %rdx
    movslq (%rdx), %r8
    cmpq $0, %r8
    jle .Lsum_next
    addq %r8, %rax

.Lsum_next:
    addq $1, %rcx
    jmp .Lsum_loop

.Lsum_done:
    ret


    ret

    .globl reverse_longs
    .type reverse_longs, @function
reverse_longs:
    # TODO: Problem 2
    movq $0, %rcx
    movq %rsi, %rdx
    subq $1, %rdx

    .Lreverse_loop:
    cmpq %rdx, %rcx
    jge .Lreverse_done

    movq %rcx, %r8
    imulq $8, %r8
    addq %rdi, %r8

    movq %rdx, %r9
    imulq $8, %r9
    addq %rdi, %r9

    movq (%r8), %r10
    movq (%r9), %r11
    movq %r11, (%r8)
    movq %r10, (%r9)

    addq $1, %rcx
    subq $1, %rdx
    jmp .Lreverse_loop

.Lreverse_done:
    ret

    .globl sensor_score
    .type sensor_score, @function





sensor_score:
    # TODO: Problem 3
    movslq 16(%rdi), %rax
    imulq 8(%rdi), %rax
    movslq 0(%rdi), %rdx
    addq %rdx, %rax
    ret


    .globl sensor_array_total
    .type sensor_array_total, @function
sensor_array_total:
    # TODO: Problem 4
    pushq %rbp
    movq %rsp, %rbp
    subq $32, %rsp

    movq %rdi, -8(%rbp)
    movq %rsi, -16(%rbp)
    movq $0, -24(%rbp)
    movq $0, -32(%rbp)

.Ltotal_loop:
    movq -24(%rbp), %rax
    cmpq -16(%rbp), %rax
    jge .Ltotal_done

    imulq $24, %rax
    addq -8(%rbp), %rax
    movq %rax, %rdi
    call sensor_score
    addq %rax, -32(%rbp)

    addq $1, -24(%rbp)
    jmp .Ltotal_loop

.Ltotal_done:
    movq -32(%rbp), %rax
    leave
    ret

    .globl make_arithmetic_sequence
    .type make_arithmetic_sequence, @function



make_arithmetic_sequence:
    # TODO: Problem 5
    cmpq $0, %rdx
    jle .Lsequence_null

    pushq %rbp
    movq %rsp, %rbp
    subq $32, %rsp

    movq %rdi, -8(%rbp)
    movq %rsi, -16(%rbp)
    movq %rdx, -24(%rbp)

    movq %rdx, %rdi
    imulq $8, %rdi
    call malloc
    cmpq $0, %rax
    je .Lsequence_done

    movq $0, %rcx
.Lsequence_loop:
    cmpq -24(%rbp), %rcx
    jge .Lsequence_done

    movq %rcx, %rdx
    imulq -16(%rbp), %rdx
    addq -8(%rbp), %rdx

    movq %rcx, %r8
    imulq $8, %r8
    addq %rax, %r8
    movq %rdx, (%r8)

    addq $1, %rcx
    jmp .Lsequence_loop
.Lsequence_done:
    leave
    ret
.Lsequence_null:
    movq $0, %rax
    ret



    .globl make_sensor
    .type make_sensor, @function
make_sensor:
    pushq %rbp
    movq %rsp, %rbp
    subq $32, %rsp

    movl %edi, -4(%rbp)
    movq %rsi, -16(%rbp)
    movl %edx, -20(%rbp)

    movq $24, %rdi
    call malloc
    cmpq $0, %rax
    je .Lsensor_done

    movl -4(%rbp), %edx
    movl %edx, 0(%rax)
    movq -16(%rbp), %rdx
    movq %rdx, 8(%rax)
    movl -20(%rbp), %edx
    movl %edx, 16(%rax)
.Lsensor_done:
    leave
    ret

    .globl sensor_destroy
    .type sensor_destroy, @function




sensor_destroy:
    # TODO: Problem 6B
    cmpq $0, %rdi
    je .Ldestroy_done

    pushq %rbp
    movq %rsp, %rbp
    call free
    leave
.Ldestroy_done:
    ret


    .section .note.GNU-stack,"",@progbits
