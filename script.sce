M = read('eaux.txt',57,8);

// matrice des poids
D = (1/57)*eye(57,57);

// vecteur centre de gravité
g = M'*D*ones(57,1);

// matrice centrée
M1 = M - ones(57,1)*g';

var = variance(M,1);
var = ones(1,8)./var;
var = repmat(var,57,1);

// matrice centrée réduite
M2 = M1.*var;

