function n1 = generateNormalDisrtNumber()
rng(4);
r1 = generateRandomNumer();
r2=generateRandomNumer();
n1 = sqrt(-2*log(r1)) .* cos(2*pi*r2);
end

