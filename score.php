<?php
// This version is compatible with PC^2 9.1 and 8.7 and 8.6
// (maybe with more versions too, but tested for these version)
	$bads = array("<u>", "</u>", "<strong>", "</strong>");
	$accepted = "#55FF55";
	$rejected = "#FF5555";

	// Problem Colors
	$prob_colors_back = Array("blue",  "orange", "pink",  "yellow", "silver", "violet", "red",   "purple", "#00bb00", "darkgreen", "black", "white");
	$prob_colors_fore = Array("white", "black",  "black", "black",  "black",  "black",  "black", "black",  "black",   "white",     "white", "black");

	$file = fopen("./summary.html", "r"); // Scoreboard Path and Filename
	if ( !$file ) die("Error in Opening Scoreboard!!");
	while( ($line = fgets($file)) != NULL )
	{
		if ( stristr($line, "title") ) $title = strip_tags($line);
		if ( stristr($line, "body") ) break;
	}
?>
<html>
<head>
<title><?php echo $title; ?></title>
<meta http-equiv="refresh" content="60">
<style>
table{ font-size : 11pt; background : gray; }
tr{ background : #F7F1EB; }
body{ font-size : 11pt; }
</style>
</head>
<body>
<?php
	$v9 = false;
	$line = fgets($file);
	if ( stripos($line, "table") === false ) die("Error in Parsing!!");
	echo "<table border='0' cellspacing='1' cellpadding='2'>\n";
	$line = fgets($file);
	if ( strpos($line, "strong") === false )
	{
		$v9 = true;
		$line = fgets($file);
		echo "<tr>\n";
		$tmp = fgets($file);
		$tmp = fgets($file);
		while( true )
		{
			$tmp = fgets($file);
			if ( strpos($tmp, "</tr>") !== false ) break;
		}
	}
	$n = substr_count($line, "<th>") - 5;
	$line = str_replace($bads, "", $line);
	$pre = strpos($line, "<th>");
	for( $i=0; $i<4; $i++ )
	{
		$cur = strpos($line, "<th>", $pre+1);
		$data = substr($line, $pre, $cur-$pre);
		$pre = $cur;
		echo $data;
	}
	for( $i=0; $i<$n; $i++ )
	{
		$cur = strpos($line, "<th>", $pre+1);
		$data = substr($line, $pre, $cur-$pre);
		$fore_color = $prob_colors_fore[$i];
		$back_color = $prob_colors_back[$i];
		$data = str_replace("<th>", "<th style='color:$fore_color;background:$back_color'>", $data);
		echo $data;
		$pre = $cur;
	}
	$data = substr($line, $pre);
	echo $data;
	if ( $v9 ) echo "</tr>\n";

	while( ($line = fgets($file)) != NULL )
	{
		if ( $v9 ) $line = fgets($file);
		if ( strpos($line, "Submitted") !== false ) break;
		echo "<tr>\n";
		$pre = strpos($line, "<td>");
		for( $i=0; $i<4; $i++ )
		{
			$cur = strpos($line, "<td>", $pre+1);
			$data = substr($line, $pre, $cur-$pre);
			$pre = $cur;
			echo $data;
		}
		for( $i=0; $i<$n; $i++ )
		{
			$cur = strpos($line, "<td>", $pre+1);
			$data = substr($line, $pre, $cur-$pre);
			sscanf($data, "<td>%d/", $att);
			if ( $att > 0 )
			{
				if ( $data[strpos($data, "/")+1]=="-" ) $color = $rejected;
				else $color = $accepted;
				echo "<td bgcolor='$color'>".substr($data, 4);
			} else echo $data;
			$pre = $cur;
		}
		$data = substr($line, $pre);
		echo $data;
		if ( $v9 )
		{
			$tmp = fgets($file);
			echo "</tr>\n";
		}
	}
	if ( $v9 ) echo "<tr>";
	if ( strpos($line, "cellw") !== false ) echo substr($line, 32);
	else echo $line;
	if ( $v9 ) echo "</tr>\n";
?>
</table>
<br><br>Last Updated : <?php echo date('l, jS \of F Y, h:i:s A'); ?>
<br><div style="color:#cccccc">Written by Saeed Nejati</div>
</body>
</html>
