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
		push 027BB370Fh                  ; Load function hash into ECX.
		call SW3_GetSyscallNumber
		lea esp, [esp+4]
		mov ecx, 0bh
	push_argument_27BB370F:
		dec ecx
		push [ebp + 8 + ecx * 4]
		jnz push_argument_27BB370F
		mov ecx, eax
		mov eax, ecx
		push ret_address_epilog_27BB370F
		call do_sysenter_interrupt_27BB370F
		lea esp, [esp+4]
	ret_address_epilog_27BB370F:
		mov esp, ebp
		pop ebp
		ret
	do_sysenter_interrupt_27BB370F:
		mov edx, esp
		sysenter
		ret
NtCreateFile ENDP

end