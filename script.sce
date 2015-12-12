M = read('eaux.txt',57,8);

// matrice des poids
D = (1/57)*eye(57,57);

// vecteur centre de gravité
// on est dans le cas particulier où tous les poids sont identiques
g = mean(M,1);

// matrice centrée
M1 = M - repmat(g,57,1);

// vecteur de la variance
var = variance(M,1);

// matrice centrée réduite
M2 = M1.*repmat(ones(1,8)./sqrt(var),57,1);

// matrice de corrélation R
R = M2'*D*M2;

// calcul des valeurs propres et vecteurs propres de R
// les valeurs propres sont les éléments diagonaux de valPropres
// les vecteurs propres sont les colonnes de vectPropres
[vectPropres,valPropres] = spec(R);
valPropres = real(valPropres);

// calcul des 2 plus grandes valeurs propres et vecteurs propres associés
[lambda1,ind1] = max(valPropres);
valPropresTemp = valPropres;
valPropresTemp(ind1) = 0;
[lambda2,ind2] = max(valPropresTemp);
u1 = vectPropres(:,ind1(1));
u2 = vectPropres(:,ind2(1));

// calcul des coordonnées projetées
c1 = M2*u1;
c2 = M2*u2;

// représentation graphique sur le plan principal
close(figure(1));
figure(1);
plot(c1,c2,'d');

// pourcentage d'inertie exprimé par C1 et C2
p = (lambda1+lambda2)/sum(valPropres)*100;

// représentation du cercle des corrélations
close(figure(2));
figure(2);
teta=[0:2*%pi/200:2*%pi];
xx=cos(teta);yy=sin(teta);
plot(xx,yy);

// représentation des variables d'origine dans le cercle des corrélations
x1 = sqrt(lambda1)*u1;
x2 = sqrt(lambda2)*u2;
plot(x1(1),x2(1),'r+');
plot(x1(2),x2(2),'ro');
plot(x1(3),x2(3),'m+');
plot(x1(4),x2(4),'mo');
plot(x1(5),x2(5),'b+');
plot(x1(6),x2(6),'bo');
plot(x1(7),x2(7),'k+');
plot(x1(8),x2(8),'ko');
legend(['cercle des corrélations','variable 1','variable 2','variable 3','variable 4','variable 5','variable 6','variable 7']);
