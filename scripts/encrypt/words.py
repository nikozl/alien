### PROGRAMA DE PYTHON QUE CREA TODAS LAS COMBINACIONES POSIBLES CON LAS LETRAS QUE INDIQUEMOS ###
### EJECUTAR Y EXPORTAR RESULTADO A FICHERO "PASS.TXT PARA EL SCRIPT DESTROY.SH ###

import itertools
res = itertools.product('abcdefghijkmlnopqrstuvwxyz', repeat=4) # 3 is the length of your result.
for i in res: 
    print ''.join(i)
