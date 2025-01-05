function result = generateRandomNumer()
    %from 0 to 1
    rng(6);
    persistent seed;      
    a = 1664525;          
    c = 1013904223;       
    m = 2^32;             

    
    if isempty(seed)
        seed = sum(100*clock); 
    end

    seed = mod(a * seed + c, m);

    
     result = seed / m;
end




