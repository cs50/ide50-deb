<!DOCTYPE html>

<?php
    if (getenv("IDE_OFFLINE") == "1")
        $host = "http://";
    else
        $host = "https://";
    $host .= trim(shell_exec("hostname50"));
?>

<html>
    <head>
        <title>hello, world</title>
    </head>
    <body>
        hello, world. Apache is successfully started!<br /><br />
        To access the sites in your vhosts directory, just try out these links!
        <table>
            <?php
            $dirs = scandir("/home/ubuntu/workspace/vhosts");
            foreach($dirs as $dir) {
                if ($dir != "." && $dir != ".."){
                    $url = $host.'/'.$dir.'/';
                    echo "<tr><td><a href=\"$url\">$url</a></td></tr>";
                }
            }
            ?>
        </table>
        <br />
        You can find phpMyAdmin here:
        <?php
            $pma = $host.'/phpmyadmin/';
            echo "<a href=\"$pma\">$pma</a>";
        ?>
    </body>
</html>
