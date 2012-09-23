<?php

class UsuariosController extends AppController
{
    public $helpers = array('Html', 'Form');

    public function index()
    {
        $list = $this -> Usuario -> find('all');
        $this -> set( 'usuarios', $list );
    }
}

?>