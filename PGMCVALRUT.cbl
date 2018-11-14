IDENTIFICATION DIVISION.   
PROGRAM-ID. PGMCVALRUT.     
DATA DIVISION.             
WORKING-STORAGE SECTION.   
    01 WS-VARIABLES.                                        
        02 WS-I                     	PIC  9(03).                          
        02 WS-FACTOR                	PIC  9(02).                          
        02 WS-SUMA                  	PIC  9(04).                          
        02 WS-COCIENTE              	PIC  9(04).                          
        02 WS-RESTO                 	PIC  9(03).                          
        02 WS-CEROS                 	PIC  X(10) VALUE '0000000000'.       
    01 VARIABLES-DE-CARACTER.                                       
        02 WS-D-V                   	PIC 9(02).                           
        02 WS-D-V-RED           REDEFINES WS-D-V.                              
            05 WS-D-V01                 	PIC 9.                               
            05 WS-D-V02                 	PIC 9.  
    01 WS-VAL-RUT.                                        
        02 WS-E-ENTRADA. 
            05 WS-OPCION            	PIC 9(01).                                    
            05 WS-E-RUT.                                   
                10 WS-D-RUT         	PIC 9(01) OCCURS 10 TIMES.
            05 WS-E-DIG             	PIC X(01).             
         02 WS-S-SALIDA.
            05 WS-S-RETORNO.
                10 WS-S-COD-ERROR     PIC 9(01).
                    88 WS-S-COD-RET-OK           	VALUE '0'.
					88 WS-S-ERR-ENT-ERROR           				VALUE '1'.
					88 WS-S-ERR-RUT                 				VALUE '2'.  
            05 WS-S-VAR-ERROR       	PIC X(30).                                                       
            05 WS-S-DIG             	PIC X(01).             
LINKAGE SECTION.                                                 
                                                    
PROCEDURE DIVISION.                            
    PERFORM 1-INICIO                                     
    PERFORM 2-PROCESO                                    
    PERFORM 3-FIN                                     
    .                                                             
1-INICIO.
    DISPLAY "*********************************************************"
    DISPLAY "*** AL INGRESAR EL RUT LLENAR CON CERO A LA IZQUIERDA ***"
    DISPLAY "*********************************************************"
    DISPLAY " "
    ACCEPT WS-E-ENTRADA
    DISPLAY ".- WS-OPCION        : " WS-OPCION. 
    DISPLAY ".- WS-E-RUT         : " WS-E-RUT.
    DISPLAY ".- WS-E-DIG         : " WS-E-DIG.                                                           
    INITIALIZE  WS-VARIABLES                             
                VARIABLES-DE-CARACTER                           
    SET WS-S-COD-RET-OK 				    TO TRUE
    .                                        
2-PROCESO.
    EVALUATE WS-OPCION
    WHEN 0
    WHEN 1
        IF WS-E-RUT > ZEROES          
            PERFORM 21-VALIDAR-RUT    
        ELSE                             
    	    SET WS-S-ERR-ENT-ERROR 		    TO TRUE 
    	    MOVE 'DEBE INFORMAR RUT' 		TO WS-S-VAR-ERROR 
    			PERFORM 3-FIN                
		END-IF                           
    WHEN OTHER
        SET WS-S-ERR-ENT-ERROR  			TO TRUE 
        MOVE 'DEBE INFORMAR OPCION 1 O 2' 
        									TO WS-S-VAR-ERROR 
        PERFORM 3-FIN
    END-EVALUATE
    .                                                      
21-VALIDAR-RUT.                                                   
    MOVE 0 									TO WS-SUMA                                            
    MOVE 1 									TO WS-FACTOR                                          
    PERFORM 22-CHEQUEO
    VARYING WS-I FROM 10 BY -1 
      UNTIL WS-I = 0   
        
        DIVIDE WS-SUMA 						BY 11 			
        								GIVING WS-COCIENTE 
                                     REMAINDER WS-RESTO   
     
        COMPUTE WS-D-V 					 EQUAL 11 - WS-RESTO                              
                                                                
     	IF WS-D-V EQUAL 10 
            MOVE 'K' 						TO WS-S-DIG                                    
        ELSE                                                         
        	IF WS-D-V EQUAL 11
            MOVE '0'  				        TO WS-S-DIG                                
        ELSE                                                      
           	MOVE WS-D-V02 				    TO WS-S-DIG                             
        END-IF                                                    
     END-IF                                                       
                                                                 
     IF WS-OPCION EQUAL 0
        IF WS-E-DIG EQUAL WS-S-DIG                               
           SET WS-S-COD-RET-OK              TO TRUE
        ELSE                                                      
           SET WS-S-ERR-RUT                 TO TRUE
           MOVE 'RUT INGRESADO NO ES VALIDO' 
        								    TO WS-S-VAR-ERROR
        END-IF                                                    
     ELSE                                                         
        MOVE WS-S-DIG 						TO WS-E-DIG                                 
     END-IF
     .                                                      
22-CHEQUEO.                                                         
     ADD 1 									TO WS-FACTOR                                          
                                                                
     IF WS-FACTOR EQUAL 8                                        
        MOVE 2 								TO WS-FACTOR                                       
     END-IF    
     
     COMPUTE WS-SUMA 						EQUAL WS-SUMA + WS-D-RUT (WS-I) 
                                                  * WS-FACTOR
     .     
 3-FIN. 
    DISPLAY ".- WS-S-COD-ERROR   : " WS-S-COD-ERROR.
    DISPLAY ".- WS-S-VAR-ERROR   : " WS-S-VAR-ERROR.
    DISPLAY ".- WS-S-DIG         : " WS-S-DIG.
    STOP RUN
    .        
