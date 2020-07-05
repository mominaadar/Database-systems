<?php
	include "connect-nutec.php";

	$rollno = $_POST["txtRollNo"];
	$name = $_POST["txtName"];
	$email = $_POST["txtEmail"];
	$dept = $_POST["Dep"];
	$event = $_POST["Event"];

	$qry = "INSERT INTO reg_record VALUES('".$rollno."','".$name."','".$email."','".$dept."','".$event."')";

	if ($con->query($qry)){
		$msg = "Registration Done!";
	}
	else
		$msg = "Error!";

	header("Location:registration-form.php?Message=$msg")

?>