

M = read('eaux.txt',57,8);

// matrice des poids
D = (1/57)*eye(57,57);

// vecteur centre de gravité
g = M'*D*ones(57,1);

// matrice centrée
M1 = M - ones(57,1)*g';

// calcul de la variance (vecteur ligne qu'on recopie)
var = variance(M,1);
var = ones(1,8)./var;
var = repmat(var,57,1);

// matrice centrée réduite
M2 = M1.*var;

// matrice de corrélation R
R = M1'*D*M1;

// calcul des valeurs propres et vecteurs propres de R
[vectPropres,valPropres] = spec(R);
valPropres = real(valPropres);

// calcul des coordonnées projetées
[lambda1,ind1] = max(valPropres);
valPropresTemp = valPropres;
valPropresTemp(ind1) = 0;
[lambda2,ind2] = max(valPropresTemp);
u1 = vectPropres(:,ind1(1));
u2 = vectPropres(:,ind2(1));
c1 = M2*u1;
c2 = M2*u2;

// représentation graphique sur le plan principal
figure(1)
plot(c1,c2,'d');

// pourcentage d'inertie exprimé par C1 et C2
p = (lambda1+lambda2)/sum(valPropres)*100;

// représentation du cercle des corrélations
figure(2)
teta=[0:2*%pi/200:2*%pi];
xx=cos(teta);yy=sin(teta);
plot(xx,yy);

// représentation des variables dans le cercle des corrélations
x1 = sqrt(lambda1)*u1;
x2 = sqrt(lambda2)*u2;
plot(x1,x2,'d');
n = norm(u1);
