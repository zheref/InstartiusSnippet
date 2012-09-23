<?php

class ProblemasController extends AppController
{
    public $helpers = array('Html', 'Form');
    
    public function index()
    {
        $list = $this -> Problema -> find('all');
        $this -> set( 'problemas', $list );
    }
}

?>