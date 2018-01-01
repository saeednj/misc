<?php
$command = $_GET['command'];
$cmd = explode(" ", $command);
switch($cmd[0])
{
case "help" :
	echo "<table border='0' cellpadding='2' cellspacing='0'>".
		"<tr><td width='150px'><b><i>help</b></i></td><td>Prints this text..</td></tr>".
		"<tr><td width='150px'><b><i>clear</b></i></td><td>Clears the screen..</td></tr>".
		"<tr><td width='150px'><b><i>ls</b></i></td><td>Prints a list of files..</td></tr>".
		"<tr><td width='150px'><b><i>whoami</b></i></td><td>Prints a little information about me..</td></tr>".
		"<tr><td width='150px'><b><i>echo</b></i></td><td>Prints back the given string..</td></tr>".
		"</table>";
	break;
case "ls" :
	system('ls');
	break;
case "whoami" :
	echo "<table border='0' cellpadding='2' cellspacing='0'>".
		"<tr><td width='150px'><b>Name</b></td><td><a href='http://ece.uwaterloo.ca/~snejati'>Saeed Nejati</a></td></tr>".
		"<tr><td width='150px'><b>Education</b></td><td>PhD student @ University of Waterloo</td></tr>".
		"<tr><td width='150px'><b>Birth Date</b></td><td>10 Jan 1984</td></tr>".
		"<tr><td width='150px'><b>E-Mail</b></td><td>nejati@gmail.com</td></tr>".
		"</table>";
    break;
case "echo":
    $cp_cmd = $cmd;
    unset($cp_cmd[0]);
    echo "<pre>" . implode(" ", $cp_cmd) . "</pre>";
    break;
default :
	echo "Unknown Command.. <br>";
}
?>
