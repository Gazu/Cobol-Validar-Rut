# Cobol-Validar-Rut

Programa Cobol Validador Rut Chileno.

# Entrada
  - WS-OPCION: De largo 1.  Corresponde a la opcion, si necesita validar rut (Opción 1) ó Retornar Dígito Verificador (Opción 2).
  - WS-E-RUT : De largo 10. Corresponde al Rut a evaludar. (Se debe rellenar con ceros a la izquierda, EJ: 0017953789)
  - WS-E-DIG : De largo 1.  Corresponde al Digito Verificador (Solo se debe informar si la opcion fue 1)

# Salida
  - WS-S-RETORNO   : Codigo de retorno de la ejecucion del programa.
                     0 -> Ejecucion correcta.
                     1 -> Falto informar datos de entrada (Ver WS-S-VAR-ERROR)
                     2 -> Rut informado no es valido (Opción 1)
  - WS-S-VAR-ERROR : Descripción del error
  - WS-S-DIG       : Dígito verificador (Opción 2)
  
 # Ejecución
 
   En el siguiente [link](https://www.jdoodle.com/embed/v0/Ntb) podran compilar y ejecutar el código.
