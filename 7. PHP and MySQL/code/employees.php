<?php 

// Show all employees on the employees table

require_once('connection.php');

global $conn;

$stmt = $conn->prepare("SELECT employee_id, first_name, last_name
                        FROM employees
                        ORDER BY first_name, last_name");
$stmt->execute();

?>

<table style='border: solid 1px black;'>
<thead>
	<tr>
    	<th>ID</th>
    	<th>First name</th>
    	<th>Last name</th>
	</tr>
</thead>
<tbody>

<?php 
while ($row = $stmt->fetch()) {
    echo "<tr>
             <td>$row[employee_id]</td>
             <td>$row[first_name]</td>
             <td>$row[last_name]</td>
          </tr>";
}
?>

</tbody>
</table>

