function R= generateMatrixOfRandomNums(varargin)
    rng(56);
    if nargin == 1
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
    R = zeros(dims);  
    for i = 1:numel(R)
        R(i) = generateRandomNumer();         
    end
end


