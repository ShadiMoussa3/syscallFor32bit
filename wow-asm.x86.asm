.686
.XMM
.MODEL flat, c
ASSUME fs:_DATA
.code

EXTERN SW3_GetSyscallNumber: PROC
EXTERN local_is_wow64: PROC
EXTERN internal_cleancall_wow64_gate: PROC

NtCreateFile PROC
		push ebp
		mov ebp, esp
		push 0D95D2139h                  ; Load function hash into ECX.
		call SW3_GetSyscallNumber
		lea esp, [esp+4]
		mov ecx, 0bh
	push_argument_D95D2139:
		dec ecx
		push [ebp + 8 + ecx * 4]
		jnz push_argument_D95D2139
		mov ecx, eax
		call local_is_wow64
		test eax, eax
		je is_native
		call internal_cleancall_wow64_gate
		push ret_address_epilog_D95D2139
		push ret_address_epilog_D95D2139
		xchg eax, ecx
		jmp ecx
		jmp finish
	is_native:
		mov eax, ecx
		push ret_address_epilog_D95D2139
		call do_sysenter_interrupt_D95D2139
	finish:
		lea esp, [esp+4]
	ret_address_epilog_D95D2139:
		mov esp, ebp
		pop ebp
		ret
	do_sysenter_interrupt_D95D2139:
		mov edx, esp
		sysenter
		ret
NtCreateFile ENDP

end