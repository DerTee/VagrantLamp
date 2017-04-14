<!DOCTYPE html>
<html>
<head>
	<title>Vagrant LAMP - MySQLi Example</title>
	<link rel="stylesheet" href="css/main.css" type="text/css">
</head>
<body>
	<div class="header"><h1>MySQLi Example</h1></div>
	<div class="content">
<?php
	$db = new mysqli('localhost', 'root', 'root', '','3306');
	var_dump($db);
?>
	</div>
	<div class="footer"></div>
</body>
</html>