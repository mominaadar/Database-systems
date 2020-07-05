<?php
	include "connect-nutec.php";
?>
<!DOCTYPE html>
<html>
<head>
	<title>Nutec'20 Event Registration For Fastians</title>
</head>
<body>
	<h1>Nutec'20 Event Registration For Fastians</h1>

	<form action="reg-form-q.php" method="post">
		<table align='left'>

			<tr>
				<td>Roll No</td>
				<td><input type="text" name="txtRollNo" required></td>
			</tr>

			<tr>
				<td>Name</td>
				<td><input type="text" name="txtName" required></td>
			</tr>

			<tr>
				<td>Email</td>
				<td><input type="text" name="txtEmail" required></td>
			</tr>
			
			<tr>
				<td>Department</td>
				<td>
				<select name="Dep" required>
					<option value="CS">Computer Science</option>
					<option value="EE">Electrical Engineering</option>
				</select>
				</td>
			</tr>

			<tr>
				<td>Event</td>
				<td>
				<select name="Event" required>
					<option value="Speed Programming">Speed Programming</option>
					<option value="Debate Competition">Debate Competition</option>
					<option value="Ludo">Ludo</option>
					<option value="Tekken 5">Tekken 5</option>
					<option value="Sparlay">Colors of Sparlay</option>
				</select>
				</td>
			</tr>

			<tr>
				<td colspan='2' align='left'>
					<input type="submit" value="Submit">
				</td>
			</tr>

			<tr>
				<td colspan='2'>
					<?php
						if (isset($_GET["Message"])){
							echo $_GET["Message"];
						}
					?>
				</td>
			</tr>

		</table>

	</form>

</body>
</html>