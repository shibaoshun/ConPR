function y = soft(x,T)

y = sign(x).*( max( 0, abs(x)-T ) );

end