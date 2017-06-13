### PROGRAMA DE PYTHON QUE CREA TODAS LAS COMBINACIONES POSIBLES CON LAS LETRAS QUE INDIQUEMOS ###
### EJECUTAR Y EXPORTAR RESULTADO A FICHERO "PASS.TXT PARA EL SCRIPT DESTROY.SH ### python words.py >> pass.txt

import itertools
res = itertools.product('abcdefghijkmlnopqrstuvwxyz', repeat=4) # 4 es la longitud que queremos que tenga pudiendo ser la que queramos.
for i in res: 
    print ''.join(i)
