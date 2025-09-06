% For my Junko F. Didi and Shree DR.MDD

-module(complex_numbers).
-export([abs/1, add/2, conjugate/1, divide/2, equal/2, exp/1, imaginary/1, mul/2, new/2,
	 real/1, sub/2, test_version/0]).

-record(complex_num, {real=0, imag=0}).

abs(#complex_num{real=Re, imag=Im}) -> math:sqrt(Re*Re+Im*Im).

add(#complex_num{real=R1, imag=I1}, #complex_num{real=R2, imag=I2}) -> #complex_num{real=R1+R2, imag=I1+I2}.

conjugate(Z=#complex_num{imag=I}) -> Z#complex_num{imag=-I}.

divide(#complex_num{real=R1, imag=I1}, #complex_num{real=R2, imag=I2}) ->
    Den = R2*R2 + I2*I2,
    #complex_num{real=(R1*R2+I1*I2)/Den, imag=(I1*R2-R1*I2)/Den}.

equal(#complex_num{real=R1, imag=I1}, #complex_num{real=R2, imag=I2}) ->
    erlang:abs(R1-R2) < 0.005 andalso erlang:abs(I1-I2) < 0.005.

exp(#complex_num{real=R, imag=I}) ->
    mul(#complex_num{real=math:exp(R), imag=0}, #complex_num{real=math:cos(I), imag=math:sin(I)}).

imaginary(#complex_num{imag=I}) -> I.

mul(#complex_num{real=R1, imag=I1}, #complex_num{real=R2, imag=I2}) ->
    #complex_num{real=R1*R2-I1*I2, imag=I1*R2+R1*I2}.

new(Re, Im) -> #complex_num{real=Re, imag=Im}.

real(#complex_num{real=R}) -> R.

sub(#complex_num{real=R1, imag=I1}, #complex_num{real=R2, imag=I2}) -> #complex_num{real=R1-R2, imag=I1-I2}.

test_version() -> 1.
