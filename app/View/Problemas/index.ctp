<!-- File: /app/View/Usuarios/index.ctp -->
<h1>Problemas</h1>

<table>
    <tr>
        <th>Código</th>
        <th>Enunciado</th>
    </tr>

<?php foreach ($problemas as $problema) : ?>
    <tr>
        <td>
            <?php echo $problema['Problema']['PRO_ID']; ?>
        </td>
        <td>
            <?php echo $problema['Problema']['STATEMENT']; ?>
        </td>
    </tr>
<?php endforeach; ?>
<?php unset($problema); ?>

</table>
<u>
</u>