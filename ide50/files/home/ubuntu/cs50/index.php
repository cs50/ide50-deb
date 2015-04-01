<!DOCTYPE html>

<html>
    <head>
        <title>hello, world</title>
    </head>
    <body>
        hello, world. Apache is successfully started! To access the sites in your vhosts directory, just try out these links!
        <table>
            <?php
            $dirs = scandir("/home/ubuntu/workspace/vhosts");
            foreach($dirs as $dir) {
                if ($dir != "." && $dir != ".."){
                echo '<tr><td><a href="https://'.getenv("C9_HOSTNAME").'/'.$dir.'/">https://'.getenv("C9_HOSTNAME").'/'.$dir.'/</a></td></tr>';
                }
            }
            ?>
        </table>
    </body>
</html>