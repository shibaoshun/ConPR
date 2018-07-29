function [W]= normcoef(W,L,nor)

%本函数的作用是输入W将W除以nor的值
for scale = 1:L
    for part = 1:2
	for dir = 1:2
		for dir1 = 1:3
			W{scale}{part}{dir}{dir1} = W{scale}{part}{dir}{dir1}/nor{scale}{part}{dir}{dir1};
		end
	end
    end
end
