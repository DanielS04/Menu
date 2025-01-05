function result = generateRandomNumberFromMinToMax(min,max)
    %from 0 to 1
    persistent seed;      
    a = 1664525;          
    c = 1013904223;       
    m = 2^32;             

    
    if isempty(seed)
        seed = sum(100*clock); 
    end

    seed = mod(a * seed + c, m);

    
     result = ((max-min)*seed / m)+min;
end 

