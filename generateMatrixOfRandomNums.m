function R= generateMatrixOfRandomNums(varargin)
    rng(6);
    
    if nargin == 0
        
        dims = [1, 1];
    elseif nargin == 1
        if isnumeric(varargin{1}) && isscalar(varargin{1})
            
            dims = [varargin{1}, varargin{1}];
        elseif isnumeric(varargin{1}) && isvector(varargin{1})
            
            dims = varargin{1};
        else
            error('Invalid input argument. Provide scalar, vector, or size of a matrix.');
        end
    elseif nargin > 1
        
        dims = cell2mat(varargin);
    else
        error('Invalid input argument.');
    end

    
    if ~all(dims > 0) || ~all(mod(dims, 1) == 0)
        error('Dimensions must be positive integers.');
    end
    R = zeros(dims);  % Initialize output array
    persistent seed;  % Persistent seed value
    a = 1664525;      % Multiplier for LCG
    c = 1013904223;   % Increment for LCG
    m = 2^32;         % Modulus for LCG

    
    if isempty(seed)
        seed = sum(100 * clock);  
    end

   
    for i = 1:numel(R)
        seed = mod(a * seed + c, m);  
        R(i) = seed / m;             
    end
end


