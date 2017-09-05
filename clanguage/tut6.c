#include <stdio.h>

//Area de un triangulo
//area = (base*altura)/2

int main(void) {
	float base,altura,area;
	base=5.25;
	altura=17.32;
	area=base*altura/2;
	printf ("Base: %g Altura: %g Area: %g\n",base,altura,area); //Ponemos %g en vez de %f para eliminar los ceros que sobran

	return 0;
}
