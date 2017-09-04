#include <stdio.h>

int main (void) {  // int main (void) es igual que poner int main()
	int var1,var2,resultado;
	var1=2;
	var2=11;
	//suma
	resultado=var1+var2;
	printf ("%d + %d = %d\n",var1,var2,resultado);
	//resta
	resultado=var2-var1;
	printf ("%d - %d = %d\n",var2,var1,resultado);
	//producto
	resultado=var1*var2;
	printf ("%d * %d = %d\n",var1,var2,resultado);
	//division entero
	resultado=var2/var1;
	printf ("%d / %d = %d\n",var2,var1,resultado);
	//resto de la division
	resultado=var2%var1;
	printf ("Resto de (%d / %d) = %d\n",var2,var1,resultado);
	return 0;
}
