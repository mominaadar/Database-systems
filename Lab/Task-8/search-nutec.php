<?php
	include "connect-nutec.php";
?>

<!DOCTYPE html>
<html>
<head>
	<title>Registration Record</title>
</head>
<body>

	<h1 align='center'>Nutec'20 Event Record</h1>

	<form action="" method="post">
		<table align='center'>
			<th>Search by:</th>
			<tr>
				<td>
					<select name="var" required>
						<option value="r">Roll No</option>
						<option value="d">Department</option>
						<option value="e">Event</option>
					</select>
				</td>

				<tr></tr>
				<tr></tr>

				<td>
					<input type="text" name="txtData" value="" required>
				</td>

			</tr>

			<tr>
				<td colspan="2" align="right">
					<input type="submit" value="Search">
				</td>
			</tr>

		</table>		
	</form>

	<?php

		if(isset($_POST["txtData"])){
			$sel_val = $_POST['var'];
			

			if($sel_val == "r"){
				$roll = $_POST["txtData"];
				$qry = "SELECT * FROM reg_record WHERE rollno = '".$roll."'";
				$res = $con->query($qry);
				$result = "";

				if ($res->num_rows>0){
					$result .= "<table align='center'>";
					$result .= "<th>Roll No</th><th>Name</th><th>Email</th><th>Department</th><th>Event</th>";
					while ($row = $res->fetch_assoc()){
						$result .= "<tr>
										<td>
											".$row["rollno"]."
										</td>

										<td>
											".$row["name"]."
										</td>

										<td>
											".$row["email"]."
										</td>

										<td>
											".$row["dept"]."
										</td>

										<td>
											".$row["event"]."
										</td>


									</tr>";
					}
					$result .= "</table>";
				}
				echo $result;
			}


			if($sel_val == "d"){
				$dept = $_POST["txtData"];
				$qry = "SELECT * FROM reg_record WHERE dept = '".$dept."'";

				$res = $con->query($qry);
				$result = "";

				if ($res->num_rows>0){
					$result .= "<table align='center'>";
					$result .= "<th>Roll No</th><th>Name</th><th>Email</th><th>Department</th><th>Event</th>";
					while ($row = $res->fetch_assoc()){
						$result .= "<tr>
										<td>
											".$row["rollno"]."
										</td>

										<td>
											".$row["name"]."
										</td>

										<td>
											".$row["email"]."
										</td>

										<td>
											".$row["dept"]."
										</td>

										<td>
											".$row["event"]."
										</td>


									</tr>";
					}
					$result .= "</table>";
				}
				echo $result;

			}


			if($sel_val == "e"){
				$evt = $_POST["txtData"];
				$qry = "SELECT * FROM reg_record WHERE event = '".$evt."'";

				$res = $con->query($qry);
				$result = "";

				if ($res->num_rows>0){
					$result .= "<table align='center'>";
					$result .= "<th>Roll No</th><th>Name</th><th>Email</th><th>Department</th><th>Event</th>";
					while ($row = $res->fetch_assoc()){
						$result .= "<tr>
										<td>
											".$row["rollno"]."
										</td>

										<td>
											".$row["name"]."
										</td>

										<td>
											".$row["email"]."
										</td>

										<td>
											".$row["dept"]."
										</td>

										<td>
											".$row["event"]."
										</td>


									</tr>";
					}
					$result .= "</table>";
				}
				echo $result;

			}
			
		}




	?>

</body>
</html>
