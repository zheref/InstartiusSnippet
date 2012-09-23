<?php

class Usuario extends AppModel
{
    public $name = 'Usuario';
    
    public $hasMany = array
    (
        'Problemas' => array
        (
            'className' => 'Problema',
            'foreignKey' => 'USUARIO_NICKNAME'
        )
        
        ,

        'Soluciones' => array
        ( 
            'className' => 'Solucion',
            'foreignKey' => 'USUARIO_NICKNAME'
        )
        
        ,

        'Comentarios' => array
        ( 
            'className' => 'Comentario',
            'foreignKey' => 'USUARIO_NICKNAME'
        )
    );
}    

?>