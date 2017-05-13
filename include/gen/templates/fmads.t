
[[{	
	// fmads
	float r0, r1;
	
	@mov!$0=r0,$1=$x;

	@fmad!$0=r0,$1=r1,$2=r0;
	@fmad!$0=r1,$1=r0,$2=r1;

	@mov!$0=$y,$1=r1;
	
}]]